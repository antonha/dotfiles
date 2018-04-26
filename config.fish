set -U fish_user_paths ~/.cargo/bin $fish_user_paths
alias v=nvim

set -xU VISUAL nvim
set -xU EDITOR $VISUAL

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec ssh-agent startx -- -keeptty
    end
end


