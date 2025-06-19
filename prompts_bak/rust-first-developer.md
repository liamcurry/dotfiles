---
description: Personal development preferences for Rust-first pragmatic developer
globs:
alwaysApply: true
---

# Rust-First Pragmatic Developer Preferences

This rule defines personal development preferences for a Rust-first developer who takes a pragmatic, iterative approach to technology selection and implementation. Use this when making technology recommendations, suggesting tools, or planning development approaches.

## Developer Profile

### Core Identity
- **Primary Language**: Rust developer with deep ecosystem knowledge
- **Philosophy**: Rust-first but pragmatically flexible
- **Approach**: Iterative development with potential Rust rewrites
- **Tool Selection**: Quality and maintainability over novelty

### Development Methodology
- **Start Simple**: Build foundational understanding before optimization
- **Iterate Intelligently**: Begin with proven solutions, evolve to Rust when beneficial
- **Quality Over Speed**: Prefer well-maintained, reputable tools
- **Full-Stack Thinking**: Consider Rust across entire technology stack when possible

## Technology Stack Preferences

### Rust-First Philosophy

```xml
<preference>
<context>When possible and practical</context>
<choice>Rust across the entire stack</choice>
<rationale>
- Performance and safety benefits
- Unified language reduces context switching
- Better tooling integration
- Single dependency management system
</rationale>
</preference>
```

### Full-Stack Rust Preferences
- **Backend**: Actix-web, Axum, Warp, or Rocket
- **Frontend**: Yew, Leptos, or Dioxus for web assembly
- **Smart Contracts**: Rust-based blockchain frameworks (Solana, NEAR)
- **CLI Tools**: Rust implementations via `cargo install`
- **Scripts**: Rust for performance-critical automation
- **Databases**: SurrealDB, or Rust ORM/query builders (SQLx, Diesel)

### Pragmatic Alternatives Framework

```xml
<decision_tree>
<question>Is there a mature, well-maintained Rust solution?</question>
<yes>
  <action>Prefer Rust solution</action>
  <validation>Check community activity, documentation quality, API stability</validation>
</yes>
<no>
  <question>Is this a critical path that justifies custom Rust development?</question>
  <yes>
    <action>Consider building Rust solution or contributing to existing project</action>
  </yes>
  <no>
    <action>Use best-in-class solution in appropriate language</action>
    <note>Plan for potential Rust rewrite when ecosystem matures</note>
  </no>
</no>
</decision_tree>
```

## Tool Selection Criteria

### Rust CLI Tools (cargo install)

#### Preferred Characteristics
- **Reputable Sources**: Well-known maintainers or organizations
- **Active Development**: Recent commits, responsive to issues
- **Quality Indicators**:
  - Comprehensive documentation
  - Good test coverage
  - Clear changelog/versioning
  - Multiple contributors
  - Used by other reputable projects

#### Examples of Preferred Tools
```rust
// Good: Well-maintained, widely adopted
cargo install ripgrep    // grep alternative
cargo install fd-find    // find alternative  
cargo install bat        // cat alternative
cargo install exa        // ls alternative
cargo install tokei      // code statistics
cargo install hyperfine  // benchmarking
cargo install just       // make alternative
cargo install zoxide     // cd alternative
```

#### Red Flags to Avoid
- **Single Developer**: No bus factor protection
- **Stale Development**: No commits in 6+ months without stability justification
- **Poor Documentation**: Unclear usage or installation instructions
- **Experimental Status**: Explicitly marked as alpha/experimental
- **Security Concerns**: No response to security issues

### Non-Rust Tool Selection

When Rust alternatives don't meet quality criteria:

```xml
<fallback_strategy>
<principles>
1. Choose mature, battle-tested solutions
2. Prefer tools with active communities
3. Prioritize security and maintainability
4. Plan migration path to Rust when available
</principles>

<examples>
<example>
Scenario: Need a database for new project
Rust Option: SurrealDB (newer, smaller ecosystem)
Pragmatic Choice: PostgreSQL with SQLx
Rationale: PostgreSQL's maturity and ecosystem while using Rust client
Migration Path: Consider SurrealDB for future projects as it matures
</example>

<example>
Scenario: Frontend development for MVP
Rust Option: Yew/Leptos (steeper learning curve)
Pragmatic Choice: React/Next.js
Rationale: Faster development, larger talent pool for iteration
Migration Path: Rewrite performance-critical components in WASM/Rust
</example>
</examples>
</fallback_strategy>
```

## Development Methodology

### Iterative Rust Adoption

#### Phase 1: Foundation Building
- **Goal**: Understand problem domain and requirements
- **Approach**: Use proven tools to build working solution
- **Rust Integration**: CLI tools, build scripts, performance utilities

#### Phase 2: Strategic Rust Integration  
- **Goal**: Replace performance-critical or safety-critical components
- **Approach**: Incremental replacement of bottlenecks
- **Focus Areas**: 
  - API services with high throughput requirements
  - Data processing pipelines
  - Security-sensitive operations

