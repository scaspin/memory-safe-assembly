import requests
import os
import subprocess
import pandas as pd

def fetch_top_crates(pages):
    crates = []
    for i in range(1,pages):
        url = f"https://crates.io/api/v1/crates?sort=downloads&per_page=100&page={i}"
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            new = ([(crate['id'], crate['repository']) for crate in data['crates'] if 'windows' not in crate['id']])
            # TODO: build in parallel so that we can support all the windows-rs crates
            crates = crates + new
        else:
            print(f"Failed to fetch crates: {response.status_code}")
            return []

    return crates

def clone_crate_source(crate):
    path = f"./crates/{crate[0]}"
    if crate[1] is not None and crate[1].count('/') < 5:
        subprocess.run(['git', 'clone', '--quiet', str(crate[1]), path], capture_output=True)
        os.chdir(path)
        subprocess.run(['cargo', 'build', '--quiet'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        os.chdir("../../")
    # else:
        # TODO: get access to crates in nested repos

def measure_assembly_loc(crate_name):
    path = f"./crates/{crate_name}"
    cmd = ['loc', path]
    ps = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    cmd = ['grep', 'Assembly']
    grep = subprocess.Popen(cmd, stdin=ps.stdout, stdout=subprocess.PIPE,
                            encoding='utf-8')
    ps.stdout.close()
    output, _ = grep.communicate()
    result = output.split('\n')
    if len(result) > 1:
        return result

    # TODO: measure loc in build target too
    # current example: took says ring has 2761 lines of assembly
    # but running loc on target/debug/build/ring-42faf0beaa4bd910
    # says there are actually 12625 loc

def erase_repos(crates):
    subprocess.run(['rm', '-rf', './crates'])

if __name__ == "__main__":
    top_crates = fetch_top_crates(20)
    print(f"Fetched {len(top_crates)} crates.")

    os.makedirs('./crates', exist_ok=True)

    crates = []
    print("Iterating through fetched crates...")
    for crate in top_crates:
        clone_crate_source(crate)
        result = measure_assembly_loc(crate[0])
        if result is not None:
            print(f'Assembly found in {crate[0]}')
            crates = crates + [ [crate[0]] + result[0].split()]
    
    print('Done iterating, building df and saving to asm_data.csv')
    df = pd.DataFrame(crates, columns=['Crate', 'Language', 'Files', 'Lines', 'Blank', 'Comment', 'Code' ])
    df.to_csv('./asm_data.csv')
    
    # erase_repos(top_crates)
