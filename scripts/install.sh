#!/usr/bin/env bash
#
# Dotfiles Installation Script
#
# Installs dotfiles, shell configurations, and development tools.
# Supports selective installation and creates backups of existing files.
#
# Usage: ./install.sh [options]
# Options:
#   -h, --help          Show this help message
#   -b, --backup-dir    Specify backup directory (default: ~/.dotfiles-backup)
#   --skip-packages     Skip package installation (npm, yarn globals)
#   --skip-vscode       Skip VS Code configuration
#   --dry-run           Show what would be done without making changes
#
# Author: User
# Version: 2.0.0

set -euo pipefail

# Script constants
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" || {
    echo "Failed to determine script directory" >&2
    exit 1
}
readonly SCRIPT_DIR

TIMESTAMP="$(date +%Y%m%d_%H%M%S)" || {
    echo "Failed to generate timestamp" >&2
    exit 1
}
readonly TIMESTAMP

readonly DEFAULT_BACKUP_DIR="${HOME}/.dotfiles-backup-${TIMESTAMP}"

# Configuration variables
BACKUP_DIR="${DEFAULT_BACKUP_DIR}"
SKIP_PACKAGES=false
SKIP_VSCODE=false
DRY_RUN=false

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Logging functions
log_info() {
    printf "${BLUE}[INFO]${NC} %s\n" "$*" >&2
}

log_success() {
    printf "${GREEN}[SUCCESS]${NC} %s\n" "$*" >&2
}

log_warn() {
    printf "${YELLOW}[WARN]${NC} %s\n" "$*" >&2
}

log_error() {
    printf "${RED}[ERROR]${NC} %s\n" "$*" >&2
}

# Error handling
cleanup() {
    local exit_code="${1:-1}"
    if [[ "${exit_code}" -ne 0 ]]; then
        log_error "Installation failed. Check logs above for details."
        if [[ -d "${BACKUP_DIR}" ]]; then
            log_info "Backup files are available in: ${BACKUP_DIR}"
        fi
    fi
    exit "${exit_code}"
}

trap 'cleanup $?' EXIT INT TERM

# Utility functions
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

is_linux() {
    [[ "$(uname)" == "Linux" ]]
}

# Show help
show_help() {
    sed -n '2,/^$/p' "$0" | sed 's/^# \?//' | head -n -1
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
        -h | --help)
            show_help
            exit 0
            ;;
        -b | --backup-dir)
            BACKUP_DIR="$2"
            shift 2
            ;;
        --skip-packages)
            SKIP_PACKAGES=true
            shift
            ;;
        --skip-vscode)
            SKIP_VSCODE=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        *)
            log_error "Unknown option: $1"
            log_error "Use --help for usage information"
            exit 1
            ;;
        esac
    done
}

# Backup existing file if it exists
backup_file() {
    local source_path="$1"
    local backup_name="$2"

    if [[ -e "${source_path}" ]]; then
        if [[ "${DRY_RUN}" == "true" ]]; then
            log_info "[DRY RUN] Would backup: ${source_path} -> ${BACKUP_DIR}/${backup_name}"
            return 0
        fi

        mkdir -p "${BACKUP_DIR}"
        if cp -r "${source_path}" "${BACKUP_DIR}/${backup_name}"; then
            log_info "Backed up: ${source_path} -> ${BACKUP_DIR}/${backup_name}"
        else
            log_error "Failed to backup: ${source_path}"
            return 1
        fi
    fi
}

# Create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local backup_name
    backup_name="$(basename "${target}")"

    if [[ ! -f "${source}" ]]; then
        log_error "Source file does not exist: ${source}"
        return 1
    fi

    if [[ "${DRY_RUN}" == "true" ]]; then
        log_info "[DRY RUN] Would create symlink: ${source} -> ${target}"
        return 0
    fi

    # Backup existing file
    backup_file "${target}" "${backup_name}" || return 1

    # Create symlink
    if ln -fs "${source}" "${target}"; then
        log_success "Created symlink: ${source} -> ${target}"
    else
        log_error "Failed to create symlink: ${source} -> ${target}"
        return 1
    fi
}

