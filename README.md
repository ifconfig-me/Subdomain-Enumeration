# Subdomain Enumeration Script
This script is designed to enumerate subdomains for a list of target domains using Subfinder and Assetfinder tools.
## Usage
### Prerequisites
Make sure you have the following dependencies installed:
- [Subfinder](https://github.com/projectdiscovery/subfinder)
- [Assetfinder](https://github.com/tomnomnom/assetfinder)
### Running the Script

![2024-05-24_20-52-29](https://github.com/ifconfig-me/Subdomain-Enumeration/assets/25315805/8d96f8db-70fd-484b-8729-85e383805e58)

Run the script with the following command:

   ```bash
   ./enumerate_subdomains.sh -target TARGETS_FILE -raw-scan RAW_RESULTS_FILE --out OUTPUT_DIR
   ```

   Replace `TARGETS_FILE` with the path to your file containing the list of target domains, `RAW_RESULTS_FILE` with the desired name for the raw scan results file, and `OUTPUT_DIR` with the directory where you want to save the results.

## Script Details

- The script runs Subfinder and Assetfinder tools to enumerate subdomains for each target domain.
- It appends the results into a single file named `RAW_RESULTS_FILE` in the specified `OUTPUT_DIR`.
- The script ensures that the raw results file is sorted and updated to maintain uniqueness.

## License

This project is licensed under the MIT License.

## Author

- [@ifconfig-me](https://github.comi/fconfig-me)
