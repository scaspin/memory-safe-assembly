import requests
import os
import subprocess
import pandas as pd
import datetime

def fetch_top_crates(pages):
    crates = []
    for i in range(1,pages):
        url = f"https://crates.io/api/v1/crates?sort=downloads&per_page=100&page={i}"
        response = requests.get(url)
        if response.status_code == 200:
            data = response.json()
            new = ([(crate['id'], crate['repository']) for crate in data['crates']])
            # TODO: build in parallel so that we can support all the windows-rs crates
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

def measure_assembly_loc_in_build(crate_name):
    path = f"./crates/{crate_name}/target/debug/build"
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

def erase_repos(crates):
    subprocess.run(['rm', '-rf', './crates'])

if __name__ == "__main__":
    top_crates = fetch_top_crates(6)
    num = len(top_crates)
    print(f"Fetched {num} crates.")

    os.makedirs('./crates', exist_ok=True)
    os.makedirs('./data', exist_ok=True)

    crates = []
    built_crates = []

    print("Iterating through fetched crates...")
    for crate in top_crates:
        print(crate[0])
        clone_and_build_crate_source(crate)
        result = measure_assembly_loc(crate[0])
        if result is not None:
            print(f'Assembly found in {crate[0]}')
            crates = crates + [ [crate[0]] + result[0].split()]
        
        result = measure_assembly_loc_in_build(crate[0])
        if result is not None:
            print(f'Assembly found in build of {crate[0]}')
            built_crates = built_crates + [ [crate[0]] + result[0].split()]
        
        # subprocess.run(['rm', '-rf', f'./crates/{crate[0]}'])

    os.mkdir(f'./data/top-{len(top_crates)}')

    print(f'Done iterating, building df and saving to data/top-{len(top_crates)}')
    df1 = pd.DataFrame(crates, columns=['Crate', 'Language', 'Files', 'Lines', 'Blank', 'Comment', 'Code' ])
    df1.to_csv(f'./data/top-{len(top_crates)}/loc-code.csv')

    df2 = pd.DataFrame(built_crates, columns=['Crate', 'Language', 'Files', 'Lines', 'Blank', 'Comment', 'Code' ])
    df2.to_csv(f'./data/top-{len(top_crates)}/loc-build.csv')
    
    # erase_repos(top_crates)
