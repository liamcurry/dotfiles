if status is-interactive
    # Commands to run in interactive sessions can go here
end

# === Path Enhancements ===
# Rust
if test -d "$HOME/.cargo/bin"
    fish_add_path "$HOME/.cargo/bin"
end

# Go
if test -d "$HOME/go/bin"
    fish_add_path "$HOME/go/bin"
end

# pipx (Python) and others
if test -d "$HOME/.local/bin"
    fish_add_path "$HOME/.local/bin"
end

if test -d "/opt/nvim-linux-x86_64/bin"
    fish_add_path "/opt/nvim-linux-x86_64/bin"
end

# For Apple Silicon Mac
if test -d "/opt/homebrew/bin"
    fish_add_path "/opt/homebrew/bin"
end

# For Intel Mac
if test -d "/usr/local/bin"
    fish_add_path "/usr/local/bin"
end

# === Sources ===

# Source secrets file if it exists
if test -f "$HOME/.secrets"
    source "$HOME/.secrets"
end

if test -f "$HOME/.linuxbrew_env"
    # Caching linuxbrew environment variables for faster shell startup
    # Regenerate with this command:
    #eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    source ~/.linuxbrew_env
end

# === Aliases ===
alias lsa='ls -lah'

# === Keybindings ===
function fish_user_key_bindings
    # This binds Ctrl+Enter to accept autosuggestion
    bind \cj accept-autosuggestion
end
