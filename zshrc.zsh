[[ "$-" != *i* ]] && return

# 插件
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/文档/Code/Script/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# 外观
PROMPT='%F{cyan}%~%f '
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
# ZSH_HIGHLIGHT_STYLES[function]=fg=$command

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
alias grep='grep --color'

alias ll='ls -alF'
alias pythondev=~/.conda/envs/dev1/bin/python


bindkey '^[[1;5C' forward-word        # ctrl right
bindkey '^[[1;5D' backward-word       # ctrl left
bindkey '^H' backward-kill-word       # ctrl backspace
