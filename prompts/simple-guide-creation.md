# Simple Guide Creation for AI Agents

Create short guides for AI agents. Focus on doing, not theory.

## Key Takeaways

- **Simplicity wins**: Use short words, cut fluff, be direct
- **Structure matters**: Follow the 7-section format for consistency
- **Examples teach**: Show good vs bad for every concept
- **Action focus**: Write for doing, not just knowing
- **Agent audience**: Write for AI agents, not humans

## Concepts

### Core Structure

Every guide uses this exact structure:

1. **(title)**: 1-2 sentences explaining purpose
2. **Key Takeaways**: 3-7 key concepts
3. **Concepts**: Explain main ideas
4. **Rules**: Actionable guidelines and best practices
5. **Examples**: Real examples: good vs bad
6. **Resources**: 5-10 machine-readable links that AI can fetch
   - Only include URLs to actual documentation, APIs, or guides
   - Avoid book links, marketing pages, or non-fetchable content
   - List resources in table format with two columns: "Name" (name and link) and
     "Fetch When" (when/why to fetch)
   - Optional: Add separate "Local Resources" table for relevant @prompts/ files
7. **Checklist**: List of actionable items to complete the guide

### Writing Approach

**Spartan tone**: No fluff. No preamble. Get to the point.

**Simple language**: Use common words. Avoid jargon. Write like you talk.

**Practical focus**: Skip theory. Show how to apply concepts now.

**Agent-centric**: Write for AI agents first, humans second.

### Content Depth

**Complete but short**: Cover key aspects without bloat.

**Actionable rules**: Every rule should be something you can do now.

**Multiple examples**: 3+ examples: good vs bad.

### Checklist Requirements

**Standard Format**: Use
`1. [ ] **Bold Action** - Brief explanation with criteria`

**Simple Language**: Apply simple writing principles - active voice, common
words, specific metrics

**Workflow Order**: Organize items in natural sequence of work steps

**Success Criteria**: Define what "complete" means for each item

**Consistent Granularity**: Keep items at similar detail levels within each
checklist.

**Length Management**: For long checklists (15+ items), use these steps:

1. Break into numbered sub-sections by workflow phase
2. Use descriptive sub-section headers
3. Limit each sub-section to 5-10 items max
4. Maintain consistent numbering across sub-sections

## Rules

1. **Keep it under 500 lines total**
2. **Use simple words from simple-writing.md**
3. **Include good/bad examples for every concept with explanations**
4. **Write for AI agents first, humans second**
5. **Focus on practical application**
6. **Follow the 7-section structure exactly**
7. **Make every rule actionable**
8. **Cut unnecessary words ruthlessly**
9. **Use active voice**
10. **One idea per sentence**
11. **Validate external resources**: Fetch all external URLs to confirm they
    work. Remove or replace broken links.
12. **Cross-reference existing guides**: After creating a new guide, scan
    @prompts/ for related guides. Add the new guide to existing guides' Local
    Resources. Add existing guides to the new guide's Local Resources.
13. **Format checklist items consistently**: Use
    `1. [ ] **Bold Action** - Brief explanation with criteria`
14. **Order checklist by workflow**: Organize items in natural sequence of work
    steps
15. **Define success criteria**: Each item should answer "How do I know this is
    complete?"
16. **Keep checklist granularity consistent**: Similar detail levels within each
    checklist
17. **Break down long checklists**: For 15+ items, use numbered sub-sections by
    workflow phase with 5-10 items each

## Examples

### Summary Section

**Structure**: Brief 1-2 sentence explanation of the guide's purpose

**GOOD**:

```markdown
## Summary

Create fast, reliable APIs using REST principles. Focus on clear endpoints and
proper HTTP methods.
```

**BAD**:

```markdown
## Summary

This comprehensive guide will endeavor to provide you with a thorough
understanding of RESTful API design principles, methodologies, and best
practices that will enable you to create robust, scalable, and maintainable
application programming interfaces.
```

### Key Takeaways Section

**Structure**: 3-7 bullet points with bold concept names and brief explanations

**GOOD**:

```markdown
## Key Takeaways

- **URLs are nouns**: `/users/123`, not `/getUser/123`
- **HTTP methods are verbs**: GET, POST, PUT, DELETE
- **Status codes matter**: 200 for success, 404 for not found
- **Consistent naming**: Use plural nouns for collections
- **Error handling**: Return clear error messages
```

**BAD**:

```markdown
## Key Takeaways

- The utilization of appropriate URL structures facilitates improved API
  comprehension
- HTTP methodologies should be leveraged in accordance with their intended
  semantic meaning
- Proper status code implementation is essential for effective client-server
  communication
```

### Rules Section

**Structure**: Numbered list with bold action verbs and specific implementation
details

**GOOD**:

```markdown
## Rules

1. **Use nouns for URLs**: `/products` not `/getProducts`
2. **Use HTTP methods correctly**: GET for reading, POST for creating
3. **Return consistent JSON**: Same structure for all responses
4. **Include error details**: Status code + message + error code
5. **Version your API**: `/v1/users` or
   `Accept: application/vnd.api+json;version=1`
```

**BAD**:

```markdown
## Rules

1. It is recommended that RESTful endpoints utilize noun-based URL structures
2. HTTP methods should be employed in a manner consistent with their semantic
   definitions
3. Response formatting should maintain consistency across all API endpoints
```

### Examples Section

