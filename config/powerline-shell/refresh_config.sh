#!/bin/bash

# If we had a script called `create_powerline_config.py` that converted
# our powerline.yaml file and compiled it into a config.json file,
# we would refresh it like this with fswatch.
#fswatch -o powerline.yaml | xargs -n1 -I{} ./create_powerline_config.py

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
config_dir="${HOME}/.config/powerline-shell"

if [[ ! -d "${powerline_shell_dir}" ]]; then
    echo "Creating ${powerline_shell_dir}"
    mkdir -p "${powerline_shell_dir}"
fi

# Let's use a bash function instead.
function convert_and_save() {
    local now=$(date +"%Y-%m-%d %H:%M:%S")
    local config_json="${config_dir}/config.json"
    local powerline_yaml="${script_dir}/powerline.yaml"

    local red=$(tput setaf 1)
    local green=$(tput setaf 2)
    local bold=$(tput bold)
    local reset=$(tput sgr0)

    echo "${bold}${now}: Detected changes in ${powerline_yaml}${reset}"
    yq -o json "${powerline_yaml}" | jq -r .config > "${config_json}"
    echo "${green}Saved new ${config_json}${reset}"
}

# Export the function so it's available to subshells
export -f convert_and_save

# Monitor for changes in the YAML file and convert it to JSON
fswatch -o powerline.yaml | xargs -n1 -I{} bash -c 'convert_and_save'
