# Code Comments and Technical Documentation

Write clear code comments and documentation that explain why, not what. Focus on
helping future developers understand your reasoning and context.

## Key Takeaways

- **Explain why, not what**: Comments should reveal reasoning behind code
  decisions
- **Keep it fresh**: Update comments when code changes or delete outdated ones
- **Use standard formats**: Follow language conventions like JSDoc, docstrings,
  or XML docs
- **Write while coding**: Add comments as you write code, not after
- **Less is more**: Good code needs fewer comments than bad code
- **Document intent**: Explain assumptions, constraints, and design decisions
- **Provide context**: Link to sources, references, and related documentation

## Concepts

### Comment Types

**Inline Comments**: Explain complex logic within functions. Use sparingly for
truly confusing code.

**Function/Method Documentation**: Describe purpose, parameters, return values,
and side effects using standard formats.

**Class Documentation**: Explain the class purpose, usage patterns, and key
methods.

**Module Documentation**: Provide overview of module purpose and main exports.

### Documentation Hierarchy

Start simple and add detail as needed:

1. Meaningful variable and function names
2. Inline comments for complex logic
3. Function/method documentation
4. README files for project overview
5. Detailed guides for complex systems

### Maintenance Strategy

Documentation decays quickly. Keep it alive by:

- Updating docs with code changes
- Removing outdated information
- Reviewing docs during code reviews
- Deleting misleading comments

## Rules

1. **Explain why, not what**: Write "// Use binary search for O(log n)
   performance" not "// Loop through array"
2. **Use standard formats**: Follow JSDoc for JavaScript, docstrings for Python,
   XML docs for C#
3. **Document function contracts**: Specify parameters, return values,
   exceptions, and side effects
4. **Update comments with code**: Change comments in the same commit as code
   changes
5. **Delete wrong comments**: Remove outdated or misleading comments immediately
6. **Write comments while coding**: Don't leave comment writing for later
7. **Link to sources**: Include URLs when using copied code or implementing
   algorithms
8. **Document assumptions**: Note preconditions, constraints, and expected input
   ranges
9. **Use active voice**: Write "Returns user ID" not "User ID is returned"
10. **Keep comments short**: One to three sentences maximum per comment
11. **Avoid redundant comments**: Don't comment obvious code like
    `i++; // increment i`
12. **Document complex algorithms**: Explain the approach and why you chose it

## Examples

### Function Documentation

**GOOD**:

```javascript
/**
 * Calculates shipping cost using distance-based pricing tiers.
 * Uses expensive API call, so cache results for 1 hour.
 *
 * @param {number} distance - Distance in miles (must be positive)
 * @param {string} zipCode - Valid US zip code
 * @returns {Promise<number>} Cost in cents, or throws for invalid input
 * @throws {Error} When zip code format is invalid
 */
async function getShippingCost(distance, zipCode) {
  // Implementation here
}
```

_Why this is good: Explains purpose, performance implications, caching behavior,
parameter constraints, return format, and error conditions. Uses standard JSDoc
format that tools can parse._

**BAD**:

```javascript
// This function gets shipping cost
function getShippingCost(distance, zipCode) {
  // Get the cost
  return cost;
}
```

_Why this is bad: Comments just restate the obvious function name. No
information about parameters, return values, or behavior. Doesn't explain why or
how._

### Inline Comments

**GOOD**:

```python
# Sort by price then by rating to break ties consistently
# This ensures deterministic results for pagination
products.sort(key=lambda x: (x.price, -x.rating))
```

_Why this is good: Explains the business logic and why tie-breaking matters.
Future developers understand the reasoning behind the sort order._

**BAD**:

```python
# Sort the products array
products.sort(key=lambda x: (x.price, -x.rating))
```

_Why this is bad: Just restates what the code obviously does. Doesn't explain
the complex sorting logic or why it's needed._

### Class Documentation

**GOOD**:

```python
class RateLimiter:
    """
    Prevents API abuse using sliding window algorithm.
    
    Thread-safe for concurrent requests. Stores state in Redis
    for distributed systems. Automatically cleans up expired windows.
    
    Example:
        limiter = RateLimiter(max_requests=100, window_seconds=3600)
        if limiter.allow_request(user_id):
            # Process request
        else:
            # Return 429 Too Many Requests
    """
```

