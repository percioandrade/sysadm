#!/usr/bin/env bash
# Author: Percio Andrade [perciocastelo@gmail.com | percioandrade@bandodenerd.com.br]
# This script checks active connections on different ports and color-codes them based on the number of connections

# First, we check if the script is executed with superuser privileges, which are typically required for network operations
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as superuser (root)" >&2
   exit 1
fi

# Check if the required commands (ss, awk, sort, uniq) are installed on the system
for cmd in ss awk sort uniq; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "The required command '$cmd' is not installed." >&2
        exit 1
    fi
done

# Function to determine the color based on the number of connections
get_color() {
    local total=$1
    # If total connections are less than 20, show green
    if [ "$total" -lt 20 ]; then
        echo -e "\e[32m"
    # If total connections are between 20 and 50, show orange
    elif [ "$total" -ge 20 ] && [ "$total" -le 50 ]; then
        echo -e "\e[33m"
    # If total connections are more than 50, show red
    else
        echo -e "\e[31m"
    fi
}

# Retrieve a list of active ports with their connection counts using ss command
port_info=$(ss -tuln 2>&1) # Redirect stderr to stdout to capture any errors
# Check if the output of the ss command contains 'Protocol not supported'
if echo "$port_info" | grep -q "Protocol not supported"; then
    echo "The Netlink protocol is not supported on this system." >&2
    exit 1
fi

# Process the output, extracting the port numbers and their connection counts
processed_info=$(echo "$port_info" | awk '{split($4, a, ":"); print a[length(a)]}' | sort | uniq -c)

# Sort the ports by number of connections in descending order
sorted_ports=$(echo "$processed_info" | sort -n -r)

# Function to print the top N ports based on connection count
print_top_ports() {
    local top_n=$1
    local count=0
    local IFS=$'\n'
    echo "Port - Total Connections"
    # Iterate over the sorted list of ports and their connection counts
    for line in $sorted_ports; do
        local total=$(echo "$line" | awk '{print $1}')
        local port=$(echo "$line" | awk '{print $2}')
        local color=$(get_color "$total")
        # Print the port and connection count with the appropriate color
        printf "$color%-5s - %d\e[0m\n" "$port" "$total"
        count=$((count + 1))
        # Stop printing after the top N ports
        if [ "$count" -eq "$top_n" ]; then
            break
        fi
    done
}

# Specify the number of top ports to display
top_n=10
print_top_ports "$top_n"