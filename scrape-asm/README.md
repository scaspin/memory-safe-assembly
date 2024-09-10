# Crate Scraper

Tool to measure how much  assembly is used by top crates.
Pulls pages of the top crates from crates.io, downloads each crate's source code if available, and measures lines of code of assembly in the source code and the build.
The results are saved in ```data/```.

### Usage:
```python3 tool.py \<pages\> -d```

where -d or --delete deletes crates after downloading/analyzing them to minimize memory usage
