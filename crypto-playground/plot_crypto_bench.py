import re
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from decimal import Decimal

# File containing Rust nightly bench results
BENCH_FILE = "bench_results.txt"

# Function to parse the bench results
def parse_bench_results(file_path):
    data = []
    with open(file_path, 'r') as f:
        print(f)
        for line in f:
            if "bench:" in line:
                parts = line.split("...")
                name = parts[0].strip().split(" ")[1].split("::")[2]
                stats = parts[1].strip().split("bench:")[1].strip()
                mean_str, std_dev_str = stats.split("(+/-")
                print(stats)
                mean = round(Decimal(mean_str.replace("ns/iter", "").replace(",", "").strip()), 3)
                std_dev = round(Decimal(std_dev_str.replace(")", "").replace(",", "").strip()), 3)
                data.append({"name": name, "mean": mean, "std_dev": std_dev})
    return pd.DataFrame(data)

def plot_group_asm(df, title, filename):
    plt.figure()
    # print(df)
    x = np.arange(7)
    width = 0.4

    # plt.bar(0, 1- df['mean'].values[1]/df['mean'].values[0], width,  color='#1f77b4')
    # plt.bar(1, 1-df['mean'].values[3]/df['mean'].values[2], width,  color='#1f77b4')
    # plt.bar(2, 1-df['mean'].values[5]/df['mean'].values[4], width,  color='#1f77b4')
    # plt.bar(3, 1-df['mean'].values[7]/df['mean'].values[6], width,  color='#1f77b4')
    # plt.bar(4, 1-df['mean'].values[9]/df['mean'].values[8], width,  color='#1f77b4')
    # plt.bar(5, 1-df['mean'].values[11]/df['mean'].values[10], width,  color='#1f77b4')

    patterns = [ "/", "o","+", "*" ]

    plt.bar(0-0.2, df['mean'].values[1], width,yerr=df["std_dev"].values[1], capsize=5, color='#ff7f0e', hatch=patterns[0])
    plt.bar(0+0.2, df['mean'].values[0], width, yerr=df["std_dev"].values[0],capsize=5,  color='#1f77b4', hatch=patterns[1]) 

    plt.bar(1-0.2, df['mean'].values[3], width,yerr=df["std_dev"].values[3], capsize=5, color='#ff7f0e', hatch=patterns[0])
    plt.bar(1+0.2, df['mean'].values[2], width, yerr=df["std_dev"].values[2], capsize=5, color='#1f77b4', hatch=patterns[1])  

    plt.bar(2-0.2, df['mean'].values[5], width,yerr=df["std_dev"].values[5], capsize=5, color='#ff7f0e', hatch=patterns[0])
    plt.bar(2+0.2, df['mean'].values[4], width,yerr=df["std_dev"].values[4], capsize=5, color='#1f77b4', hatch=patterns[1]) 

    plt.bar(3-0.2, df['mean'].values[8], width,yerr=df["std_dev"].values[8], capsize=5, color='#ff7f0e', hatch=patterns[0])
    plt.bar(3+0.2, df['mean'].values[6], width,yerr=df["std_dev"].values[6], capsize=5, color='#1f77b4', hatch=patterns[1])    

    plt.bar(4-0.2, df['mean'].values[9], width,yerr=df["std_dev"].values[9], capsize=5, color='#ff7f0e', hatch=patterns[0])     
    plt.bar(4+0.2, df['mean'].values[7], width,yerr=df["std_dev"].values[7], capsize=5, color='#1f77b4', hatch=patterns[1])    

    plt.bar(5-0.2, df['mean'].values[11], width,yerr=df["std_dev"].values[11], capsize=5, color='#ff7f0e', hatch=patterns[0])
    plt.bar(5+0.2, df['mean'].values[10], width,yerr=df["std_dev"].values[10], capsize=5, color='#1f77b4', hatch=patterns[1]) 

    plt.bar(6-0.2, df['mean'].values[13], width,yerr=df["std_dev"].values[13], capsize=5, color='#ff7f0e', hatch=patterns[0])
    plt.bar(6+0.2, df['mean'].values[12], width,yerr=df["std_dev"].values[12], capsize=5, color='#1f77b4', hatch=patterns[1])       
    
    
    plt.xticks(x, ['AES_CTR', 'VPAES', 'MD5', 'SHA1\n(simd)', 'SHA1\n(nohw)', 'SHA256\n(simd)', 'SHA256\n(nohw)']) 
    plt.xlabel("Assembly") 
    plt.ylabel("Execution Time (ns)") 
    # plt.ylim(-0.1,0.1)
    plt.legend(["aws-lc","CLAMS"], fontsize=15, loc='upper center') 
    plt.tight_layout()
    plt.savefig(filename, format='png')
    plt.close()



def plot_group_full(df, title, filename):
    # df.sort_values(by="mean", inplace=True)
    x = np.arange(3)
    width = 0.3

    patterns = [ "/", "/", "o","+", "*" ]

    plt.bar(0-0.3, df['mean'].values[0], width, yerr=df["std_dev"].values[0],capsize=5,  color='#ff7f0e',  hatch=patterns[1])
    plt.bar(0, df['mean'].values[1], width, yerr=df["std_dev"].values[1],capsize=5,  color='#1f77b4', hatch=patterns[2])
    plt.bar(0+0.3, df['mean'].values[2], width, yerr=df["std_dev"].values[2],capsize=5,  color='#B7410E', hatch=patterns[3])  

    plt.bar(1-0.3, df['mean'].values[3], width,yerr=df["std_dev"].values[4], capsize=5, color='#ff7f0e', hatch=patterns[1])
    plt.bar(1, df['mean'].values[4], width, yerr=df["std_dev"].values[4], capsize=5, color='#1f77b4', hatch=patterns[2])
    plt.bar(1+0.3, df['mean'].values[5], width, yerr=df["std_dev"].values[5],capsize=5,  color='#B7410E', hatch=patterns[3])    

    plt.bar(2-0.3, df['mean'].values[6], width,yerr=df["std_dev"].values[6], capsize=5, color='#ff7f0e', hatch=patterns[1])
    plt.bar(2, df['mean'].values[8], width,yerr=df["std_dev"].values[8], capsize=5, color='#1f77b4', hatch=patterns[2]) 
    plt.bar(2+0.3, df['mean'].values[9], width, yerr=df["std_dev"].values[9],capsize=5,  color='#B7410E', hatch=patterns[3])   
    plt.ylabel("Execution Time (ns)")  

    print(df)

    plt.xticks(x, ['AES', 'SHA1', 'SHA256']) 
    plt.xlabel("Algorithms")  
    plt.legend(["aws-lc", "CLAMS", "RustCrypto"],fontsize=15, loc='upper right')
    plt.tight_layout()
    plt.savefig(filename, format='png')
    plt.close()


# Main script
if __name__ == "__main__":
    df = parse_bench_results(BENCH_FILE)
    if not df.empty:
        # Split the DataFrame based on the presence of "a" or "b" in the name
        df_a = df[df["name"].str.contains("assembly")]
        df_b = df[df["name"].str.contains("full")]

        # Plot the two groups separately
        if not df_a.empty:
            print("Benchmarks for just calling assembly")
            plot_group_asm(df_a, "Assembly Benchmarks", "asm.png")

        if not df_b.empty:
            print("Benchmarks for full implementations")
            plot_group_full(df_b, "Full Algorithm Benchmarks", "full.png")

        if df_a.empty and df_b.empty:
            print("No benchmarks found containing 'a' or 'b'.")
    else:
        print("No benchmark results found.")