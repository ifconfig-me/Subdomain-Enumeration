#!/bin/bash
usage() {
    echo "Usage: $0 -target TARGETS_FILE -raw-scan RAW_RESULTS_FILE --out OUTPUT_DIR"
    exit 1
}
echo '░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░▒▓███████▓▒░  '
echo '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓████▓▒░▒▓█▓▒░░▒▓█▓▒░ '
echo '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ '
echo '░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░░▒▓█▓▒▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ '
echo '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░    ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ '
echo '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░    ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ '
echo '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓██▓▒░     ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ '
echo ''
if [ "$#" -ne 6 ]; then
    usage
fi
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -target) TARGETS_FILE="$2"; shift ;;
        -raw-scan) RAW_RESULTS_FILE="$2"; shift ;;
        --out) OUTPUT_DIR="$2"; shift ;;
        *) usage ;;
    esac
    shift
done
if [[ -z "$TARGETS_FILE" || -z "$RAW_RESULTS_FILE" || -z "$OUTPUT_DIR" ]]; then
    usage
fi
mkdir -p "$OUTPUT_DIR"
> "$OUTPUT_DIR/$RAW_RESULTS_FILE"
while IFS= read -r domain; do
    if [[ -n "$domain" ]]; then
        echo "Enumerating subdomains for $domain..."
        subfinder -d "$domain" -silent >> "$OUTPUT_DIR/$RAW_RESULTS_FILE"
        assetfinder --subs-only "$domain" >> "$OUTPUT_DIR/$RAW_RESULTS_FILE"
       
        subdomain_count=$(cat "$OUTPUT_DIR/$RAW_RESULTS_FILE" | sort -u | wc -l)
        echo "$subdomain_count subdomains found for $domain"
    fi
done < "$TARGETS_FILE"
sort -u "$OUTPUT_DIR/$RAW_RESULTS_FILE" -o "$OUTPUT_DIR/$RAW_RESULTS_FILE"
echo
echo "Enumeration complete. Results are saved in $OUTPUT_DIR/$RAW_RESULTS_FILE."
echo "All processes completed."
