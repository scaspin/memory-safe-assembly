use serde_json::Value;
use std::collections::BTreeSet;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

pub struct FeatureRequest {
    pub features: Vec<String>,
    pub all_features: bool,
    pub no_default_features: bool,
}

impl FeatureRequest {
    fn cargo_flags(&self) -> Vec<String> {
        let mut flags = Vec::new();
        if !self.features.is_empty() {
            flags.push("--features".to_string());
            flags.push(self.features.join(","));
        }
        if self.all_features {
            flags.push("--all-features".to_string());
        }
        if self.no_default_features {
            flags.push("--no-default-features".to_string());
        }
        flags
    }
}

pub struct Package {
    pub id: String,
    pub name: String,
    pub manifest: PathBuf,
    pub target_directory: PathBuf,
    feature_table: serde_json::Map<String, Value>,
}

pub fn package(crate_dir: &Path) -> Result<Package, String> {
    let manifest = crate_dir
        .join("Cargo.toml")
        .canonicalize()
        .map_err(|error| format!("{}: {error}", crate_dir.display()))?;
    let output = Command::new("cargo")
        .args(["metadata", "--no-deps", "--format-version", "1"])
        .arg("--manifest-path")
        .arg(&manifest)
        .stderr(Stdio::inherit())
        .output()
        .map_err(|error| format!("cargo metadata: {error}"))?;
    if !output.status.success() {
        return Err("cargo metadata failed".to_string());
    }
    let metadata: Value = serde_json::from_slice(&output.stdout)
        .map_err(|error| format!("cargo metadata: {error}"))?;
    let target_directory = PathBuf::from(metadata["target_directory"].as_str().unwrap_or("target"));
    let package = metadata["packages"]
        .as_array()
        .into_iter()
        .flatten()
        .find(|package| package["manifest_path"].as_str().map(Path::new) == Some(&manifest))
        .ok_or_else(|| format!("no package with manifest {}", manifest.display()))?;
    Ok(Package {
        id: package["id"].as_str().unwrap_or_default().to_string(),
        name: package["name"].as_str().unwrap_or_default().to_string(),
        manifest,
        target_directory,
        feature_table: package["features"].as_object().cloned().unwrap_or_default(),
    })
}

impl Package {
    pub fn enabled_features(&self, request: &FeatureRequest) -> BTreeSet<String> {
        let mut pending: Vec<String> = if request.all_features {
            self.feature_table.keys().cloned().collect()
        } else {
            request.features.clone()
        };
        if !request.no_default_features && self.feature_table.contains_key("default") {
            pending.push("default".to_string());
        }
        let mut enabled = BTreeSet::new();
        while let Some(feature) = pending.pop() {
            if feature.contains(['/', ':']) || !enabled.insert(feature.clone()) {
                continue;
            }
            if let Some(implied) = self.feature_table.get(&feature).and_then(Value::as_array) {
                pending.extend(implied.iter().filter_map(Value::as_str).map(str::to_string));
            }
        }
        enabled
    }

    pub fn build_script_out_dir(
        &self,
        target: Option<&str>,
        request: &FeatureRequest,
    ) -> Result<PathBuf, String> {
        let mut command = Command::new("cargo");
        command
            .args(["check", "--release", "--message-format=json"])
            .arg("--manifest-path")
            .arg(&self.manifest)
            .args(["-p", &self.name])
            .args(request.cargo_flags())
            .env("BUMS_SKIP", "1")
            .env("CARGO_TARGET_DIR", self.target_directory.join("bums-check"))
            .stdout(Stdio::piped())
            .stderr(Stdio::inherit());
        if let Some(target) = target {
            command.args(["--target", target]);
        }
        eprintln!(
            "bums-check: running the build script of {} (cargo check with BUMS_SKIP=1)",
            self.name
        );
        let output = command
            .output()
            .map_err(|error| format!("cargo check: {error}"))?;
        let out_dir = String::from_utf8_lossy(&output.stdout)
            .lines()
            .filter_map(|line| serde_json::from_str::<Value>(line).ok())
            .filter(|message| {
                message["reason"] == "build-script-executed" && message["package_id"] == self.id
            })
            .find_map(|message| message["out_dir"].as_str().map(PathBuf::from));
        out_dir.ok_or_else(|| {
            format!(
                "cargo check did not report the build script output of {}; pass --asm-dir",
                self.name
            )
        })
    }
}