# Install dotfiles
install_dotfiles() {
    log_info "Installing dotfiles..."

    local dotfiles=(
        ".bashrc"
        ".tmux.conf"
        ".aider.conf.yml"
        ".gitignore"
        "default.nix"
        "home.nix"
    )

    for dotfile in "${dotfiles[@]}"; do
        local source="${SCRIPT_DIR}/${dotfile}"
        local target="${HOME}/${dotfile}"

        if [[ -f "${source}" ]]; then
            create_symlink "${source}" "${target}"
        else
            log_warn "Dotfile not found, skipping: ${source}"
        fi
    done
}

# Install neovim configuration
install_nvim_config() {
    log_info "Installing Neovim configuration..."

    local nvim_source="${SCRIPT_DIR}/.config/nvim"
    local nvim_target="${HOME}/.config/nvim"

    if [[ ! -d "${nvim_source}" ]]; then
        log_warn "Neovim config not found, skipping: ${nvim_source}"
        return 0
    fi

    if [[ "${DRY_RUN}" == "true" ]]; then
        log_info "[DRY RUN] Would install Neovim config: ${nvim_source} -> ${nvim_target}"
        return 0
    fi

    # Backup existing config
    backup_file "${nvim_target}" "nvim" || return 1

    # Create .config directory if it doesn't exist
    mkdir -p "$(dirname "${nvim_target}")"

    # Copy nvim config
    if cp -r "${nvim_source}" "${nvim_target}"; then
        log_success "Installed Neovim configuration"
    else
        log_error "Failed to install Neovim configuration"
        return 1
    fi
}

# Install Node.js packages
install_packages() {
    if [[ "${SKIP_PACKAGES}" == "true" ]]; then
        log_info "Skipping package installation (--skip-packages specified)"
        return 0
    fi

    if [[ "${DRY_RUN}" == "true" ]]; then
        log_info "[DRY RUN] Would install npm/yarn packages"
        return 0
    fi

    # Install yarn if npm is available
    if command_exists npm && ! command_exists yarn; then
        log_info "Installing yarn..."
        if npm install -g yarn; then
            log_success "Installed yarn"
        else
            log_error "Failed to install yarn"
            return 1
        fi
    fi

    # Install global packages with yarn
    if command_exists yarn; then
        log_info "Installing global packages with yarn..."
        local packages=(
            "typescript"
            "tslint"
            "elm"
            "elm-format"
            "stylelint"
        )

        for package in "${packages[@]}"; do
            log_info "Installing: ${package}"
            if yarn global add "${package}"; then
                log_success "Installed: ${package}"
            else
                log_warn "Failed to install: ${package}"
            fi
        done
    else
        log_warn "yarn not available, skipping global package installation"
    fi
}

