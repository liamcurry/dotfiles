# Nix

Master declarative package management and system configuration through
functional programming principles for reproducible environments.

## KEY TAKEAWAYS

- **Functional deployment model**: Treats package builds as pure functions with
  deterministic outputs
- **Content-addressed storage**: Uses cryptographic hashes to uniquely identify
  build artifacts
- **Declarative configuration**: Describe what you want, not how to get there
- **Atomic operations**: System changes either complete fully or rollback
  entirely
- **Isolated environments**: Multiple package versions coexist without conflicts
- **Reproducible builds**: Identical inputs always produce identical outputs
- **Lazy evaluation**: Only builds what's needed when it's needed

## CONCEPTS

### The Nix Store

The Nix store is a content-addressed filesystem at `/nix/store` containing all
packages, configurations, and dependencies. Each store path includes a
cryptographic hash derived from all inputs, ensuring uniqueness and
reproducibility.

Store paths follow the pattern: `/nix/store/[hash]-[name]-[version]`. This hash
encompasses the package source, dependencies, compiler flags, and build
environment. Any change to inputs produces a different hash, creating a new
store path.

### Derivations

Derivations are the fundamental building blocks in Nix. They're precise
descriptions of how to build packages, including sources, dependencies, build
scripts, and environment variables. Think of derivations as recipes that, given
the same ingredients, always produce the same dish.

A derivation specifies:

- Input sources (tarballs, git repositories)
- Build dependencies (compilers, libraries)
- Build instructions (configure, make, install)
- Output paths in the Nix store

### Functional Programming Model

Nix applies functional programming principles to package management. Packages
are functions that take dependencies as inputs and produce built software as
output. This functional approach enables:

- **Purity**: Builds are isolated from the host system
- **Immutability**: Store paths never change after creation
- **Composition**: Complex systems built from simple functions
- **Laziness**: Evaluates only what's needed

### Profiles and Generations

User environments in Nix are managed through profiles, which are symlinks to
specific package sets. Each change creates a new generation, preserving the
previous state. This enables instant rollbacks to any previous configuration.

Generations provide:

- History of all system states
- Atomic switches between configurations
- Garbage collection of unused packages
- Multiple simultaneous environments

### Channels and Flakes

Channels are versioned collections of packages (like nixpkgs-23.11). They
provide a stable set of packages that work together. Flakes are the newer,
experimental approach that locks exact versions of all inputs for perfect
reproducibility.

Key differences:

- **Channels**: Imperative updates, system-wide, traditional approach
- **Flakes**: Declarative inputs, per-project locks, modern approach

## RULES

### Package Definition

1. **Use mkDerivation for packages**: Standard builder for most software
2. **Specify all dependencies explicitly**: Never rely on system packages
3. **Pin sources by hash**: Use `fetchurl` with sha256 for reproducibility
4. **Separate build and runtime dependencies**: Use `buildInputs` vs
   `propagatedBuildInputs`
5. **Patch shebangs automatically**: Let Nix fix script interpreters

### Development Environments

6. **Create project shells**: Use `mkShell` for development environments
7. **Avoid installing globally**: Use `nix-shell` or `nix develop` instead
8. **Pin nixpkgs version**: Lock to specific commit for reproducibility
9. **Use direnv integration**: Automatic environment loading on directory entry

### System Configuration

10. **Modularize configuration**: Split into logical files using imports
11. **Override with precedence**: Use `mkForce`, `mkDefault`, `mkBefore`,
    `mkAfter`
12. **Test changes safely**: Use `nixos-rebuild test` before `switch`
13. **Keep secrets out**: Never store passwords or keys in Nix files

### Best Practices

14. **Let Nix manage dependencies**: Don't mix with system package managers
15. **Use overlays for customization**: Modify packages without forking nixpkgs
16. **Enable flakes experimentally**: Add to `nix.conf` for modern features
17. **Garbage collect regularly**: Run `nix-collect-garbage -d` to free space

## EXAMPLES

### Basic Package Definition

**GOOD**:

```nix
{ stdenv, fetchurl, zlib, openssl }:

stdenv.mkDerivation rec {
  pname = "myapp";
  version = "1.2.3";
  
  src = fetchurl {
    url = "https://example.com/myapp-${version}.tar.gz";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };
  
  buildInputs = [ zlib openssl ];
  
  meta = with stdenv.lib; {
    description = "A useful application";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
```

