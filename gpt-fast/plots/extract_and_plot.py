import re
import sys
import matplotlib.pyplot as plt


versions = ["baseline", "compile", "quantize+compile", "speculative", "tp"]

def extract_data_from_file(filename):
    try:
        with open(filename, 'r') as file:
            file_content = file.read()
    except FileNotFoundError:
        print(f"Error: The file {filename} does not exist.")
        return 0, 0, 0
    except Exception as e:
        print(f"Error: An error occurred while reading the file {filename}.", e)
        return 0, 0, 0

    # Compile regex patterns to find relevant data
    bandwidth_pattern = re.compile(r"Bandwidth achieved: (\d+\.\d+) GB/s")
    average_tokens_pattern = re.compile(r"Average tokens/sec: (\d+\.\d+)")
    memory_used_pattern = re.compile(r"Memory used: (\d+\.\d+) GB")

    # Find all bandwidth values and convert them to float
    bandwidth_matches = bandwidth_pattern.findall(file_content)
    bandwidth_values = [float(bandwidth) for bandwidth in bandwidth_matches]
    
    # Calculate average bandwidth if any values were found
    average_bandwidth = sum(bandwidth_values) / len(bandwidth_values) if bandwidth_values else 0

    # Find the average tokens per second
    average_tokens_match = average_tokens_pattern.search(file_content)
    average_tokens = float(average_tokens_match.group(1)) if average_tokens_match else 0

    # Find the memory used
    memory_used_match = memory_used_pattern.search(file_content)
    memory_used = float(memory_used_match.group(1)) if memory_used_match else 0

    return average_bandwidth, average_tokens, memory_used

def plot_with_percentage(ax, values, colors, title, ylabel, ylim, baseline_value):
    ax.bar(versions, values, color=colors)
    ax.set_title(title)
    ax.set_ylabel(ylabel)
    ax.set_ylim(0, ylim)
    
    # Calculate and display percentage differences
    for i, (value, _) in enumerate(zip(values, versions)):
        if i != 0 and value != 0:  # Exclude baseline and zero values
            percentage_diff = ((value - baseline_value) / baseline_value * 100) if baseline_value != 0 else 0
            ax.text(i, value + (0.05 * ylim), f'{percentage_diff:+.1f}%', ha='center', color='black')

def main():
    data = {version: (0, 0, 0) for version in versions}

    if len(sys.argv) < 2:
        print("Usage: python script.py <file1> <file2> ...")
        return

    # Assign each file to a version based on its position
    for i, filename in enumerate(sys.argv[1:]):
        if i < len(versions):
            version = versions[i]
            results = extract_data_from_file(filename)
            if version == "tp":  # Applying the multiplier for the 'tp' version
                results = (results[0] * 4, results[1], results[2] * 4)
            data[version] = results

    # Data unpacking
    bandwidths, tokens_sec, memories = zip(*[data[version] for version in versions])

    # Define a list of colors for each version
    colors = ['blue', 'green', 'red', 'purple', 'orange']

    # Create a figure with three subplots
    fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(20, 5))

    # Plot for Memory Used
    plot_with_percentage(ax1, memories, colors, 'Memory Used (GB)', 'Memory (GB)', 22, memories[0])

    # Plot for Average Bandwidth Achieved
    plot_with_percentage(ax2, bandwidths, colors, 'Average Bandwidth Achieved (GB/s)', 'Bandwidth (GB/s)', 2200, bandwidths[0])

    # Plot for Average Tokens per Second
    plot_with_percentage(ax3, tokens_sec, colors, 'Average Tokens per Second', 'Tokens per Second', 260, tokens_sec[0])

    plt.tight_layout()  # Adjust layout to not overlap subplots
    plt.savefig('combined_plot.jpg', format='jpg')
    plt.close(fig)

if __name__ == "__main__":
    main()