# Install VS Code configuration
install_vscode_config() {
    if [[ "${SKIP_VSCODE}" == "true" ]]; then
        log_info "Skipping VS Code configuration (--skip-vscode specified)"
        return 0
    fi

    if ! command_exists code; then
        log_info "VS Code not found, skipping configuration"
        return 0
    fi

    log_info "Configuring VS Code..."

    local vscode_source="${SCRIPT_DIR}/vscode"
    local vscode_settings_source="${vscode_source}/settings.json"
    local vscode_snippets_source="${vscode_source}/snippets"

    if [[ ! -f "${vscode_settings_source}" ]]; then
        log_warn "VS Code settings not found, skipping: ${vscode_settings_source}"
        return 0
    fi

    # Determine VS Code config path based on OS
    local vscode_config_dir
    if is_macos; then
        vscode_config_dir="${HOME}/Library/Application Support/Code/User"
    elif is_linux; then
        vscode_config_dir="${HOME}/.config/Code/User"
    else
        log_error "Unsupported operating system for VS Code configuration"
        return 1
    fi

    if [[ "${DRY_RUN}" == "true" ]]; then
        log_info "[DRY RUN] Would configure VS Code in: ${vscode_config_dir}"
        return 0
    fi

    # Create VS Code config directory
    mkdir -p "${vscode_config_dir}"

    # Install settings
    local settings_target="${vscode_config_dir}/settings.json"
    create_symlink "${vscode_settings_source}" "${settings_target}" || return 1

    # Install snippets if they exist
    if [[ -d "${vscode_snippets_source}" ]]; then
        local snippets_target="${vscode_config_dir}/snippets"
        backup_file "${snippets_target}" "vscode-snippets" || return 1

        if ln -fs "${vscode_snippets_source}" "${snippets_target}"; then
            log_success "Installed VS Code snippets"
        else
            log_error "Failed to install VS Code snippets"
            return 1
        fi
    fi

    # Install extensions
    local extensions=(
        "esbenp.prettier-vscode"
        "ms-vscode-remote.remote-containers"
        "elmtooling.elm-ls-vscode"
        "ms-vscode.cpptools"
        "ms-vscode.vscode-typescript-next"
        "yzhang.markdown-all-in-one"
        "stylelint.vscode-stylelint"
        "2gua.rainbow-brackets"
        "SmukkeKim.theme-setimonokai"
        "mikestead.dotenv"
        "teabyii.ayu"
        "cssho.vscode-svgviewer"
        "vscodevim.vim"
        "rust-lang.rust-analyzer"
        "tamasfe.even-better-toml"
        "karunamurti.tera"
    )

    log_info "Installing VS Code extensions..."
    for extension in "${extensions[@]}"; do
        log_info "Installing extension: ${extension}"
        if code --install-extension "${extension}" >/dev/null 2>&1; then
            log_success "Installed: ${extension}"
        else
            log_warn "Failed to install: ${extension}"
        fi
    done
}

# Source aliases if they exist
source_aliases() {
    local aliases_file="${HOME}/.aliases"

    if [[ -f "${aliases_file}" ]]; then
        log_info "Sourcing aliases..."
        if [[ "${DRY_RUN}" == "true" ]]; then
            log_info "[DRY RUN] Would source: ${aliases_file}"
        else
            # Source in subshell to avoid affecting this script
            # shellcheck source=/dev/null
            if (source "${aliases_file}"); then
                log_success "Sourced aliases successfully"
            else
                log_warn "Failed to source aliases (non-critical)"
            fi
        fi
    fi
}

# Validate environment
validate_environment() {
    log_info "Validating environment..."

    # Check if running from a directory that looks like a dotfiles repo
    if [[ ! -d "${SCRIPT_DIR}/.config" ]] && [[ ! -f "${SCRIPT_DIR}/.bashrc" ]] && [[ ! -f "${SCRIPT_DIR}/.tmux.conf" ]]; then
        log_error "This doesn't appear to be a dotfiles directory"
        log_error "Expected to find .config/, .bashrc, or .tmux.conf in: ${SCRIPT_DIR}"
        return 1
    fi

    # Check for required commands
    local required_commands=("ln" "mkdir" "cp")
    for cmd in "${required_commands[@]}"; do
        if ! command_exists "${cmd}"; then
            log_error "Required command not found: ${cmd}"
            return 1
        fi
    done

    log_success "Environment validation passed"
}

# Main installation function
main() {
    log_info "Starting dotfiles installation..."
    log_info "Script directory: ${SCRIPT_DIR}"
    log_info "Backup directory: ${BACKUP_DIR}"

    if [[ "${DRY_RUN}" == "true" ]]; then
        log_info "DRY RUN MODE - No changes will be made"
    fi

    # Validate environment first
    validate_environment || return 1

    # Install components
    install_dotfiles || return 1
    install_nvim_config || return 1
    install_packages || return 1
    install_vscode_config || return 1
    source_aliases || return 1

    log_success "Dotfiles installation completed successfully!"

    if [[ -d "${BACKUP_DIR}" ]]; then
        log_info "Backup files are available in: ${BACKUP_DIR}"
    fi

    log_info "You may need to restart your shell or source your shell configuration to apply changes"
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    parse_args "$@"
    main
fi