_Why: Explicitly declares all dependencies, uses content hashing, includes
metadata_

**BAD**:

```nix
{ stdenv }:

stdenv.mkDerivation {
  name = "myapp";
  src = ./myapp.tar.gz;
  buildPhase = ''
    gcc myapp.c -lz -lssl -o myapp
  '';
  installPhase = ''
    cp myapp $out/bin/
  '';
}
```

_Why: Assumes system libraries, uses local paths, missing dependency
declarations_

### Development Shell

**GOOD**:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs-18_x
    (python3.withPackages (ps: with ps; [
      requests
      pytest
    ]))
    postgresql
  ];
  
  shellHook = ''
    echo "Development environment loaded"
    export DATABASE_URL="postgresql://localhost/myapp"
  '';
}
```

_Why: Pins Node.js version, bundles Python packages, sets up environment_

**BAD**:

```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs
    python3
    python3Packages.requests
    python3Packages.pytest
    postgresql
  ];
}
```

_Why: Unpinned Node version, Python packages not bundled properly, no
environment setup_

### NixOS Module

**GOOD**:

```nix
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.myapp;
in {
  options.services.myapp = {
    enable = mkEnableOption "myapp service";
    
    port = mkOption {
      type = types.port;
      default = 8080;
      description = "Port to listen on";
    };
    
    package = mkOption {
      type = types.package;
      default = pkgs.myapp;
      description = "Package to use";
    };
  };
  
  config = mkIf cfg.enable {
    systemd.services.myapp = {
      description = "My Application";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/myapp --port ${toString cfg.port}";
        Restart = "on-failure";
        DynamicUser = true;
      };
    };
    
    networking.firewall.allowedTCPPorts = [ cfg.port ];
  };
}
```

_Why: Proper option types, conditional configuration, secure service setup_

**BAD**:

```nix
{ config, pkgs, ... }:

{
  systemd.services.myapp = {
    description = "My Application";
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.myapp}/bin/myapp --port 8080
    '';
    serviceConfig = {
      User = "root";
    };
  };
  
  networking.firewall.allowedTCPPorts = [ 8080 ];
}
```

_Why: No options, runs as root, hardcoded values, always enabled_

### Flake Definition

**GOOD**:

```nix
{
  description = "My project";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.callPackage ./default.nix {};
        
        devShells.default = pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.default ];
          buildInputs = with pkgs; [ 
            nixpkgs-fmt
            nil
          ];
        };
      });
}
```

_Why: Pinned nixpkgs, cross-platform support, separate dev dependencies_

**BAD**:

```nix
{
  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = 
      nixpkgs.legacyPackages.x86_64-linux.hello;
  };
}
```

_Why: No description, single platform, no inputs section, outdated attribute
names_

## CHECKLIST

### Initial Setup

1. [ ] **Install Nix** - Use official installer with daemon mode for multi-user
       support
2. [ ] **Configure nix.conf** - Enable experimental features like flakes and
       nix-command
3. [ ] **Choose channel or flakes** - Decide between traditional channels or
       modern flakes
4. [ ] **Set up direnv** - Install direnv for automatic environment activation

### Project Configuration

5. [ ] **Create shell.nix or flake.nix** - Define development environment
       declaratively
6. [ ] **Pin nixpkgs version** - Lock to specific commit hash for
       reproducibility
7. [ ] **Specify all dependencies** - List every tool, library, and runtime
       dependency
8. [ ] **Add .envrc for direnv** - Enable automatic environment loading

### Package Development

9. [ ] **Write derivation** - Create package definition with proper inputs and
       phases
10. [ ] **Test build locally** - Use `nix-build` to verify package builds
        correctly
11. [ ] **Check runtime dependencies** - Verify with `nix-store -q --references`
12. [ ] **Add package tests** - Include tests that run during build

### System Management

13. [ ] **Modularize NixOS config** - Split configuration into logical modules
14. [ ] **Test configuration** - Run `nixos-rebuild test` before applying
15. [ ] **Document options** - Add descriptions to custom module options
16. [ ] **Set up rollback strategy** - Know how to revert to previous
        generations

### Maintenance

17. [ ] **Update regularly** - Keep channels or flake inputs current
18. [ ] **Garbage collect** - Remove old generations and unused store paths
19. [ ] **Monitor disk usage** - Check `/nix/store` size periodically
20. [ ] **Review security** - Ensure no secrets in configurations

