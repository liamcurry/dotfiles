# Nix

A purely functional package manager that makes reproducible development
environments and system configurations simple and reliable.

## Key Takeaways

- **Reproducible**: Same inputs always produce identical outputs across any
  machine
- **Immutable**: Packages never change after installation, preventing version
  conflicts
- **Declarative**: Describe what you want, not how to get it
- **Rollback**: Easily revert to previous configurations when changes break
  things
- **Isolated**: Multiple versions of packages coexist without conflicts

## Concepts

### The Nix Store

Nix stores packages in `/nix/store` with unique identifiers that capture all
dependencies. Each package gets its own directory like
`/nix/store/abc123-package-1.0/`. This isolation prevents conflicts and enables
multiple versions.

### Derivations

A derivation is a recipe for building something. It specifies inputs, build
instructions, and outputs. Derivations are immutable - once created, they never
change. This guarantees reproducibility.

The build process has two phases:

1. **Evaluation**: Parse Nix expressions, create derivation (.drv) files
2. **Realization**: Build outputs from derivation files recursively

### Expressions

Nix uses a domain-specific functional language to describe packages and
configurations. Everything is an expression that evaluates to a value. The
language is pure (no side effects) and lazy (computes only when needed).

Key syntax:

- `let ... in` - variable assignment
- `${...}` - string interpolation
- `with pkgs;` - bring package set into scope
- `mkShell`, `mkDerivation` - common builder functions

### Profiles and Environments

Profiles are collections of packages that appear in your PATH. You can have
multiple profiles for different projects. Development environments provide
temporary shells with specific tools without affecting your system.

Use `nix-shell` for ad-hoc environments or `nix develop` with flakes for
reproducible project environments.

### Flakes (Recommended)

Flakes are the modern way to write Nix expressions. They pin dependencies to
specific versions in a lock file, ensuring perfect reproducibility. Every flake
has a `flake.nix` file describing inputs and outputs.

Enable flakes in your Nix configuration:
`experimental-features = nix-command flakes`

## Rules

1. **Use flakes for new projects**: Start with `nix flake init` to create a
   flake template
2. **Pin all dependencies**: Never rely on system packages or global state
3. **Keep expressions simple**: Use existing packages from nixpkgs instead of
   building from scratch
4. **Use development shells**: Create project-specific environments with
   `nix develop`
5. **Version control lock files**: Always commit `flake.lock` to ensure team
   reproducibility
6. **Leverage binary caches**: Use Hydra and other caches to avoid rebuilding
   packages
7. **Separate concerns**: Keep system configuration, user environment, and
   project dependencies distinct
8. **Use stdenv.mkDerivation**: Don't use raw `derivation` function - use
   standard wrappers
9. **Test before committing**: Use `nix flake check` to validate your flake
   configuration
10. **Clean up regularly**: Run `nix-collect-garbage` to remove unused packages
    and save space

## Examples

### Good: Simple Development Shell

```nix
# flake.nix
{
  description = "Python development environment";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python3
            python3Packages.requests
            python3Packages.pytest
          ];
        };
      });
}
```

**Bad: Mixing Package Managers**

```bash
# Don't do this - breaks reproducibility
pip install requests
nix-env -i python3
apt install python3-dev
```

### Good: Pinned Dependencies

```nix
# Pin specific versions in flake.nix
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  flake-utils.url = "github:numtide/flake-utils";
};
```

**Bad: Unpinned Dependencies**

```nix
# Don't do this - breaks reproducibility over time
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs"; # No version specified
};
```

### Good: Project Structure

```
my-project/
├── flake.nix       # Main flake configuration
├── flake.lock      # Locked dependency versions
├── src/            # Source code
└── .envrc          # direnv integration (optional)
```

**Bad: System Pollution**

```bash
# Don't install project tools globally
nix-env -i nodejs
nix-env -i python3
# This pollutes your system profile
```

### Good: Package Building

```nix
# Use standard environment and existing packages
stdenv.mkDerivation {
  pname = "my-tool";
  version = "1.0.0";
  
  src = fetchFromGitHub {
    owner = "myorg";
    repo = "my-tool";
    rev = "v1.0.0";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  
  buildInputs = [ cmake openssl ];
}
```

**Bad: Raw Derivation**

```nix
# Don't use raw derivation function
derivation {
  name = "my-tool";
  system = "x86_64-linux";
  builder = "/bin/bash";
  # Missing standard environment, hard to maintain
}
```

## Resources

- [Nix Pills](https://nixos.org/guides/nix-pills/) - Step-by-step tutorial
  series
- [nix.dev](https://nix.dev/) - Official documentation and tutorials
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/) -
  Comprehensive beginner guide
- [Zero to Nix](https://zero-to-nix.com/) - Quick start guide
- [Tweag Flakes Tutorial](https://www.tweag.io/blog/2020-05-25-flakes/) - Deep
  dive into flakes

## Checklist

- [ ] **Install Nix**: Use official installer with
      `experimental-features = nix-command flakes`
- [ ] **Create flake.nix**: Define inputs and outputs for your project
- [ ] **Pin dependencies**: Specify exact versions in inputs (e.g.,
      `nixos-23.11`)
- [ ] **Test environment**: Run `nix develop` to enter development shell
- [ ] **Validate flake**: Use `nix flake check` to verify configuration
- [ ] **Version control**: Commit both `flake.nix` and `flake.lock` files
- [ ] **Document usage**: Add README with `nix develop` instructions for team
- [ ] **Set up binary cache**: Configure Hydra or custom cache for faster builds
- [ ] **Regular cleanup**: Schedule `nix-collect-garbage -d` to manage disk
      space
- [ ] **Learn debugging**: Use `--show-trace` and `nix repl` for troubleshooting
- [ ] **Test cross-platform**: Verify flake works on different systems
      (Linux/macOS)
- [ ] **Use direnv**: Set up `.envrc` for automatic environment loading

