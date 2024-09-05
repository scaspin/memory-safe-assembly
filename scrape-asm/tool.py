import requests
import os
import subprocess
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

    print("Iterating through fetched crates...")
    for crate in top_crates:
        print(crate[0])
        clone_and_build_crate_source(crate)
        result = measure_loc(crate[0], 'Assembly')
        if result is not None:
            print(f'Assembly found in {crate[0]}')
            crates = crates + [ [crate[0]] + result[0].split()]
        
        result = measure_loc_in_build(crate[0], 'Assembly')
        if result is not None:
            print(f'Assembly found in build of {crate[0]}')
            built_crates = built_crates + [ [crate[0]] + result[0].split()]

        if args.delete:
            subprocess.run(['rm', '-rf', f'./crates/{crate[0]}'])

    if args.delete:
        print("Downloaded crates deleted from crates/")

    print(f'Done iterating, building df and saving to data/top-{len(top_crates)}')
    df1 = pd.DataFrame(crates, columns=['Crate', 'Language', 'Files', 'Lines', 'Blank', 'Comment', 'Code' ])
    df1.to_csv(f'./data/top-{len(top_crates)}/loc-code.csv')

    df2 = pd.DataFrame(built_crates, columns=['Crate', 'Language', 'Files', 'Lines', 'Blank', 'Comment', 'Code' ])
    df2.to_csv(f'./data/top-{len(top_crates)}/loc-build.csv')
    