#### Phase 3: Full Rust Migration (When Justified)
- **Triggers**:
  - Performance requirements demanding systems programming
  - Team expertise has grown
  - Maintenance burden of mixed stack outweighs benefits
  - Rust ecosystem has matured in problem domain

### Project Planning Framework

```xml
<project_evaluation>
<technical_factors>
- Performance requirements (CPU, memory, latency)
- Safety requirements (financial, security, reliability)
- Team expertise and learning capacity
- Deployment and operational complexity
- Integration with existing systems
</technical_factors>

<business_factors>
- Development timeline constraints
- Budget for learning curve
- Hiring and talent availability
- Long-term maintenance considerations
- Risk tolerance for newer technologies
</business_factors>

<rust_recommendation>
<high_priority>
- Backend APIs with performance requirements
- CLI tools for personal/team use
- Data processing with safety requirements
- Smart contracts (when blockchain is chosen)
</high_priority>

<medium_priority>
- Frontend with WebAssembly requirements
- System utilities and automation scripts
- Database layers with complex query logic
</medium_priority>

<low_priority>
- Simple scripting tasks
- Rapid prototyping and MVPs
- Integration with legacy systems requiring specific languages
</low_priority>
</rust_recommendation>
</project_evaluation>
```

## Communication Preferences

### Code Recommendations
- **Always Explain Trade-offs**: Why Rust vs. alternatives
- **Provide Migration Paths**: How to evolve solutions over time
- **Include Learning Resources**: Quality Rust learning materials
- **Show Ecosystem Status**: Maturity of Rust solutions in domain

### Tool Suggestions
- **Quality Metrics**: Show evidence of tool reliability
- **Installation Instructions**: Prefer `cargo install` when appropriate
- **Alternative Options**: Provide both Rust and non-Rust alternatives
- **Community Validation**: Reference usage by reputable projects

## Anti-Patterns to Avoid

### Technology Selection Mistakes
- **Rust Everywhere Immediately**: Forcing Rust before understanding requirements
- **Tool Hoarding**: Installing every new Rust CLI without evaluation
- **Premature Optimization**: Choosing Rust for problems that don't need performance
- **Ecosystem Immaturity Denial**: Ignoring when Rust solutions aren't ready

### Development Process Mistakes
- **Big Bang Rewrites**: Attempting full stack Rust migration at once
- **Ignoring Team Capacity**: Not accounting for Rust learning curve
- **Maintenance Neglect**: Not updating or contributing to Rust tools used
- **Quality Compromise**: Accepting lower-quality Rust tools just for language consistency

## Success Metrics

### Personal Development
- **Rust Proficiency**: Comfortable with advanced Rust patterns
- **Ecosystem Knowledge**: Aware of quality crates in relevant domains
- **Pragmatic Balance**: Can articulate when not to use Rust
- **Tool Mastery**: Effective use of Rust-based development tools

### Project Outcomes
- **Performance Goals**: Meeting or exceeding performance requirements
- **Maintainability**: Code that team can understand and modify
- **Quality Standards**: Low bug rates, good test coverage
- **Development Velocity**: Reasonable development speed despite Rust adoption

### Community Contribution
- **Tool Evaluation**: Help identify and promote quality Rust tools
- **Knowledge Sharing**: Document Rust adoption patterns and experiences
- **Ecosystem Improvement**: Contribute to Rust projects when possible

## Integration Guidelines

### With Existing Dotfiles Repository
- **Nix Integration**: Use Rust tools in Nix development shells
- **Shell Configuration**: Alias and integrate Rust CLI tools
- **Development Workflow**: Cargo-based scripts for common tasks
- **Documentation**: Include Rust tool selection rationale

### With Team Development
- **Gradual Introduction**: Start with non-critical Rust adoption
- **Knowledge Transfer**: Pair programming and code review focus
- **Tool Standardization**: Team agreement on Rust tools to adopt
- **Fallback Plans**: Non-Rust alternatives for team members learning

---

## Quick Reference

### When to Recommend Rust
✅ Performance-critical applications  
✅ Safety-critical systems  
✅ CLI tools for power users  
✅ Backend services with concurrency needs  
✅ Systems programming tasks  
✅ Long-term maintenance projects  

### When to Be Pragmatic
⚖️ Rapid prototyping requirements  
⚖️ Team unfamiliar with Rust  
⚖️ Ecosystem immaturity in domain  
⚖️ Tight deadlines  
⚖️ Integration with non-Rust systems  
⚖️ Learning curve exceeds project timeline  

### Red Flags for Tool Selection
❌ Single maintainer with no contributors  
❌ No commits in 6+ months  
❌ Poor or missing documentation  
❌ Experimental/alpha status  
❌ No response to issues or PRs  
❌ Unclear licensing or governance  

**Remember**: The goal is sustainable, high-quality software development. Rust is a powerful tool, but pragmatic judgment determines when and how to apply it effectively.