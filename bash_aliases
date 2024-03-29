# ~/.bash_aliases: This file is meant to be sourced from ~/.bashrc

# The usual suspects
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -ip'
alias df='df -h'
alias less='less -r'
alias vm='vim -X'
alias x='exit'

# The -G option works on macos (linux uses --color)
alias ls='ls -GF'

# These aliases have been useful on many systems
alias today='mkcd ~/active/$(gdate +%Y/%m-%d)/'
alias cd-ex='cd ~/active/ex'
alias cd-poc='cd ~/active/poc'

# Aliases for conda
alias cde='conda deactivate'
alias cab='conda activate lab'
alias cam='conda activate mony'
alias cham='conda activate ham'
alias clam='conda activate lam'
alias clam-python='conda run -n lam --no-capture-output python'

# Aliases for docker
alias dockviz="docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"
alias dockviz-images-tree="dockviz images --tree"
alias lzd="docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v ~/.config/lazydocker:/.config/jesseduffield/lazydocker lazyteam/lazydocker"
alias dc='docker compose'

# Aliases for devops shenanigans
alias ans='ansible'
alias anp='ansible-playbook'
alias anv='ansible-vault'

# Aliases for granted
# https://docs.commonfate.io/granted/internals/shell-alias
alias assume="source assume"

# Hugo likes this format for its date field
alias hugo-now="gdate '+%Y-%m-%dT%H:%M:%S%:z'"

# EOF
