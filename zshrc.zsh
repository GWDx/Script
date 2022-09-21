[[ "$-" != *i* ]] && return

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
setopt completealiases


# 插件
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



# 外观
PROMPT='%F{cyan}%~%f '
# PROMPT='%F{cyan}%n@%m%f %F{blue}%~%f '
RPROMPT="%F{cyan}%(?..%?)%f"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=#d0d0d0


typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=#000000,bold

# 命令 紫色
command=fg=#c060c0,bold
ZSH_HIGHLIGHT_STYLES[precommand]=$command
ZSH_HIGHLIGHT_STYLES[command]=$command
ZSH_HIGHLIGHT_STYLES[alias]=$command
# ZSH_HIGHLIGHT_STYLES[suffix-alias]=$command
ZSH_HIGHLIGHT_STYLES[builtin]=$command
ZSH_HIGHLIGHT_STYLES[function]=$command

# 选项 浅蓝
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=#a0a0e0
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=#a0a0e0

# 路径 蓝绿
ZSH_HIGHLIGHT_STYLES[path]=fg=#00a0a0,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=#00a0a0

# 引号内部 浅粉
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=#e0b0b0
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=#e0b0b0

# 分隔符 暗黄
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=#c0c000,bold
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=#c0c000
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=#c0c000
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=#c0c000

ZSH_HIGHLIGHT_STYLES[default]=none



# 记录历史
export SAVEHIST=$HISTSIZE

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


alias ls='ls --color'
alias cd..='cd ..'
alias grep=rg
alias fd=fdfind

alias ll='ls -alF'

alias rb=ruby
alias js=node
alias py=python3
alias ipy=ipython3
alias diff='icdiff'
alias vlab='ssh -i ~/.ssh/vlab.pem ubuntu@vlab.ustc.edu.cn -D localhost:1080'
alias yarn=yarnpkg
alias windows=sudo grub-reboot "$(grep -i windows /boot/grub/grub.cfg|cut -d"'" -f2)" && sudo reboot
# alias pwndbg='gdb --init-command=~/.pwndbginit'

export LD_PRELOAD=~/文档/Code/Script/Resourse/stderred/build/libstderred.so
export STDERRED_ESC_CODE=`echo -e $(tput bold)`

export NODE_MIRROR=https://mirrors.ustc.edu.cn/node/
export GEM_HOME="$HOME/.gems"

typeset -U path PATH
path=($path /usr/sbin ~/.local/bin ~/node_modules/.bin ~/.gems/bin)
export PATH


jqf(){
    # jq . < "$1"
    result=$(jq . < "$1")
    echo "$result" > "$1"
}

gitforward() {
    git checkout check >/dev/null 2>&1
    git reset --hard $(git rev-list --topo-order HEAD..master | tail -2 | head -1) >/dev/null
    git log --oneline -n 1
    git reset --mixed HEAD~ >/dev/null
}

gitbackward() {
    git checkout check >/dev/null 2>&1
    git log --oneline -n 1
    git reset --hard HEAD~ >/dev/null
}

cmakemake() {
    [[ $PWD == *build ]] && cd ..
    [ -d build ] && /bin/rm -r build
    [ -e CMakeLists.txt ] && mkdir build && cd build && cmake $@ .. && make && cd ..
}

cpulimitusage() {
    waitCount=0
    maxCpuUsage=$1
    while [ $waitCount -lt 5 ]; do
        awkAnswer=$(ps aux | awk '{if($3 > '$maxCpuUsage') print $2}')
        if [ -z "$awkAnswer" ]; then
            waitCount=$((waitCount+1))
            echo "wait $waitCount"
            sleep 5;
        else
            waitCount=0
            timeout 20 cpulimit --pid=$awkAnswer --limit=$maxCpuUsage
        fi
    done
}

untilGPUFree(){
    # while used > 1 GiB
    while [ $(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits) -gt 1000 ]; do
        echo "GPU used: $(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits) MiB"
        sleep 10
    done
}


# export RUSTFLAGS="-A non_snake_case"

bindkey '^[[1;5C' forward-word		# Ctrl right
bindkey '^[[1;5D' backward-word		# Ctrl left
bindkey '^H' backward-kill-word		# Ctrl backspace

bindkey '^E' autosuggest-execute			# Alt enter
bindkey '^[f' autosuggest-accept			# Alt F
bindkey -s '\e[1;3A' 'cd ..\n'				# Alt up


stty -ixon
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
