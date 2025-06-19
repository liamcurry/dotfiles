# dprint - Code Formatting Tool

dprint is a pluggable and configurable code formatting platform that formats
source code using language-specific plugins.

## Key Commands

### Primary Operations

- **Format files**: `dprint fmt` - Formats source files and writes results to
  filesystem
- **Check formatting**: `dprint check` - Checks for any files that haven't been
  formatted (useful for CI/CD)
- **Initialize configuration**: `dprint init` - Creates a dprint.json
  configuration file

### Utility Commands

- **View file paths**: `dprint output-file-paths` - Shows resolved file paths
  for plugins
- **View config**: `dprint output-resolved-config` - Shows resolved
  configuration
- **Performance debugging**: `dprint output-format-times` - Shows formatting
  time per file
- **Clear cache**: `dprint clear-cache` - Deletes plugin cache directory
- **Upgrade**: `dprint upgrade` - Updates dprint executable

## Current Project Configuration

Located at `.config/dprint.json`:

### Supported Languages/Formats

- **JSON** (4-space indentation, no tabs)
- **Dockerfile**
- **TypeScript/JavaScript**
- **Markdown** (always wrap text)
- **YAML** (via pretty_yaml plugin)
- **Python** (via ruff plugin)
- **Jupyter Notebooks**

### Key Settings

- JSON: 4-space indentation, no tabs
- Markdown: Always wrap text

## Usage Patterns

### File Pattern Matching

```bash
# Format specific file types
dprint fmt "**/*.{ts,tsx,js,jsx,json}"

# Format specific files
dprint fmt src/index.ts README.md
```

### Configuration Options

- **Custom config**: `dprint fmt --config path/to/config/dprint.json`
- **Plugin override**: `--plugins <urls/files>...`
- **Log level**: `-L, --log-level <level>` (debug, info, warn, error, silent)

## Environment Variables

- `DPRINT_CACHE_DIR`: Directory for dprint cache
- `DPRINT_MAX_THREADS`: Limit formatting threads (e.g., `DPRINT_MAX_THREADS=4`)
- `DPRINT_CERT`: Load certificate authority from PEM file
- `DPRINT_TLS_CA_STORE`: Certificate stores ("mozilla", "system")
- `HTTPS_PROXY`: Proxy for downloading plugins/configs

## Integration with Development Workflow

### Pre-commit Checks

Use `dprint check` in CI/CD pipelines to ensure code is properly formatted.

### IDE Integration

- Language Server: `dprint lsp` provides language server for editor integration
- Shell completions: `dprint completions` generates shell completion scripts

## Best Practices

1. **Always run `dprint fmt` before committing** - Ensures consistent formatting
2. **Use `dprint check` in CI** - Prevents improperly formatted code from being
   merged
3. **Configure editor integration** - Use the LSP for real-time formatting
4. **Keep plugins updated** - dprint will notify about newer plugin versions

## Troubleshooting

- **Cache issues**: Run `dprint clear-cache` to reset plugin cache
- **Performance**: Use `dprint output-format-times` to identify slow files
- **Configuration debugging**: Use `dprint output-resolved-config` to verify
  settings