**Structure**: Multiple subsections with specific titles, each containing
**GOOD** and **BAD** code blocks with explanations of why each example is good
or bad

**GOOD**:

````markdown
### Example: URL Design

**GOOD**:

```
GET /users/123/orders/456
POST /users/123/orders
PUT /users/123/orders/456
DELETE /users/123/orders/456
```

_Why this is good: Uses nouns to represent resources, creates clear hierarchy
with nested resources, follows RESTful conventions that make API predictable_

**BAD**:

```
GET /getUserOrders?userId=123&orderId=456
POST /createUserOrder
PUT /updateUserOrder
DELETE /removeUserOrder
```

_Why this is bad: Uses verbs instead of nouns, inconsistent naming patterns,
relies on query parameters instead of resource hierarchy_
````

**BAD**:

```markdown
### Example: URL Design

Here are some examples of how to structure URLs properly versus improperly:

Good approach: Use nested resources Bad approach: Use query parameters for
everything
```

_Why this is bad: No actual code examples, vague descriptions instead of
concrete examples, doesn't show what to do or avoid_

### Checklist Section

**Structure**: Numbered list using
`[ ] **Bold Action** - Brief explanation with success criteria`

**GOOD**:

```markdown
## Checklist

### 1. Design Phase

1. [ ] **Design URLs** - Use nouns not verbs (`/users/123` not `/getUser/123`)
2. [ ] **Choose HTTP methods** - GET for read, POST for create, PUT for update,
       DELETE for remove
3. [ ] **Set status codes** - 200 for success, 201 for created, 400 for bad
       request, 404 for not found
4. [ ] **Structure JSON** - Consistent response format across all endpoints

### 2. Implementation Phase

5. [ ] **Handle errors** - Include status code, message, and error code in
       responses
6. [ ] **Version API** - Use `/v1/` prefix or Accept header versioning

### 3. Security Phase

7. [ ] **Add authentication** - JWT or API key validation on protected endpoints
8. [ ] **Configure rate limiting** - Prevent abuse with request throttling
```

**BAD**:

```markdown
## Checklist

- [ ] Ensure that URL structures follow RESTful conventions
- [ ] Verify that HTTP methods are being used appropriately
- [ ] Confirm that status codes are semantically correct
- [ ] Validate response formatting consistency
- [ ] Make sure error handling is implemented properly
- [ ] Check that the API has proper versioning
```

## Resources

| Name                                                                                                               | Fetch When                       |
| ------------------------------------------------------------------------------------------------------------------ | -------------------------------- |
| [Google Developer Documentation Style Guide](https://developers.google.com/style)                                  | When writing technical guides    |
| [Plain Language Guidelines](https://www.plainlanguage.gov/guidelines/)                                             | When simplifying complex content |
| [Mozilla Writing Style Guide](https://developer.mozilla.org/en-US/docs/MDN/Writing_guidelines/Writing_style_guide) | When writing developer content   |
| [GitLab Documentation Style Guide](https://docs.gitlab.com/ee/development/documentation/styleguide/)               | When writing user-facing docs    |
| [GitHub Writing Style Guide](https://docs.github.com/en/contributing/style-guide-and-content-model/style-guide)    | When writing for technical teams |

### Local Resources

| Name                        | Fetch When                      |
| --------------------------- | ------------------------------- |
| @simple-writing.md          | When writing any guide          |
| @markdown.md                | When formatting guides          |
| @json-schema.md             | When defining data structures   |
| @test-driven-development.md | When writing development guides |

## Checklist

### 1. Content Creation

1. [ ] **Check length** - Guide is under 500 lines total
2. [ ] **Use simple words** - Follow @simple-writing.md guidelines
3. [ ] **Follow structure** - Use 7-section format exactly (summary, takeaways,
       concepts, rules, examples, resources, checklist)
4. [ ] **Add examples** - Include 3+ good vs bad examples with short
       explanations of why each is good or bad
5. [ ] **Target AI agents** - Write for AI agents as primary audience
6. [ ] **Make rules actionable** - Every rule should be something you can do now

### 2. Writing Quality

7. [ ] **Cut fluff** - Remove unnecessary words and preamble
8. [ ] **Use active voice** - Write with action verbs and clear subjects
9. [ ] **One idea per sentence** - Keep sentences focused and simple
10. [ ] **Focus on practice** - Emphasize application over theory

### 3. Resources and References

11. [ ] **Add resources** - Include machine-readable external links and relevant
        local resources
12. [ ] **Validate external links** - All external URLs return 2xx status codes
13. [ ] **Check local references** - All @prompts/ files exist and are current
14. [ ] **Cross-reference** - Add new guide to existing guides' Local Resources
        and vice versa

### 4. Checklist Structure

15. [ ] **Format checklist** - Use
        `1. [ ] **Bold Action** - Brief explanation with criteria` format
16. [ ] **Order by workflow** - Organize checklist items in natural work
        sequence
17. [ ] **Define completion** - Each item answers "How do I know this is
        complete?"
18. [ ] **Structure long checklists** - Break 15+ items into sub-sections with
        5-10 items each, using descriptive headers

### 5. Final Review

19. [ ] **Review examples** - Verify examples accurately demonstrate good/bad
        practices and provide clear value for token usage
20. [ ] **Review checklist flow** - Re-evaluate structure and sequencing for
        logical workflow, consolidate duplicate items, simplify where possible
