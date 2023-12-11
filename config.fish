set -U fish_user_paths ~/.cargo/bin $fish_user_paths ~/.bin
alias v=nvim
# set -gx FZF_DEFAULT_COMMAND  'rg --files'

set -xU VISUAL nvim
set -xU EDITOR $VISUAL
set -xU MOZ_ENABLE_WAYLAND 1
set -xU SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

# Start X at login
#if status is-login
#    if test -z "$DISPLAY" -a $XDG_VTNR = 1
#        exec sway -- -keeptty
#    end
#end


