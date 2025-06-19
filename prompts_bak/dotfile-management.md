# Dotfile Management

Track and sync your configuration files across machines using version control
and proven organization strategies.

## Key Takeaways

- **Version control is essential**: Use Git to track changes and sync across
  machines
- **Security matters**: Keep sensitive data separate and use private
  repositories
- **Simple approaches work best**: Bare repositories or symlink farms handle
  most needs
- **Backup strategy is critical**: Combine Git with automated backups and test
  restores
- **Organization enables scaling**: Structure files logically for easy
  maintenance

## Concepts

### What Are Dotfiles

Dotfiles are configuration files that start with a dot (`.bashrc`, `.vimrc`,
`.gitconfig`). They control how your applications and shell behave. Managing
them well saves time when setting up new machines and keeps your environment
consistent.

### Core Management Approaches

**Bare Git Repository**: Store Git repository in a side folder like `~/.cfg`.
Use an alias to run Git commands against this repository, not the usual `.git`
folder. No extra tools needed. No symlinks created. Works with any Git hosting
service.

**Symlink Farm**: Put all dotfiles in one directory like `~/.dotfiles`. Create
symbolic links from home directory to dotfiles directory. GNU Stow handles this
automatically. Easy to understand and debug.

**Dedicated Tools**: Tools like chezmoi, homeshick, or yadm add features like
templates, encryption, and cross-platform support. More complex but powerful for
advanced users.

### Security Considerations

Never commit sensitive files like `.ssh`, `.gnupg`, or API tokens. Use private
repositories for any personal configs. Encrypt secrets before storing. Keep
passwords and keys in password managers, not dotfiles.

### Backup Strategy

Git handles version control and remote storage. Add automated backups with Time
Machine or cloud storage. Test restores monthly. Use three methods: Git,
automated backup, manual copy.

## Rules

1. **Initialize Git repository**: Run `git init` in your dotfiles directory
   today
2. **Use private repositories**: Set GitHub/GitLab repos to private for personal
   configs
3. **Create whitelist .gitignore**: Add `*` then `!filename` for each tracked
   file
4. **Separate secrets**: Never commit API keys, SSH keys, or passwords to Git
5. **Test monthly restores**: Clone repo on fresh system and run install script
6. **Write install instructions**: Create README with setup steps for new
   machines
7. **Use branches per environment**: Create `work`, `personal`, `server`
   branches
8. **Create install scripts**: Write `install.sh` that backs up and creates
   symlinks
9. **Start simple**: Begin with Git only, add tools like Stow or chezmoi later
10. **Clean up quarterly**: Remove unused configs and update documentation

## Examples

### Example 1: Bare Repository Setup

**GOOD**:

```bash
# Initialize bare repository
git init --bare ~/.dotfiles

# Create alias for dotfile commands
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Don't show untracked files
dotfiles config --local status.showUntrackedFiles no

# Add and commit files
dotfiles add .bashrc
dotfiles commit -m "Add bashrc configuration"
dotfiles push origin main
```

**BAD**:

```bash
# Initialize regular repository in home directory
cd ~
git init
git add .
git commit -m "Everything"
git push origin main
```

### Example 2: GNU Stow Setup

**GOOD**:

```bash
# Create organized structure
mkdir -p ~/.dotfiles/{bash,git,vim}
mv ~/.bashrc ~/.dotfiles/bash/
mv ~/.gitconfig ~/.dotfiles/git/
mv ~/.vimrc ~/.dotfiles/vim/

# Use stow to create symlinks
cd ~/.dotfiles
stow bash git vim

# Verify links were created
ls -la ~ | grep " -> "
```

**BAD**:

```bash
# Mixed organization, no grouping
~/.dotfiles/
├── bashrc
├── bash_profile  
├── gitconfig
├── vimrc
└── everything_mixed_together
```

### Example 3: Security Practices

**GOOD**:

```bash
# .gitignore
*
!.bashrc
!.vimrc
!.gitconfig
!install.sh

# Separate file for secrets
echo "export API_KEY=secret" > ~/.secrets
chmod 600 ~/.secrets

# Source secrets in bashrc
echo "[ -f ~/.secrets ] && source ~/.secrets" >> ~/.bashrc
```

**BAD**:

```bash
# In .bashrc (committed to public repo)
export API_KEY="sk-1234567890abcdef"
export SSH_PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----"
export DATABASE_PASSWORD="admin123"
```

### Example 4: Installation Script

**GOOD**:

```bash
#!/bin/bash
set -euo pipefail

# Backup existing files
backup_dir="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

for file in .bashrc .vimrc .gitconfig; do
    if [[ -f "$HOME/$file" ]]; then
        cp "$HOME/$file" "$backup_dir/"
    fi
done

# Create symlinks
ln -sf "$HOME/.dotfiles/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$HOME/.dotfiles/vim/.vimrc" "$HOME/.vimrc"
ln -sf "$HOME/.dotfiles/git/.gitconfig" "$HOME/.gitconfig"

echo "Dotfiles installed. Backup created at $backup_dir"
```

**BAD**:

```bash
#!/bin/bash
# Just overwrite everything
cp -r .dotfiles/* ~/
# No backups, no error handling, no verification
```

### Example 5: Tool Selection

**GOOD - Start Simple**:

```bash
# Basic Git approach for beginners
git init ~/.dotfiles
cd ~/.dotfiles
git add .bashrc .vimrc
git commit -m "Initial dotfiles"
git remote add origin git@github.com:user/dotfiles.git
git push -u origin main
```

**GOOD - Advanced Users**:

```bash
# chezmoi for complex needs
chezmoi init https://github.com/user/dotfiles.git
chezmoi apply
# Handles templating, encryption, cross-platform differences
```

**BAD**:

```bash
# Using advanced tools without understanding basics
# Jumping to complex solutions for simple needs
# No backup or testing strategy
```

### Example 6: Testing Your Setup

**GOOD**:

```bash
# Test on clean system (VM or container)
docker run -it ubuntu:latest bash

# Clone and install your dotfiles
git clone https://github.com/user/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh

# Verify everything works
bash -c "source ~/.bashrc && echo 'Bash config loaded'"
vim --version
git config --list
```

**BAD**:

```bash
# Never test setup on clean system
# Assume it works because it works on your machine
# No documentation for new users
# No error handling in install scripts
```

## Resources

- [GitHub Dotfiles Guide](https://dotfiles.github.io/) - Community resources and
  examples
- [Atlassian Bare Repository Tutorial](https://www.atlassian.com/git/tutorials/dotfiles) -
  Detailed bare repo setup
- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html) -
  Symlink farm management
- [chezmoi Documentation](https://www.chezmoi.io/) - Advanced dotfile management
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles) - Tools and
  inspiration

## Checklist

- [ ] Run `git init` in dotfiles directory
- [ ] Create private repository on GitHub/GitLab
- [ ] Add `.gitignore` with `*` and `!.bashrc` entries
- [ ] Remove any API keys or passwords from tracked files
- [ ] Write `install.sh` script with backup creation
- [ ] Test restore process on clean VM or container
- [ ] Create symlinks or bare repository alias working
- [ ] Set up branches for different environments if needed
- [ ] Configure automated backup (Time Machine/cloud storage)
- [ ] Schedule monthly maintenance and cleanup
- [ ] Verify no sensitive data in repository history
- [ ] Document setup process in README file

