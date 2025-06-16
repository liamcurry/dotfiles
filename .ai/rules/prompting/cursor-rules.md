---
description:
globs: *.mdc
alwaysApply: false
---

# Cursor Rules Authoring Guide

A comprehensive meta-prompt for creating effective, modular, and well-structured
Cursor Rules files that maximize AI agent performance and development
productivity.

## Meta-Prompting Framework

### Structure-Oriented Design Principles

Following meta-prompting research (Zhang et al., 2024), this guide emphasizes
**structure and syntax over content**, enabling:

- **Token efficiency**: Reduced context size through pattern focus
- **Zero-shot efficacy**: Abstract frameworks that generalize across domains
- **Categorical organization**: Type-theory inspired logical arrangement
- **Syntax-focused templates**: Reusable patterns for consistent outcomes

### Rule Classification System

```text
RULE_TYPE := ALWAYS | AUTO_ATTACHED | AGENT_REQUESTED | MANUAL
SCOPE := UNIVERSAL | DOMAIN_SPECIFIC | WORKFLOW | TEMPLATE
COMPLEXITY := SIMPLE | STRUCTURED | ADVANCED
ACTIVATION := PATTERN_BASED | CONTEXT_DRIVEN | EXPLICIT_INVOKE
```

## Rule Structure & Format

### MDC Frontmatter Template

```yaml
---
description: Clear, specific description of what this rule accomplishes
globs: file_patterns_to_match  # e.g., *.py, *.js, .env
alwaysApply: true|false        # true for universal rules, false for scoped
---
```

### Rule Types & Activation

- **Always Applied** (`alwaysApply: true`): Core standards that apply
  universally
- **Auto Attached** (`globs: pattern`): Domain-specific rules triggered by file
  patterns
- **Agent Requested** (`description` required): Rules AI can choose to apply
  based on context
- **Manual** (no auto-activation): Explicitly invoked with `@ruleName`

## Content Organization Principles

### 1. Lead with Clear Purpose

Start each rule with a concise statement of what it accomplishes:

```markdown
# [Technology/Domain] Development Standards

This rule ensures [specific outcome] by providing [type of guidance]. Use when
working with [specific context/files/situations].
```

### 2. Structure for Scannability

Organize content hierarchically using consistent patterns:

- `##` for major sections (Strategy, Implementation, Examples)
- `###` for subsections (specific techniques, patterns)
- `####` for detailed breakdowns
- Use bullet points and numbered lists for step-by-step guidance

### 3. Balance Specificity with Flexibility

- **Specific**: Provide concrete examples, code snippets, and exact patterns
- **Flexible**: Use conditional language ("when X, then Y") for
  context-dependent advice
- **Actionable**: Every guideline should be immediately implementable

## Prompt Engineering Best Practices

### Clarity & Precision

- Use imperative mood for directives: "Use X", "Avoid Y", "Implement Z"
- Define technical terms and acronyms on first use
- Provide specific criteria for decision-making (e.g., "functions > 20 lines",
  "coverage < 80%")

### Structured Instructions

- Group related concepts together
- Use consistent formatting for similar types of information
- Employ delimiters (code blocks, tables, lists) to separate different content
  types

### Examples & Patterns

