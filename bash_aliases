# ~/.bash_aliases: This file is meant to be sourced from ~/.bashrc

# The usual
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -ip'
alias df='df -h'
alias less='less -r'
alias vm='vim -X'
alias x='exit'

# The -G option works on macos (linux uses --color)
alias ls='ls -GF'

# Conda aliases
alias cde='conda deactivate'
alias cab='conda activate lab'
alias cam='conda activate mony'
alias cham='conda activate ham'
alias clam='conda activate lam'

# Aliases for docker
alias dockviz="docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"
alias dockviz-images-tree="dockviz images --tree"
alias lzd="docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v ~/.config/lazydocker:/.config/jesseduffield/lazydocker lazyteam/lazydocker"

# Hugo likes this format for its date field
alias hugo-now="gdate '+%Y-%m-%dT%H:%M:%S%:z'"

# EOF
