# SSH Network Port Checker Script

This bash script checks active connections on different ports and color-codes them to provide a clear visualization of the network status. The script requires superuser privileges and relies on common networking utilities.

## Features

* Verifies execution privileges
* Checks for the availability of required commands
* Color-codes ports based on the number of connections:
* Green: Less than 20 connections
* Orange: Between 20 and 50 connections
* Red: More than 50 connections
* Displays the top 10 ports with the highest number of connections

## Usage

1. Ensure you have the necessary privileges to run network operations.
2. Execute the script as root to perform the check:

``` bash
sudo ./stat.sh
```

## Output

The script outputs a list of the top N ports (default is 10), along with their respective total connections, sorted in descending order. Each entry is color-coded for visual convenience.

## Customization

You can specify a different number of top ports to display by modifying the top\_n variable within the script.

## Requirements

* Superuser (root) privileges
* `ss`, `awk`, `sort`, `uniq` commands available in the system

## Installation

To get started, copy or clone the script to a file, give it execution permissions with `chmod +x ssh_key_manager.sh`, and run it from the terminal.

## Support

For any issues or help using the script, please contact Percio Andrade at:

* Email: [perciocastelo@gmail.com](mailto:perciocastelo@gmail.com)
* Alternative Email: [percioandrade@bandodenerd.com.br](mailto:percioandrade@bandodenerd.com.br)

- - -

This script is provided as-is with no warranty. Use it at your own risk. Contributions and feedback are welcome.