_Why this is good: Explains algorithm choice, concurrency safety, storage
mechanism, and cleanup behavior. Includes usage example showing typical
pattern._

**BAD**:

```python
class RateLimiter:
    """Limits requests."""
```

_Why this is bad: Provides no useful information beyond the class name. Doesn't
explain how it works, thread safety, or usage patterns._

### README Structure

**GOOD**:

````markdown
# Payment Service

Handles credit card processing and subscription billing.

## Quick Start

```bash
npm install
npm start
```
````

## Environment Setup

Set these environment variables:

- `STRIPE_SECRET_KEY` - Your Stripe API key
- `DATABASE_URL` - PostgreSQL connection string

## API Endpoints

- `POST /charge` - Process one-time payment
- `POST /subscribe` - Create subscription
- `GET /invoices` - List customer invoices

````
_Why this is good: Clear purpose, immediate getting started steps, required configuration, and API overview. New developers can contribute quickly._

**BAD**:

```markdown
# My Project

This is a project I'm working on. It does payments and stuff.

Run it with npm start I think.
````

_Why this is bad: Vague purpose, unclear setup instructions, and unprofessional
tone. Developers can't use this information effectively._

## Resources

| Name                                                                                                     | Fetch When                                |
| -------------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| [Google Style Guide - Documentation](https://google.github.io/styleguide/docguide/best_practices.html)   | When establishing documentation standards |
| [PEP 257 - Python Docstrings](https://peps.python.org/pep-0257/)                                         | When documenting Python code              |
| [JSDoc Getting Started](https://jsdoc.app/about-getting-started.html)                                    | When documenting JavaScript code          |
| [Microsoft XML Documentation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/xmldoc/) | When documenting C# code                  |
| [Rust Documentation Guide](https://doc.rust-lang.org/rustdoc/what-is-rustdoc.html)                       | When documenting Rust code                |
| [Plain Language Guidelines](https://www.plainlanguage.gov/guidelines/)                                   | When simplifying technical writing        |
| [Write the Docs - Documentation Guide](https://www.writethedocs.org/guide/)                              | When creating comprehensive documentation |

### Local Resources

| Name               | Fetch When                          |
| ------------------ | ----------------------------------- |
| @simple-writing.md | When writing any documentation      |
| @markdown.md       | When formatting documentation files |
| @bash-scripting.md | When documenting shell scripts      |

## Checklist

### 1. Planning Phase

1. [ ] **Choose documentation level** - Decide what needs comments based on code
       complexity and team needs
2. [ ] **Pick standard format** - Use language conventions (JSDoc, docstrings,
       XML docs)
3. [ ] **Set team standards** - Agree on commenting style and required
       documentation

### 2. Writing Comments

4. [ ] **Document while coding** - Write comments as you implement, not after
5. [ ] **Explain reasoning** - Focus on why decisions were made, not what code
       does
6. [ ] **Document function contracts** - Specify parameters, return values,
       exceptions, side effects
7. [ ] **Add usage examples** - Show typical usage patterns for complex
       functions
8. [ ] **Link to sources** - Include URLs for copied code or algorithm
       references
9. [ ] **Note assumptions** - Document preconditions, constraints, input
       expectations

### 3. Content Quality

10. [ ] **Use active voice** - Write "Returns user data" not "User data is
        returned"
11. [ ] **Keep comments short** - Maximum 1-3 sentences per comment
12. [ ] **Avoid redundancy** - Don't comment obvious code like variable
        assignments
13. [ ] **Explain complex logic** - Break down algorithms and business rules

### 4. Documentation Maintenance

14. [ ] **Update with code changes** - Modify comments in same commit as code
        changes
15. [ ] **Delete outdated comments** - Remove misleading or incorrect
        documentation
16. [ ] **Review during code review** - Check comment accuracy and usefulness
17. [ ] **Clean up regularly** - Remove dead documentation during refactoring

### 5. Structure and Format

18. [ ] **Format consistently** - Follow team style guide for indentation and
        spacing
19. [ ] **Use standard tags** - Apply @param, @returns, @throws for function
        docs
20. [ ] **Include error handling** - Document what exceptions can be thrown
21. [ ] **Add performance notes** - Mention expensive operations or caching
