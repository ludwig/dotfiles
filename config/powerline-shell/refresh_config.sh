#!/bin/bash

# If we had a script called `create_powerline_config.py` that converted
# our powerline.yaml file and compiled it into a config.json file,
# we would refresh it like this with fswatch.
#fswatch -o powerline.yaml | xargs -n1 -I{} ./create_powerline_config.py

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# The location of the powerline-shell config directory.
export config_dir="${HOME}/.config/powerline-shell"

# The full path to the `powerline.yaml` file.
export powerline_yaml=$(readlink -f "${script_dir}/powerline.yaml")

# The path to the target `config.json`` file.
export config_json="${config_dir}/config.json"

# For colorizing the output
export red=$(tput setaf 1)
export green=$(tput setaf 2)
export magenta=$(tput setaf 5)
export bold=$(tput bold)
export reset=$(tput sgr0)

# Create the config directory if it doesn't exist
if [[ ! -d "${config_dir}" ]]; then
    echo "${green}Creating ${bold}${config_dir}${reset}"
    mkdir -p "${config_dir}"
fi

# Let's use a bash function instead.
function convert_and_save() {
    local now=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${now}] Detected changes in ${bold}${powerline_yaml}${reset}"
    yq -o json "${powerline_yaml}" | jq -r .config > "${config_json}"
    echo "${green}Saved new ${bold}${config_json}${reset}"
}

# Export the function so it's available to subshells
export -f convert_and_save

# Monitor for changes in the YAML file and convert it to JSON
echo "${magenta}Watching for changes in ${bold}${powerline_yaml}${reset}"
fswatch -o "${powerline_yaml}" | xargs -n1 -I{} bash -c 'convert_and_save'
