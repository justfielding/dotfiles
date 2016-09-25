# Improved Command Options
alias la="ls -al" # high frequency in history, so I made an alias
alias grep="grep --color=auto" # always grep with color

# Shortcuts
alias git="hub"
alias g="git"
alias kb="keybase"
alias v="nvim"
alias vim="nvim"
alias sv="sudo nvim"
alias tm="tmux"

alias irc="weechat"
alias reboot="sudo shutdown -r now"
alias shutdown="sudo shutdown -h now"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

alias prettyJSON='python -m json.tool'

## Show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"
## Program shortcuts
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

# Shortcuts to scripts
#alias log="$HOME/bin/logtodayone.rb"
#alias note-se="$HOME/bin/vw/vw-update.pl /Users/fielding/notes"
#alias fm="$HOME/bin/fieldMatter.rb"

# TODO: is the following vim alias doing anything for vim/tmux/osx and the clipboard
#alias vim="reattach-to-user-namespace vim"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine.
# http://www.macgasm.net/2013/01/18/good-morning-your-mac-keeps-a-log-of-all-your-downloads/

alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Fun
alias toiletlist='for i in ${TOILET_FONT_PATH:=/usr/local/Cellar/figlet/2.2.5/share/figlet/fonts}/*.{t,f}lf; do j=${i##*/}; echo ""; echo "╓───── "$j; echo "╙────────────────────────────────────── ─ ─ "; echo ""; toilet -t -d "${i%/*}" -f "$j" "${j%.*}"; done'

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update="sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; pip-upgrade-all"

# rot13: or caesar cipher or substitution cipher shifting 13 characters
alias rot13="tr a-zA-Z n-za-mN-ZA-M"

# Corporate random bullshit generator
alias cbsg='curl -s http://cbsg.sourceforge.net/cgi-bin/live | grep -Eo "^<li>.*</li>" | sed s,\</\\?li\>,,g | shuf -n 1'