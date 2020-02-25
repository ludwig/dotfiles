#!/bin/bash
# See this thread:
# https://stackoverflow.com/questions/4565700/how-to-specify-the-private-ssh-key-to-use-when-executing-shell-command-on-git
#
# To use:
#   export GIT_SSH_COMMAND=git-luis.sh
#
ssh -i ~/.ssh/luis_rsa -o IdentitiesOnly=yes "$@"
