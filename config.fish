set -U fish_user_paths ~/.cargo/bin $fish_user_paths ~/.bin
alias v=nvim
set -gx FZF_DEFAULT_COMMAND  'rg --files'

set -xU VISUAL nvim
set -xU EDITOR $VISUAL

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec ssh-agent startx -- -keeptty
    end
end


