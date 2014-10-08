
function _git_branch_name
    # see https://github.com/godfat/fish_prompt-gitstatus
    echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_status_symbol
    set -l git_status (git status --porcelain ^/dev/null)
    if test -n "$git_status"
        # Is there any way to preserve newlines so we can reuse $git_status?
        if git status --porcelain ^/dev/null | grep '^.[^ ]' >/dev/null
            # dirty
            echo '*'
        else
            # all staged
            echo '#'
        end
    else
        # clean
        echo ''
    end
end

function _remote_hostname
    if test -n "$SSH_CONNECTION"
        echo (whoami)@(hostname)
    end
end

function _hostname
    echo (whoami)@(hostname -s)
end

function fish_prompt
    set -l red (set_color -o red)
    set -l normal (set_color normal)
    set -l cwd (set_color -o $fish_color_cwd)(prompt_pwd)
    set -l git_status (_git_status_symbol)(_git_branch_name)
    if test -n "$git_status"
        set git_status "($git_status)"
    end
    echo -n (_hostname):$cwd$red$git_status$normal'> '
end
