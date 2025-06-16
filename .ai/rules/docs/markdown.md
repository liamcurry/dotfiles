---
description:
globs: *.md,*.markdown
alwaysApply: false
---

# Markdown Writing Standards & Best Practices

Write well-structured, accessible Markdown documents that follow CommonMark
specification and industry best practices. Apply when creating documentation,
README files, technical guides, or any Markdown content.

## Document Classification System

```text
DOCUMENT_TYPE := README | DOCUMENTATION | TUTORIAL | REFERENCE | GUIDE | SPECIFICATION | CHANGELOG
COMPLEXITY := SIMPLE | MODERATE | COMPLEX
PURPOSE := USER_GUIDE | API_DOCS | PROJECT_INFO | TECHNICAL_SPEC | PROCESS_DOC
AUDIENCE := DEVELOPER | END_USER | CONTRIBUTOR | MIXED
FORMAT := GITHUB_FLAVORED | COMMONMARK | EXTENDED
```

## Core Principles

### 1. CommonMark Compliance

- **Standard syntax**: Follow CommonMark specification for maximum compatibility
- **Consistent formatting**: Use standardized markup patterns throughout
- **Portable content**: Ensure documents render correctly across platforms
- **Future-proof syntax**: Avoid platform-specific extensions unless necessary

### 2. Semantic Structure

- **Logical hierarchy**: Use heading levels (H1-H6) to create clear document
  structure
- **Meaningful markup**: Choose appropriate elements for content type (lists,
  tables, code blocks)
- **Consistent patterns**: Apply uniform formatting for similar content types
- **Accessible content**: Structure for screen readers and assistive
  technologies

### 3. Readability & Maintenance

- **Clear language**: Write concise, actionable content appropriate for target
  audience
- **Scannable format**: Use visual hierarchy to enable quick content scanning
- **Modular structure**: Organize content in logical, self-contained sections
- **Version-friendly**: Structure for clean git diffs and collaborative editing

## Document Structure Templates

### README - Project Introduction

**Use for**: Project documentation, getting started guides, project overview

**Structure Pattern**:

````markdown
# Project Name

Brief, compelling description of what the project does and why it matters.

## Features

- Key feature 1
- Key feature 2
- Key feature 3

## Quick Start

```bash
# Installation command
npm install project-name

# Basic usage example
project-name --help
```
````

## Installation

### Prerequisites

- Node.js 18+
- Git 2.30+

### Install

1. Clone the repository:

   ```bash
   git clone https://github.com/user/project.git
   cd project
   ```

2. Install dependencies:

   ```bash
   npm install
   ```

3. Configure environment:

   ```bash
   cp .env.example .env
   # Edit .env with your settings
   ```

## Usage

### Basic Example

Provide a simple, working example that demonstrates core functionality.

### Advanced Usage

Link to detailed documentation or provide complex examples.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## License

