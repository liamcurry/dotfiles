# Tmux Configuration

Tmux is a terminal multiplexer that lets you switch between programs in one
terminal. A good configuration makes tmux fast and easy to use.

## Key Takeaways

- **Change prefix key**: Replace awkward Ctrl+b with Ctrl+a or Ctrl+Space
- **Enable mouse support**: Add convenience without losing keyboard efficiency
- **Optimize navigation**: Use prefix-free keys for common pane and window
  operations
- **Configure vi mode**: Enable vi keybindings for copy operations and
  scrollback
- **Customize status bar**: Show useful information without visual clutter

## Concepts

### Configuration File Structure

Tmux loads configuration from `~/.tmux.conf` at startup. The file contains
commands that match tmux's command-line syntax. Comments start with `#`. Changes
require reload or restart.

### Key Binding System

Tmux organizes keys into tables:

- **prefix**: Keys after prefix (default Ctrl+b)
- **root**: Keys without prefix
- **copy-mode**: Keys during copying
- **copy-mode-vi**: Vi-style copy keys

Create bindings with `bind-key`, remove with `unbind-key`.

### Prefix Key Strategy

Prefix acts as escape sequence. Default Ctrl+b conflicts with tools and feels
awkward. Better options: Ctrl+a (screen-compatible) or Ctrl+Space (accessible).

### Mouse Integration

Mouse support helps beginners and shared setups. Enable with `set -g mouse on`.
Allows pane clicks, drag resizing, and scroll history.

### Status Bar Customization

Status bar shows session info and system data. Configure colors, content, and
refresh rate. Keep useful but minimal.

## Rules

1. **Change the prefix key** - Use Ctrl+a or Ctrl+Space instead of default
   Ctrl+b
2. **Enable mouse support** - Add `set -g mouse on` for easier interaction
3. **Add config reload** - Bind `r` to reload configuration without restarting
   tmux
4. **Use prefix-free navigation** - Bind Alt+arrows for pane switching without
   prefix
5. **Configure intuitive splits** - Use `|` for vertical and `-` for horizontal
   splits
6. **Enable vi mode** - Add `setw -g mode-keys vi` for vi-style copy operations
7. **Set base index to 1** - Start windows and panes at 1 instead of 0
8. **Increase history limit** - Set `set -g history-limit 10000` for more
   scrollback
9. **Configure status bar** - Show useful info like session name, window list,
   time
10. **Use 256 colors** - Add `set -g default-terminal "screen-256color"` for
    better colors
11. **Disable escape delay** - Set `set -sg escape-time 0` to fix vim/editor
    mode switching delays
12. **Name your sessions** - Use descriptive names for different projects or
    tasks

## Examples

### Basic Configuration (dotfiles/.tmux.conf)

**Good:**

```bash
# Change prefix to Ctrl+a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

# Enable mouse
set -g mouse on

# Reload config
bind r source-file ~/.tmux.conf \; display "Reloaded!"

# Intuitive splits
bind | split-window -h
bind - split-window -v

# Prefix-free pane switching
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
```

**Bad:**

```bash
# Default Ctrl+b prefix
# No mouse support
# No config reload shortcut
# Awkward % and " splits
# All navigation needs prefix
```

### Navigation Optimization

**Good:**

```bash
# Fast window switching with Alt+number
bind -n M-1 select-window -t 1
bind -n M-2 select-window -t 2
bind -n M-3 select-window -t 3

# Vi-style pane selection
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Quick pane resizing
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5
```

**Bad:**

```bash
# Only default Ctrl+b + number for windows
# No vi-style navigation
# No quick resize options
# Every action requires prefix key
```

### Status Bar Configuration

**Good:**

```bash
# Status bar appearance
set -g status-bg colour235
set -g status-fg colour136
set -g status-left-length 40
set -g status-left "#[fg=green]Session: #S #[fg=yellow]#I #[fg=cyan]#P"
set -g status-right "#[fg=cyan]%d %b %R"
set -g status-justify centre

# Highlight active window
setw -g window-status-current-style fg=colour166,bg=colour19
```

**Bad:**

```bash
# Using default status bar colors
# No session or time information
# No visual indication of active window
# Cluttered or missing status information
```

### Copy Mode Setup

**Good:**

```bash
# Use vi keys in copy mode
setw -g mode-keys vi

# Copy to system clipboard
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"

# Enter copy mode with prefix+v
bind v copy-mode
```

**Bad:**

```bash
# Using default emacs-style keys
# No system clipboard integration
# Hard to remember copy mode entry
```

### Session Management

**Good:**

```bash
# Start new session with name
tmux new-session -d -s development

# Create project-specific sessions
alias tmux-web='tmux new-session -d -s web -c ~/projects/web'
alias tmux-api='tmux new-session -d -s api -c ~/projects/api'

# Auto-create windows for workflow
tmux new-window -t web:1 -n 'editor'
tmux new-window -t web:2 -n 'server'
tmux new-window -t web:3 -n 'tests'
```

**Bad:**

```bash
# Always using default session names
# Starting without directory context
# Manual window creation each time
```

## Resources

- [Tmux Manual](https://man7.org/linux/man-pages/man1/tmux.1.html) - Complete
  reference documentation
- [Ham Vocke's Tmux Guide](https://hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/) -
  Practical configuration examples
- [Tmux GitHub Wiki](https://github.com/tmux/tmux/wiki) - Official guides and
  advanced topics
- [gpakosz/.tmux](https://github.com/gpakosz/.tmux) - Popular community
  configuration
- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) - Plugin ecosystem
  and management

## Checklist

- [ ] **Change prefix key** from Ctrl+b to something more convenient
- [ ] **Enable mouse support** for easier interaction
- [ ] **Add config reload** binding for quick iteration
- [ ] **Configure intuitive splits** using | and - characters
- [ ] **Set up prefix-free navigation** with Alt+arrows or vi keys
- [ ] **Enable vi mode** for copy operations
- [ ] **Start indexing at 1** for windows and panes
- [ ] **Increase history limit** to at least 10,000 lines
- [ ] **Customize status bar** with useful information
- [ ] **Set 256 color support** for better visual experience
- [ ] **Remove escape delay** to fix editor mode switching
- [ ] **Create named sessions** for different projects
- [ ] **Test configuration** by reloading and using new bindings
- [ ] **Document custom bindings** for future reference

