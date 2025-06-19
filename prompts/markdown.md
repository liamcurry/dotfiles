# Markdown

Write structured text using simple symbols. Create readable documents that work
everywhere.

## Key Takeaways

- **Simple syntax**: Use `#` for headings, `*` for emphasis, `-` for lists
- **Universal format**: Works on GitHub, documentation sites, and text editors
- **Readable source**: Plain text stays readable without rendering
- **Block elements**: Paragraphs, headings, lists, code blocks need blank lines
- **Inline elements**: Bold, italic, links, code work within text
- **Consistent spacing**: Use blank lines to separate different elements
- **Escape characters**: Use `\` before special characters to show them
  literally

## Concepts

### Basic Structure

Markdown uses symbols to format text. `#` creates headings, `*` creates
emphasis, `-` creates lists. The source text stays readable even without
rendering.

### Block vs Inline Elements

Block elements like headings, paragraphs, and lists need blank lines before and
after. Inline elements like bold, italic, and links work within text without
extra spacing.

### GitHub Flavored Markdown

GitHub adds tables, code blocks, task lists, and strikethrough to basic
Markdown. Most platforms support these extensions.

### Consistency Principles

Use the same symbols throughout your document. Pick either `*` or `_` for
emphasis and stick with it. Use consistent spacing patterns.

## Rules

1. **Separate blocks with blank lines**: Add empty lines before and after
   headings, lists, code blocks
2. **Use consistent emphasis**: Pick `*` or `_` for italic/bold and use
   everywhere
3. **Put alt text in images**: `![descriptive text](image.jpg)` helps
   accessibility
4. **Use descriptive link text**: `[GitHub docs](url)` not `[click here](url)`
5. **Escape special characters**: Use `\*` to show asterisks literally
6. **Indent nested lists**: Use 2-4 spaces for sub-items
7. **Use fenced code blocks**: Triple backticks with language for syntax
   highlighting
8. **Close emphasis properly**: Match opening and closing symbols
9. **Add blank line before lists**: Prevents paragraphs from merging with lists
10. **Use reference links for long URLs**: Keep source text clean with
    `[text][ref]`

## Examples

### Headings

**GOOD**:

```markdown
# Main Title

## Section Title

### Subsection

Regular paragraph text here.
```

**BAD**:

```markdown
#Main Title ##Section Title ###Subsection Regular paragraph text here.
```

### Lists

**GOOD**:

```markdown
Shopping list:

- Apples
- Bananas
- Oranges

Tasks:

1. Review code
2. Run tests
3. Deploy changes
```

**BAD**:

```markdown
Shopping list:

- Apples
- Bananas
- Oranges Tasks:

1. Review code
2. Run tests
3. Deploy changes
```

### Code Blocks

**GOOD**:

````markdown
Install dependencies:

```bash
npm install
npm start
```

Check the `package.json` file for details.
````

**BAD**:

````markdown
Install dependencies:

```bash
npm install
npm start
```
````

Check the package.json file for details.

````
### Links and Images

**GOOD**:
```markdown
Read the [GitHub documentation](https://docs.github.com) for details.

![Screenshot of the main dashboard](screenshot.png)
````

**BAD**:

```markdown
Read the GitHub documentation at https://docs.github.com for details.

![](screenshot.png)
```

### Tables

**GOOD**:

```markdown
| Name  | Role      | Team     |
| ----- | --------- | -------- |
| Alice | Developer | Frontend |
| Bob   | Designer  | UX       |
```

**BAD**:

```markdown
| Name  | Role      | Team     |
| ----- | --------- | -------- |
| Alice | Developer | Frontend |
| Bob   | Designer  | UX       |
```

## Resources

| Name                                                                            | Fetch When                          |
| ------------------------------------------------------------------------------- | ----------------------------------- |
| [Markdown Guide](https://www.markdownguide.org/)                                | When learning Markdown basics       |
| [CommonMark Spec](https://commonmark.org/help/)                                 | When checking standard syntax       |
| [GitHub Flavored Markdown](https://github.github.com/gfm/)                      | When using GitHub-specific features |
| [Daring Fireball Markdown](https://daringfireball.net/projects/markdown/syntax) | When understanding original syntax  |
| [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)              | When looking up specific syntax     |

### Local Resources

| Name                      | Fetch When                 |
| ------------------------- | -------------------------- |
| @simple-writing.md        | When writing clear content |
| @simple-guide-creation.md | When creating guides       |
| @code-comments-technical-documentation.md | When documenting code in Markdown |

## Checklist

1. [ ] **Add blank lines around blocks** - Put empty lines before/after
       headings, lists, code blocks
2. [ ] **Use consistent emphasis** - Pick `*` or `_` for italic/bold throughout
       document
3. [ ] **Write descriptive links** - Use meaningful text like
       `[GitHub docs](url)`, not `[click here](url)`
4. [ ] **Add alt text to images** - Include `![descriptive text](image.jpg)` for
       accessibility
5. [ ] **Escape special characters** - Use `\` before `*`, `_`, `#` when showing
       them literally
6. [ ] **Indent nested lists** - Use 2-4 spaces for sub-items in lists
7. [ ] **Use fenced code blocks** - Use triple backticks with language name for
       syntax highlighting
8. [ ] **Format tables properly** - Include header row and alignment pipes
9. [ ] **Close emphasis tags** - Match every opening `*` or `_` with closing
       symbol
10. [ ] **Separate paragraphs** - Use blank lines between different paragraphs
11. [ ] **Preview rendered output** - Check how content looks when rendered
12. [ ] **Validate links work** - Test all URLs return 2xx status codes

