import requests
import os
import subprocess
import glob
import pandas as pd
import argparse

def fetch_top_crates(pages):
    crates = []
    for i in range(1,pages):
        url = f"https://crates.io/api/v1/crates?sort=downloads&per_page=100&page={i}"
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            new = ([(crate['id'], crate['repository']) for crate in data['crates']])
            crates = crates + new
        else:
            print(f"Failed to fetch crates: {response.status_code}")
            return []

    return crates

def clone_and_build_crate_source(crate):
    path = f"./crates/{crate[0]}"
    if crate[1] is not None and crate[1].count('/') < 5 and crate[1].find("github") > -1:
        subprocess.run(['git', 'clone', '--quiet', str(crate[1]), path], capture_output=True)
        os.chdir(path)
        subprocess.run(['cargo', 'build', '--quiet'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        os.chdir("../../")
    elif crate[1] is not None:
        parts = crate[1].split('/')
        url = '/'.join(parts[0:5])

        delete = ['tree', 'master', 'main']
        repo = '/'.join([i for i in parts[5:] if i not in delete])

        result = subprocess.run(['git', 'clone', '--quiet', str(url), path], capture_output=True)
        
        if result.stdout is not None:
            dir = os.getcwd()
            try:
                os.chdir(f'{path}/{repo}')
                subprocess.run(['cargo', 'build', '--quiet'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                os.chdir(dir)
            except: 
               print(f'Cannot access {crate[1]} repository') 
        else:
            print(f'Cannot clone {crate[1]} repository')

def measure_loc(crate_name, language):
    path = f"./crates/{crate_name}"
    cmd = ['loc', path]
    ps = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    cmd = ['grep', language]
    grep = subprocess.Popen(cmd, stdin=ps.stdout, stdout=subprocess.PIPE,
                            encoding='utf-8')
    ps.stdout.close()
    output, _ = grep.communicate()
    result = output.split('\n')
    if len(result) > 1:
        return result

def search_inline_asm(crate_name):
    """Search source files for asm! and global_asm! macro invocations."""
    path = f"./crates/{crate_name}"
    results = {}
    for pattern in ['asm!', 'global_asm!']:
        try:
            result = subprocess.run(
                ['grep', '-r', '--include=*.rs', '-l', pattern, path],
                capture_output=True, encoding='utf-8'
            )
            files = [f for f in result.stdout.strip().split('\n') if f]
            count_result = subprocess.run(
                ['grep', '-r', '--include=*.rs', '-c', pattern, path],
                capture_output=True, encoding='utf-8'
            )
            total = sum(
                int(line.split(':')[-1])
                for line in count_result.stdout.strip().split('\n')
                if line and ':' in line
            )
            results[pattern] = {'files': len(files), 'occurrences': total}
        except Exception:
            results[pattern] = {'files': 0, 'occurrences': 0}
    return results

def measure_generated_asm(crate_name):
    """Count assembly files (.s, .S, .asm) generated in the build directory."""
    build_path = f"./crates/{crate_name}/target/debug/build"
    if not os.path.isdir(build_path):
        return None
    asm_files = []
    for ext in ('*.s', '*.S', '*.asm'):
        asm_files.extend(glob.glob(os.path.join(build_path, '**', ext), recursive=True))
    if not asm_files:
        return None
    total_lines = 0
    for f in asm_files:
        try:
            with open(f, 'r', errors='ignore') as fh:
                total_lines += sum(1 for _ in fh)
        except Exception:
            pass
    return {'files': len(asm_files), 'lines': total_lines}

def measure_loc_in_build(crate_name, language):
    path = f"./crates/{crate_name}/target/debug/build"
    cmd = ['loc', path]
    ps = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    cmd = ['grep', language]
    grep = subprocess.Popen(cmd, stdin=ps.stdout, stdout=subprocess.PIPE,
                            encoding='utf-8')
    ps.stdout.close()
    output, _ = grep.communicate()
    result = output.split('\n')
    if len(result) > 1:
        return result

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description = 'Tool to parse pages of Crates.io, download the repositories for each, and collect number of lines of Assembly in the source code and build.')
    parser.add_argument("pages", type=int, help = "Number of crates.io pages to parse")
    parser.add_argument("-d", "--delete", action='store_true', help = "Delete crates locally after parsing")
    args = parser.parse_args() 

    top_crates = fetch_top_crates(args.pages+1)
    num = len(top_crates)
    print(f"Fetched {num} crates.")

    os.makedirs('./crates', exist_ok=True)
    os.makedirs('./data', exist_ok=True)
    os.makedirs(f'./data/top-{len(top_crates)}', exist_ok=True)

    crates = []
    built_crates = []
    inline_asm_crates = []
    generated_asm_crates = []

    print("Iterating through fetched crates...")
    for crate in top_crates:
        print(crate[0])
        clone_and_build_crate_source(crate)
        result = measure_loc(crate[0], 'Assembly')
        if result is not None:
            print(f'Assembly found in {crate[0]}')
            crates = crates + [ [crate[0]] + result[0].split()]

        # Search for inline assembly macros in source
        inline = search_inline_asm(crate[0])
        asm_files = inline['asm!']['files']
        asm_occ = inline['asm!']['occurrences']
        gasm_files = inline['global_asm!']['files']
        gasm_occ = inline['global_asm!']['occurrences']
        if asm_occ > 0 or gasm_occ > 0:
            print(f'Inline asm in {crate[0]}: asm!={asm_occ} global_asm!={gasm_occ}')
            inline_asm_crates.append([
                crate[0], asm_files, asm_occ, gasm_files, gasm_occ
            ])

        result = measure_loc_in_build(crate[0], 'Assembly')
        if result is not None:
            print(f'Assembly found in build of {crate[0]}')
            built_crates = built_crates + [ [crate[0]] + result[0].split()]

        # Measure generated .s/.S/.asm files in build output
        gen = measure_generated_asm(crate[0])
        if gen is not None:
            print(f'Generated asm in build of {crate[0]}: {gen["files"]} files, {gen["lines"]} lines')
            generated_asm_crates.append([crate[0], gen['files'], gen['lines']])

        if args.delete:
            subprocess.run(['rm', '-rf', f'./crates/{crate[0]}'])

    if args.delete:
        print("Downloaded crates deleted from crates/")

    out = f'./data/top-{len(top_crates)}'
    print(f'Done iterating, building df and saving to {out}')
    df1 = pd.DataFrame(crates, columns=['Crate', 'Language', 'Files', 'Lines', 'Blank', 'Comment', 'Code' ])
    df1.to_csv(f'{out}/loc-code.csv')

    df2 = pd.DataFrame(built_crates, columns=['Crate', 'Language', 'Files', 'Lines', 'Blank', 'Comment', 'Code' ])
    df2.to_csv(f'{out}/loc-build.csv')

    df3 = pd.DataFrame(inline_asm_crates, columns=['Crate', 'asm!_files', 'asm!_occurrences', 'global_asm!_files', 'global_asm!_occurrences'])
    df3.to_csv(f'{out}/inline-asm.csv')

    df4 = pd.DataFrame(generated_asm_crates, columns=['Crate', 'Generated_asm_files', 'Generated_asm_lines'])
    df4.to_csv(f'{out}/generated-asm.csv')
    