- Include both positive examples ("Do this") and negative examples ("Don't do
  this")
- Provide complete, runnable code snippets when possible
- Use realistic scenarios that developers actually encounter

### Contextual Guidance

- Address common edge cases and exceptions
- Provide decision trees for complex situations
- Include rationale behind recommendations ("because it ensures...")

## Advanced Meta-Prompting Techniques

### Abstract Pattern Templates

Create reusable syntax frameworks that work across domains:

````markdown
### [PATTERN_NAME] Template

**Structure**: [SYNTAX_PATTERN] **Application**: [WHEN_TO_USE] **Variants**:
[ADAPTATIONS]

**Example**:

```[language]
[ABSTRACT_EXAMPLE_SHOWING_STRUCTURE]
```
````

**Adaptations**:

- For [CONTEXT_A]: [SPECIFIC_ADAPTATION]
- For [CONTEXT_B]: [SPECIFIC_ADAPTATION]

````text
### Token-Efficient Organization
Prioritize structure over content verbosity:
- **Pattern-first**: Lead with syntax templates, follow with specific examples
- **Reference-based**: Use `@filename` to include detailed examples externally
- **Conditional logic**: `IF condition THEN pattern ELSE alternative`
- **Categorical grouping**: Organize by type/category rather than feature lists

### Chain-of-Thought Integration
Structure rules to encourage step-by-step reasoning:
```markdown
## Decision Framework
1. **Identify**: [WHAT_TO_LOOK_FOR]
2. **Evaluate**: [CRITERIA_TO_CHECK]  
3. **Choose**: [DECISION_MATRIX]
4. **Implement**: [ACTION_TEMPLATE]
5. **Validate**: [VERIFICATION_STEPS]
````

## Rule Quality Criteria

### Effectiveness Indicators

- **Measurable outcomes**: Rules should target specific, observable improvements
- **Clear boundaries**: Define when the rule applies vs. when it doesn't
- **Consistent terminology**: Use the same terms throughout the rule
- **Complete coverage**: Address the full workflow, not just fragments

### Modularity Guidelines

- **Single responsibility**: Each rule should focus on one domain or concern
- **Composable**: Rules should work together without conflicts
- **Minimal overlap**: Avoid duplicating guidance across multiple rules
- **Clear dependencies**: Reference other rules or files explicitly using
  `@filename`

### Maintainability Features

- **Version awareness**: Reference specific tool/language versions when relevant
- **Update triggers**: Note when the rule should be reviewed (e.g., "Review when
  upgrading to React 19+")
- **Deprecation path**: Provide migration guidance when recommending changes

## Common Patterns & Templates

### Technology-Specific Rules

```markdown
# [Language/Framework] Development Standards

## Core Principles

- [Fundamental approach or philosophy]
- [Key architectural decisions]

## Implementation Guidelines

### [Specific Area 1]

- **Do**: [Recommended approach with example]
- **Don't**: [Anti-pattern with explanation]
- **Why**: [Rationale or benefit]

### [Specific Area 2]

[Similar structure]

## Quality Gates

- [Specific metrics or checks]
- [Tool configurations]
- [Validation commands]

## Examples

[Complete, realistic examples]
```

### Process Rules

```markdown
# [Process Name] Standards

## When to Apply

- [Specific triggers or conditions]
- [Context indicators]

## Step-by-Step Process

1. [Concrete action with example]
2. [Next action with validation]
3. [Final step with outcome]

## Success Criteria

- [Measurable outcomes]
- [Quality indicators]

## Common Pitfalls

- [Specific mistakes to avoid]
- [How to recover from errors]
```

### Meta-Rule Template (Structure-Oriented)

```markdown
# [DOMAIN] Meta-Framework

## Pattern Classification
```

[DOMAIN]_PATTERN := [TYPE_A] | [TYPE_B] | [TYPE_C] [DOMAIN]_SCOPE :=
[SCOPE_OPTIONS] [DOMAIN]_COMPLEXITY := [COMPLEXITY_LEVELS]

```text
## Decision Matrix
| Pattern Type | Scope | Complexity | → Recommended Approach |
|-------------|-------|------------|----------------------|
| [TYPE_A] | [SCOPE_1] | [SIMPLE] | → [TEMPLATE_1] |
| [TYPE_B] | [SCOPE_2] | [COMPLEX] | → [TEMPLATE_2] |

## Abstract Templates
[REUSABLE_SYNTAX_PATTERNS]
```

## Advanced Techniques

### Conditional Logic

Use conditional statements to handle different scenarios:

```markdown
### Error Handling Strategy

- **For libraries**: Use Result types and explicit error propagation
- **For applications**: Include user-friendly error messages and recovery
  options
- **For scripts**: Exit with appropriate codes and log to stderr
```

### Cross-References

Link related rules and resources:

```markdown
See also:

- @security-standards.mdc for authentication patterns
- @testing-guidelines.mdc for coverage requirements
- `/docs/architecture.md` for system design principles
```

### Progressive Disclosure

Organize information from general to specific:

```markdown
## Quick Start

[Essential patterns for immediate use]

## Standard Practices

[Complete guidelines for typical scenarios]

## Advanced Patterns

[Complex scenarios and edge cases]
```

### ReAct Pattern Integration

Structure rules to encourage reasoning and action:

```markdown
## Problem-Solving Framework

**Reason**: [ANALYZE_THE_SITUATION] **Act**: [SPECIFIC_IMPLEMENTATION_STEPS]
**Observe**: [VALIDATION_AND_FEEDBACK] **Reflect**: [LESSONS_AND_IMPROVEMENTS]
```

## Rule Validation Checklist

Before finalizing any Cursor Rule, verify:

### Content Quality

- [ ] Clear, specific description in frontmatter
- [ ] Appropriate glob patterns for target files
- [ ] Consistent formatting and terminology
- [ ] Complete examples that work out-of-the-box
- [ ] Rationale provided for non-obvious recommendations

### Structure & Organization

- [ ] Logical information hierarchy
- [ ] Scannable sections with clear headings
- [ ] Balanced specificity (not too abstract, not too rigid)
- [ ] Cross-references to related rules/docs

### AI Agent Effectiveness

- [ ] Actionable directives (not just descriptions)
- [ ] Specific criteria for decision-making
- [ ] Examples of both correct and incorrect approaches
- [ ] Context for when rules apply vs. when they don't

### Meta-Prompting Optimization

- [ ] Structure-oriented organization (patterns before details)
- [ ] Token-efficient content (abstractions over repetition)
- [ ] Categorical logical arrangement
- [ ] Syntax-focused templates and frameworks

### Technical Accuracy

- [ ] Current with latest stable versions
- [ ] Tested examples and code snippets
- [ ] Compatible with existing project standards
- [ ] No conflicts with other active rules

## Troubleshooting Rule Creation

### Common Technical Issues

#### Frontmatter Editing Limitation

**Issue**: AI agents may be unable to add or modify MDC frontmatter due to
software limitations with YAML parsing in edit operations.

**Symptoms**:

- File content appears correct but frontmatter is missing
- Edit operations skip or fail to apply frontmatter changes
- Rule doesn't activate despite correct content

**Resolution**:

1. **Agent should specify the required frontmatter** in clear format for manual
   addition
2. **Human adds the frontmatter manually** using their editor
3. **Agent continues with content review** after frontmatter is confirmed

**Prevention**:

- Always start rule creation by specifying frontmatter requirements upfront
- Include frontmatter templates in rule creation workflows
- Document this limitation in troubleshooting guides

#### Rule Activation Issues

**Issue**: Rules don't activate when expected despite proper frontmatter.

**Diagnostics**:

- Verify frontmatter syntax is valid YAML
- Check glob patterns match target files exactly
- Confirm `alwaysApply` setting is appropriate
- Test rule activation using Cursor rule picker

**Resolution**:

- Use `Cmd/Ctrl + Shift + P` → "Cursor: Reload Rules"
- Validate YAML syntax using online parser
- Simplify glob patterns for testing
- Check for conflicting rules

## Token Efficiency Strategies

### Pattern Abstraction

Instead of multiple concrete examples, provide:

```markdown
### [PATTERN_NAME]

**Syntax**: [ABSTRACT_STRUCTURE] **Variables**: [PARAMETER_TYPES]
**Constraints**: [VALIDATION_RULES]

**Instantiation**:

- [CONTEXT_1] → [CONCRETE_ADAPTATION]
- [CONTEXT_2] → [CONCRETE_ADAPTATION]
```

### Reference-Based Content

```markdown
### Complete Examples

See: @[detailed-examples].md

### Tool Configurations

See: @[config-templates].json

### Advanced Patterns

See: @[advanced-guide].mdc
```

## Meta-Rule: Continuous Improvement

Effective Cursor Rules evolve with:

- **Project needs**: Update rules based on recurring issues or new patterns
- **Tool changes**: Revise when dependencies or platforms update
- **Team feedback**: Incorporate insights from code reviews and retrospectives
- **Performance data**: Adjust based on metrics like build times, error rates,
  test coverage
- **Prompting research**: Integrate new techniques from meta-prompting and AI
  research

### Evolution Framework

```markdown
## Rule Lifecycle Management

1. **Monitor**: Track rule effectiveness and usage patterns
2. **Analyze**: Identify gaps, overlaps, and improvement opportunities
3. **Refactor**: Apply meta-prompting principles for better structure
4. **Validate**: Test changes against real-world scenarios
5. **Deploy**: Update rules with version control and team notification
```

Remember: The best rules are those that become invisible—they guide behavior so
naturally that following them feels automatic. They should be
**structure-oriented**, **token-efficient**, and **categorically organized** to
maximize AI agent performance.

**Cross-references:**

- @bash.mdc for practical application of these principles
- @google-shellguide.mdc for enterprise-scale rule organization
- @git-commit-message.mdc for universal rule implementation
