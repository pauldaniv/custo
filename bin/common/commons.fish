#!/usr/bin/env fish

# Color definitions

set -x CYAN '\033[1;36m'
set -x NC '\033[0m'


# Regular Colors
set -x Black '\033[0;30m'        # Black
set -x Red '\033[0;31m'          # Red
set -x Green '\033[0;32m'        # Green
set -x Yellow '\033[0;33m'       # Yellow
set -x Blue '\033[0;34m'         # Blue
set -x Purple '\033[0;35m'       # Purple
set -x Cyan '\033[0;36m'         # Cyan
set -x White '\033[0;37m'        # White

# Bold
set -x BBlack '\033[1;30m'       # Black
set -x BRed '\033[1;31m'         # Red
set -x BGreen '\033[1;32m'       # Green
set -x BYellow '\033[1;33m'      # Yellow
set -x BBlue '\033[1;34m'        # Blue
set -x BPurple '\033[1;35m'      # Purple
set -x BCyan '\033[1;36m'        # Cyan
set -x BWhite '\033[1;37m'       # White

# Underline
set -x UBlack '\033[4;30m'       # Black
set -x URed '\033[4;31m'         # Red
set -x UGreen '\033[4;32m'       # Green
set -x UYellow '\033[4;33m'      # Yellow
set -x UBlue '\033[4;34m'        # Blue
set -x UPurple '\033[4;35m'      # Purple
set -x UCyan '\033[4;36m'        # Cyan
set -x UWhite '\033[4;37m'       # White

# Background
set -x On_Black '\033[40m'       # Black
set -x On_Red '\033[41m'         # Red
set -x On_Green '\033[42m'       # Green
set -x On_Yellow '\033[43m'      # Yellow
set -x On_Blue '\033[44m'        # Blue
set -x On_Purple '\033[45m'      # Purple
set -x On_Cyan '\033[46m'        # Cyan
set -x On_White '\033[47m'       # White

# High Intensity
set -x IBlack '\033[0;90m'       # Black
set -x IRed '\033[0;91m'         # Red
set -x IGreen '\033[0;92m'       # Green
set -x IYellow '\033[0;93m'      # Yellow
set -x IBlue '\033[0;94m'        # Blue
set -x IPurple '\033[0;95m'      # Purple
set -x ICyan '\033[0;96m'        # Cyan
set -x IWhite '\033[0;97m'       # White

# Bold High Intensity
set -x BIBlack '\033[1;90m'      # Black
set -x BIRed '\033[1;91m'        # Red
set -x BIGreen '\033[1;92m'      # Green
set -x BIYellow '\033[1;93m'     # Yellow
set -x BIBlue '\033[1;94m'       # Blue
set -x BIPurple '\033[1;95m'     # Purple
set -x BICyan '\033[1;96m'       # Cyan
set -x BIWhite '\033[1;97m'      # White

# High Intensity backgrounds
set -x On_IBlack '\033[0;100m'   # Black
set -x On_IRed '\033[0;101m'     # Red
set -x On_IGreen '\033[0;102m'   # Green
set -x On_IYellow '\033[0;103m'  # Yellow
set -x On_IBlue '\033[0;104m'    # Blue
set -x On_IPurple '\033[0;105m'  # Purple
set -x On_ICyan '\033[0;106m'    # Cyan
set -x On_IWhite '\033[0;107m'   # White


function custo
  set command $argv[1]
  if test $command = "update"
    ~/.custo/install.sh
    source ~/.config/fish/config.fish
  else if test $command = "version"
    set branch (git -C ~/.custo --no-pager branch --show-current)
    switch "$branch"
      case 'develop' fish_vi_key_bindings
        set branch_color "$Purple"
      case 'master'
        set branch_color "$Green"
      case '*'
        set branch_color "$NC"
    end
    echo -e "$branch_color$branch$NC $Green->$NC $(git -C ~/.custo rev-parse --short HEAD) $Blue->$NC $(git -C ~/.custo --no-pager show -s --format=%s)"
  else
    echo "Unsupported command"
  end
end
