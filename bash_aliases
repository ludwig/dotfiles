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
alias cd-active='cd ~/active'
alias cd-scratch='cd ~/active/scratch'
alias cd-ex='cd ~/active/ex'
alias cd-poc='cd ~/active/poc'
alias cd-hot='cd ~/hot'
alias cd-notes='cd ~/active/notes'
alias cd-jobs='cd ~/active/jorb-data'
alias cd-crucible='cd ~/Desktop/crucible'
alias lg='lazygit'
alias ncdu-skip-library='ncdu --exclude ~/Library'

# Aliases for yt-dlp
alias yt-dlp-mp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
alias yt-dlp-mp3='yt-dlp --extract-audio --audio-format mp3'

# Aliases for chrome
alias chrome-default="open -na 'Google Chrome' --args --new-window --profile-directory='Default'"
alias chrome-list='chrome-new.py list'
alias chrome='chrome-new.py open'

# Aliases for python dev
alias devpi-login='devpi login ludwig --password=$(cat ~/security/devpi/ludwig.yaml | yq -r .password)'

# Aliases for conda
alias cd-miniforge3='cd ~/miniforge3/envs'
alias cde='conda deactivate'
alias cab='conda activate lab'
alias cam='conda activate mony'
alias cram='conda activate ram'
alias cham='conda activate ham'
alias clam='conda activate lam'
alias clam-python='conda run -n lam --no-capture-output python'
alias ipython-lam='ipython --profile=lam'

# Aliases for docker
alias dockviz="docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"
alias dockviz-images-tree="dockviz images --tree"
alias lzd="docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock -v ~/.config/lazydocker:/.config/jesseduffield/lazydocker lazyteam/lazydocker"
alias dc='docker compose'

# Aliases for devops shenanigans
alias ans='ansible'
alias anp='ansible-playbook'
alias anv='ansible-vault'
alias sops-age-keys='age-keygen -y < ~/.config/sops/age/keys.txt'

# AWS stuff
alias ave='aws-vault exec'
alias tf='terraform'
alias tf-apply-auto='terraform apply -auto-approve'
alias tg='terragrunt'
alias get-caller-identity='aws sts get-caller-identity'

# Aliases for granted
# https://docs.commonfate.io/granted/internals/shell-alias
alias assume="source assume"

# Hugo likes this format for its date field
alias hugo-now="gdate '+%Y-%m-%dT%H:%M:%S%:z'"

# EOF