[MIT](LICENSE) © [Author Name](https://github.com/username)

### Technical Documentation - Comprehensive Guides

**Use for**: API documentation, user guides, technical specifications

**Structure Pattern**:

```markdown
# API Reference

## Overview

Brief description of the API, its purpose, and capabilities.

## Authentication

### API Key Authentication

```http
GET /api/v1/resource
Authorization: Bearer your-api-key-here
Content-Type: application/json
````

### Response Format

All API responses follow this structure:

```json
{
    "data": {},
    "meta": {
        "status": "success",
        "timestamp": "2023-01-01T00:00:00Z"
    },
    "errors": []
}
```

## Endpoints

### GET /api/v1/users

Retrieve a list of users.

**Parameters:**

| Parameter | Type    | Required | Description       |
| --------- | ------- | -------- | ----------------- |
| `limit`   | integer | No       | Number of results |
| `offset`  | integer | No       | Pagination offset |
| `search`  | string  | No       | Search query      |

**Example Request:**

```bash
curl -X GET "https://api.example.com/v1/users?limit=10&offset=0" \
  -H "Authorization: Bearer your-api-key"
```

**Example Response:**

```json
{
    "data": [
        {
            "id": 1,
            "name": "John Doe",
            "email": "john@example.com"
        }
    ],
    "meta": {
        "total": 100,
        "page": 1,
        "per_page": 10
    }
}
```

## Error Handling

| Status Code | Description           | Example Response                  |
| ----------- | --------------------- | --------------------------------- |
| 400         | Bad Request           | `{"error": "Invalid parameters"}` |
| 401         | Unauthorized          | `{"error": "Invalid API key"}`    |
| 404         | Not Found             | `{"error": "Resource not found"}` |
| 500         | Internal Server Error | `{"error": "Server error"}`       |

### Tutorial - Step-by-Step Guide

**Use for**: Learning materials, walkthroughs, how-to guides

**Structure Pattern**:

```markdown
# Getting Started with [Technology]

Learn how to build a complete application using [Technology] in this comprehensive tutorial.

## What You'll Build

A brief description of the final project, including a screenshot or demo link if available.

## Prerequisites

Before starting this tutorial, you should have:

- [ ] Basic knowledge of JavaScript
- [ ] Node.js 18+ installed
- [ ] A text editor (VS Code recommended)
- [ ] Git for version control

## Step 1: Project Setup

First, let's create a new project and install the necessary dependencies.

1. Create a new directory:
   ```bash
   mkdir my-project
   cd my-project
   ```

2. Initialize the project:

   ```bash
   npm init -y
   ```

3. Install dependencies:

   ```bash
   npm install express
   npm install -D nodemon
   ```

> **Note**: We're using `nodemon` for development to automatically restart the
> server when files change.

## Step 2: Create the Server

Create a file called `server.js`:

```javascript
const express = require("express");
const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.json({ message: "Hello World!" });
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
```

## Step 3: Test Your Application

Run the server:

```bash
npm start
```

Open your browser and navigate to `http://localhost:3000`. You should see:

```json
{ "message": "Hello World!" }
```

## Next Steps

- [ ] Add database integration
- [ ] Implement user authentication
- [ ] Deploy to production

## Troubleshooting

### Common Issues

#### Error: Port already in use

```bash
# Find and kill the process using port 3000
lsof -ti:3000 | xargs kill -9
```

#### Module not found error

```bash
# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install
```

## Formatting Standards

### Headings & Hierarchy

```markdown
# H1 - Document Title (use only once per document)
## H2 - Major Section
### H3 - Subsection
#### H4 - Minor Section
##### H5 - Detailed Point
###### H6 - Fine Detail (use sparingly)
````

**Best Practices:**

- Use only one H1 per document
- Don't skip heading levels (H1 → H3)
- Keep headings descriptive and actionable
- Use sentence case for headings

### Lists & Organization

**Unordered Lists:**

```markdown
- Primary item
  - Nested item (2 spaces)
    - Deep nested item (4 spaces)
- Another primary item

* Alternative bullet style

- Another alternative style
```

**Ordered Lists:**

```markdown
1. First step
2. Second step
   1. Sub-step (3 spaces + number)
   2. Another sub-step
3. Third step
```

**Task Lists:**

```markdown
- [ ] Incomplete task
- [x] Completed task
- [ ] Another incomplete task
```

### Code & Technical Content

**Inline Code:**

```markdown
Use `backticks` for inline code, variable names like `variable`, and short
commands like `npm install`.
```

**Code Blocks:**

````markdown
```javascript
// Always specify language for syntax highlighting
function greet(name) {
  return `Hello, ${name}!`;
}
```
````

```bash
# Use bash for shell commands
npm install --save-dev prettier
npm run build
```

```json
{
    "name": "example",
    "version": "1.0.0"
}
```

**Configuration Examples:**

- Always specify language in fenced code blocks
- Use comments to explain complex code
- Keep examples focused and minimal
- Test code examples before including them

### Links & References

**Inline Links:**

```markdown
[Link text](https://example.com "Optional title")
[Internal link](#section-heading)
[Relative link](./docs/api.md)
````

**Reference Links:**

```markdown
This is a [reference link][ref-id] and another [link][ref-2].

[ref-id]: https://example.com "Reference title"
[ref-2]: https://github.com/user/repo
```

**Auto-links:**

```markdown
<https://example.com> <email@example.com>
```

### Tables & Data

**Simple Table:**

```markdown
| Column 1 | Column 2 | Column 3 |
| -------- | -------- | -------- |
| Data 1   | Data 2   | Data 3   |
| Data 4   | Data 5   | Data 6   |
```

**Aligned Table:**

```markdown
| Left Aligned | Center Aligned | Right Aligned |
| :----------- | :------------: | ------------: |
| Text         |      Text      |          Text |
| More text    |   More text    |     More text |
```

**Best Practices:**

- Keep tables simple and focused
- Use tables only for tabular data
- Avoid tables for layout purposes
- Consider lists for simple key-value pairs

### Images & Media

**Image with Alt Text:**

```markdown
![Alt text describing the image](./images/screenshot.png "Optional title")
```

**Linked Image:**

```markdown
[![Alt text](./images/badge.svg)](https://example.com)
```

**Best Practices:**

- Always include descriptive alt text
- Use relative paths for local images
- Optimize images for web (< 1MB)
- Provide fallback text for complex diagrams

### Emphasis & Formatting

**Text Emphasis:**

```markdown
_Italic text_ or _italic text_ **Bold text** or **bold text** _**Bold and
italic**_ or _**bold and italic**_ ~~Strikethrough text~~
```

**Blockquotes:**

```markdown
> Single line quote

> Multi-line quote with additional lines and more content

> **Note**: Important information that readers should pay attention to.

> **Warning**: Critical information about potential issues or risks.
```

**Horizontal Rules:**

```markdown
---
```

## Quality Validation with markdownlint

### Setup and Configuration

Create `.markdownlint.json` in your project root:

```json
{
    "default": true,
    "MD003": { "style": "atx" },
    "MD007": { "indent": 4 },
    "MD013": { "line_length": 100 },
    "MD025": { "front_matter_title": "^\\s*title\\s*[:=]" },
    "MD033": { "allowed_elements": ["br", "sub", "sup"] },
    "MD040": true,
    "MD041": false,
    "no-hard-tabs": true,
    "whitespace": false
}
```

### Core markdownlint Rules

**Heading Rules:**

- **MD001**: Heading levels increment by one level at a time
- **MD003**: Consistent heading style (ATX vs Setext)
- **MD018**: Space after hash on ATX style headers
- **MD019**: No multiple spaces after hash on ATX headers
- **MD022**: Headers surrounded by blank lines
- **MD023**: Headers start at beginning of line
- **MD024**: Multiple headings with same content
- **MD025**: Single top-level heading per document
- **MD026**: No trailing punctuation in headings

**List Rules:**

- **MD004**: Consistent unordered list style
- **MD005**: Consistent indentation for list items
- **MD006**: Start bulleted lists at beginning of line
- **MD007**: Proper unordered list indentation
- **MD029**: Ordered list item prefix style
- **MD030**: Spaces after list markers
- **MD032**: Lists surrounded by blank lines

**Whitespace Rules:**

- **MD009**: No trailing spaces
- **MD010**: No hard tabs
- **MD012**: No multiple consecutive blank lines
- **MD047**: Files end with single newline character

**Code Rules:**

- **MD031**: Fenced code blocks surrounded by blank lines
- **MD040**: Fenced code blocks have language specified
- **MD046**: Consistent code block style
- **MD048**: Consistent code fence style

**Link and Image Rules:**

- **MD011**: Reversed link syntax
- **MD034**: No bare URLs
- **MD039**: No spaces inside link text
- **MD042**: No empty links
- **MD045**: Images have alternate text

**Content Rules:**

- **MD013**: Line length limits
- **MD033**: Inline HTML restrictions
- **MD036**: No emphasis used instead of headings
- **MD037**: No spaces inside emphasis markers
- **MD038**: No spaces inside code span elements

### Advanced Configuration

**Rule-Specific Settings:**

```json
{
    "MD003": {
        "style": "atx"
    },
    "MD007": {
        "indent": 4,
        "start_indented": false,
        "start_indent": 2
    },
    "MD013": {
        "line_length": 100,
        "heading_line_length": 120,
        "code_block_line_length": 120,
        "code_blocks": false,
        "tables": false,
        "headings": false
    },
    "MD024": {
        "siblings_only": true
    },
    "MD025": {
        "front_matter_title": "^\\s*title\\s*[:=]"
    },
    "MD033": {
        "allowed_elements": ["br", "sub", "sup", "kbd", "figure", "figcaption"]
    },
    "MD035": {
        "style": "---"
    },
    "MD040": {
        "allowed_languages": [],
        "language_only": false
    },
    "MD046": {
        "style": "fenced"
    },
    "MD048": {
        "style": "backtick"
    }
}
```

**Alternative Configuration Formats:**

**YAML Configuration (.markdownlint.yaml):**

```yaml
default: true
MD003:
  style: atx
MD007:
  indent: 4
MD013:
  line_length: 100
MD033:
  allowed_elements:
    - br
    - sub
    - sup
no-hard-tabs: true
```

**JSON with Comments (.markdownlint.jsonc):**

```jsonc
{
    // Enable all rules by default
    "default": true,

    // Use ATX-style headers (# Header)
    "MD003": { "style": "atx" },

    // 4-space indentation for lists
    "MD007": { "indent": 4 },

    // Allow longer lines for code and tables
    "MD013": {
        "line_length": 100,
        "code_blocks": false,
        "tables": false
    }
}
```

### Editor Integration

**VS Code Integration:** Install the "markdownlint" extension by David Anson for
real-time linting.

**Neovim Integration:**

```lua
-- Using null-ls
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint
  }
})
```

**Vim Integration:** Use ALE (Asynchronous Lint Engine) with markdownlint:

```vim
let g:ale_linters = {
\   'markdown': ['markdownlint'],
\}
let g:ale_fixers = {
\   'markdown': ['markdownlint'],
\}
```

## Accessibility Guidelines

### Structure for Screen Readers

- Use semantic heading hierarchy
- Provide descriptive link text
- Include alt text for images
- Use tables appropriately with headers

### Language & Content

- Write in clear, simple language
- Define technical terms and acronyms
- Use consistent terminology throughout
- Provide context for complex concepts

### Visual Accessibility

- Ensure sufficient contrast in diagrams
- Don't rely solely on color to convey information
- Use descriptive text alongside visual elements
- Test content at different zoom levels

## Content Strategy Patterns

### Documentation Hierarchy

```text
README.md              # Project overview and quick start
├── docs/
│   ├── getting-started.md    # Detailed setup guide
│   ├── api-reference.md      # Complete API documentation
│   ├── tutorials/            # Step-by-Step guides
│   ├── examples/             # Code examples and samples
│   └── troubleshooting.md    # Common issues and solutions
├── CONTRIBUTING.md           # Contribution guidelines
├── CHANGELOG.md             # Version history
└── LICENSE.md              # Legal information
```

### Content Types & Templates

**Explanatory Content:**

- Start with clear purpose statement
- Use examples and analogies
- Break complex concepts into steps
- Include visual aids when helpful

**Reference Content:**

- Organize alphabetically or logically
- Use consistent formatting patterns
- Include search-friendly headings
- Provide cross-references

**Procedural Content:**

- Number sequential steps clearly
- Include expected outcomes
- Provide troubleshooting for common issues
- Use consistent command formatting

## Quality Assurance Checklist

### Content Quality

- [ ] **Clear purpose**: Document serves specific user need
- [ ] **Accurate information**: All technical details verified and tested
- [ ] **Up-to-date content**: Information reflects current state
- [ ] **Complete coverage**: All necessary information included

### Structure Quality

- [ ] **Logical hierarchy**: Headings create clear document outline
- [ ] **Consistent formatting**: Uniform style throughout document
- [ ] **Scannable layout**: Visual breaks and clear sections
- [ ] **Navigation aids**: Table of contents, cross-references

### Technical Quality

- [ ] **Valid Markdown**: Renders correctly in target environments
- [ ] **Working links**: All links resolve correctly
- [ ] **Tested examples**: Code examples execute successfully
- [ ] **Proper escaping**: Special characters handled correctly

### Accessibility Quality

- [ ] **Semantic markup**: Appropriate HTML elements used
- [ ] **Alt text provided**: Images include descriptive text
- [ ] **Clear language**: Content accessible to target audience
- [ ] **Consistent terminology**: Terms used consistently throughout

## Common Patterns & Anti-Patterns

### ✅ Best Practices

**Clear Document Structure:**

```markdown
# Project Name

Brief, compelling introduction that explains what and why.

## Quick Start

Immediate value - get users running in 30 seconds.

## Installation

Detailed setup instructions with prerequisites.

## Usage

Core functionality with practical examples.

## API Reference

Complete reference information organized logically.
```

**Effective Code Examples:**

````markdown
### Basic Example

```javascript
// Simple, focused example that demonstrates core concept
const api = new APIClient("your-api-key");
const users = await api.getUsers();
console.log(users);
```
````

### Advanced Examples

For complex scenarios, see the [complete examples](./examples/).

**Clear Navigation:**

```markdown
## Table of Contents

1. [Getting Started](#getting-started)
2. [API Reference](#api-reference)
   - [Authentication](#authentication)
   - [Endpoints](#endpoints)
3. [Examples](#examples)
4. [Troubleshooting](#troubleshooting)
````

### ❌ Anti-Patterns to Avoid

**Poor Structure:**

```markdown
# Introduction

# Getting Started # Wrong: Multiple H1 headings

#### Installation # Wrong: Skipping heading levels
```

**Unclear Links:**

```markdown
Click [here](https://example.com) for more info. # Bad: Non-descriptive Read
more about [configuration options](https://example.com). # Good: Descriptive
```

**Inaccessible Tables:**

```markdown
| | | | # Bad: No headers |-|-|-| |A|B|C|

| Feature | Status | Notes | # Good: Clear headers |---------|---------|-------|
| Auth | Ready | Docs |
```

**Code Without Context:**

````markdown
```javascript
// Bad: No explanation
function process(data) {/* complex logic */}
```
````

```javascript
// Good: With context and explanation
// Validates and transforms user input data
function processUserInput(rawData) {
  // Implementation details...
}
```

## Linting and Validation

### markdownlint Command Line Usage

**Installation:**

```bash
# Install globally
npm install -g markdownlint-cli

# Or use markdownlint-cli2 (faster)
npm install -g markdownlint-cli2

# Or install locally in project
npm install --save-dev markdownlint-cli
```

**Basic Usage:**

```bash
# Lint all markdown files
markdownlint *.md

# Lint specific files
markdownlint README.md CHANGELOG.md

# Lint files recursively
markdownlint docs/**/*.md

# Fix auto-fixable issues
markdownlint --fix *.md

# Use specific config file
markdownlint --config .markdownlint.json *.md

# Output as JSON for parsing
markdownlint --json *.md

# Ignore specific rules
markdownlint --disable MD013 MD033 *.md
```

**markdownlint-cli2 Usage:**

```bash
# Lint with markdownlint-cli2 (supports globs)
markdownlint-cli2 "**/*.md"

# Fix issues automatically
markdownlint-cli2-fix "**/*.md"

# Use custom config
markdownlint-cli2 --config .markdownlint.json "**/*.md"
```

### Additional Linting Tools

```bash
# markdownlint for style consistency
markdownlint docs/**/*.md

# markdown-link-check for broken links
markdown-link-check README.md

# proselint for prose quality
proselint README.md

# Vale for style guide enforcement
vale docs/

# textlint for natural language linting
textlint README.md
```

### CI/CD Integration

**GitHub Actions:**

```yaml
name: Documentation Quality
on: [push, pull_request]

jobs:
  lint-docs:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: "18"

      - name: Install markdownlint
        run: npm install -g markdownlint-cli

      - name: Lint Markdown files
        run: markdownlint *.md **/*.md

      - name: Check for auto-fixable issues
        run: markdownlint --fix *.md **/*.md

      - name: Check Links
        uses: gaurav-nelson/github-action-markdown-link-check@v1
        with:
          use-quiet-mode: "yes"
          use-verbose-mode: "yes"
```

**Alternative GitHub Action using markdownlint-cli2:**

```yaml
name: Lint Markdown
on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: DavidAnson/markdownlint-cli2-action@v14
        with:
          globs: "**/*.md"
```

**Pre-commit Hook:**

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.37.0
    hooks:
      - id: markdownlint
        args: ["--fix"]
```

**npm Scripts:**

```json
{
    "scripts": {
        "lint:md": "markdownlint *.md **/*.md",
        "lint:md:fix": "markdownlint --fix *.md **/*.md",
        "lint:md:ci": "markdownlint-cli2 \"**/*.md\""
    },
    "devDependencies": {
        "markdownlint-cli": "^0.37.0",
        "markdownlint-cli2": "^0.10.0"
    }
}
```

## Performance Optimization

### Document Size Management

- Keep individual files under 50KB when possible
- Break large documents into focused sections
- Use reference links for repeated URLs
- Optimize images and media files

### Loading Performance

- Minimize external dependencies
- Use relative links for internal navigation
- Consider lazy loading for large image galleries
- Cache frequently accessed reference materials

## Integration Best Practices

### Version Control

- Use meaningful commit messages for documentation changes
- Include documentation updates in feature branches
- Review documentation alongside code changes
- Maintain documentation changelog for major updates

### Collaborative Editing

- Establish style guidelines for team consistency
- Use templates for common document types
- Implement review process for documentation changes
- Provide writing guidelines for contributors

### Tool Integration

- Configure editor for Markdown preview and linting
- Set up automated formatting with pre-commit hooks
- Use documentation generators for API references
- Integrate with project management tools

## References & Resources

- **CommonMark Specification**: [CommonMark](https://commonmark.org/)
- **GitHub Flavored Markdown**: [GitHub Flavored Markdown Spec](https://github.github.com/gfm/)
- **Markdown Guide**: [The Markdown Guide](https://www.markdownguide.org/)
- **markdownlint**: [markdownlint](https://github.com/DavidAnson/markdownlint)
- **markdownlint CLI**: [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli)
- **markdownlint CLI2**: [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)
- **Google Style Guide**: [Google Documentation Style Guide](https://google.github.io/styleguide/docguide/style.html)
- **Accessibility Guidelines**: [WCAG 2.1 Quick Reference](https://www.w3.org/WAI/WCAG21/quickref/)
- **Technical Writing Courses**: [Google Technical Writing](https://developers.google.com/tech-writing)

---

**Integration Notes**:

- Works with @cursor-rules framework for AI assistant integration
- Follows @git-commit-message standards for version control
- Aligns with @grugbrain philosophy for simplicity and maintainability
- Supports markdownlint for comprehensive style checking and validation
