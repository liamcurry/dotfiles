# ---------------------------------------------
# Bash Configuration
# ---------------------------------------------

# === Git Prompt Support ===
if     [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
elif [ -f /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt
elif [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
elif [ -f /opt/homebrew/etc/bash_completion.d/git-prompt.sh ]; then
    source /opt/homebrew/etc/bash_completion.d/git-prompt.sh
else
    echo "git-prompt.sh not found"
fi

# === Prompt Customization ===
# Format: [username@hostname:cwd] (git-branch) $
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]$(__git_ps1 " (%s)") \$ '

# === History Improvements ===
HISTSIZE=10000      # Number of commands to save in memory
HISTFILESIZE=20000  # Number of commands to save in history file
shopt -s histappend # Append to history, don't overwrite
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTCONTROL=ignoredups:erasedups      # Remove duplicates in history
export HISTIGNORE="&:ls:[bf]g:exit:cd:clear" # Ignore trivial commands

# === Tab Completion Improvements ===
bind 'set completion-ignore-case on' # Case-insensitive tab completion
bind 'set show-all-if-ambiguous on'  # Show all matches immediately
bind 'set bell-style none'           # Disable bell sound on errors

# === Colorized Output ===
#export LS_COLORS="di=1;34:ln=36:so=1;32:pi=1;33:ex=1;35:bd=1;33;40:cd=1;33;40"
#export CLICOLOR=1 # Enable colors for commands like `ls`

# === Better Terminal Behavior ===
shopt -s checkwinsize # Auto-adjust terminal size after resize
shopt -s globstar     # Enable recursive globbing (e.g., `**/*.txt`)

# === Path Enhancements ===
# Rust
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Go
if [ -d "$HOME/go/bin" ]; then
    export PATH="$HOME/go/bin:$PATH"
fi

# pipx (Python) and others
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/opt/nvim-linux-x86_64/bin" ]; then
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
fi

# === Quality-of-Life Functions ===
# Extract various archive types
extract() {
    if [ -f "$1" ]; then
        case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xjf "$1" ;;
        *.tgz) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.7z) 7z x "$1" ;;
        *) echo "Cannot extract '$1': unsupported archive format" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

command_exists() {
    type "$1" &>/dev/null
}

# === Aliases ===
alias ..='cd ..'               # Move up one directory
alias ...='cd ../..'           # Move up two directories
alias e=extract                # Extract archives
alias grep='grep --color=auto' # Highlight search results
alias gs='git status'
alias lsa='ls -lah'

# Package management
if command_exists apt-get; then
    alias pkgs='apt-cache search'
    alias pkgi='sudo apt-get install'
    alias pkgr='sudo apt-get remove'
elif command_exists brew; then
    alias pkgs='brew search'
    alias pkgi='brew install'
    alias pkgr='brew remove'
elif command_exists port; then
    alias pkgs='apt-cache search'
    alias pkgi='sudo apt-get install'
    alias pkgr='sudo apt-get autoremove --purge'
elif command_exists pacman; then
    alias pkgs='pacman -Ss'
    alias pkgi='sudo pacman -S'
    alias pkgr='sudo pacman -R'
fi

# Tinty isn't able to apply environment variables to your shell due to
# the way shell sub-processes work. This is a work around by running
# Tinty through a function and then executing the shell scripts.
tinty_source_shell_theme() {
    newer_file=$(mktemp)
    tinty $@
    subcommand="$1"

    if [ "$subcommand" = "apply" ] || [ "$subcommand" = "init" ]; then
        tinty_data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty"

        while read -r script; do

            # shellcheck disable=SC1090
            . "$script"
        done < <(find "$tinty_data_dir" -maxdepth 1 -type f -name "*.sh" -newer "$newer_file")

        unset tinty_data_dir
    fi

    unset subcommand
}

if [ -n "$(command -v 'tinty')" ]; then
    # Commented out because it is causing slowdowns with Kitty.
    # Run tinty manually to sync
    #tinty_source_shell_theme "init" >/dev/null

    alias tinty=tinty_source_shell_theme
fi

if [ -f ~/.linuxbrew_env ]; then
    # Caching linuxbrew environment variables for faster shell startup
    # Regenerate with this command:
    #eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    source ~/.linuxbrew_env
fi

