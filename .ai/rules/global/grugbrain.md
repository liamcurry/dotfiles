---
description: 
globs: 
alwaysApply: true
---
# Grug Brain Development Philosophy

This rule embodies the wisdom of the "grug brain developer" - emphasizing simplicity, practicality, and sustainable coding practices over complex theoretical solutions. Use when you want to avoid over-engineering and focus on solutions that work reliably and are maintainable by developers of all skill levels.

## Core Philosophy

### Simple Always Better Than Complex
- **Principle**: Choose the simplest solution that solves the problem completely
- **Implementation**: Before suggesting complex patterns, ask "what is simplest thing that could work?"
- **Validation**: If solution needs extensive documentation to understand, probably too complex

### Grug Fear Complexity Demon
- **Avoid**: Deep inheritance hierarchies, excessive abstractions, clever code tricks
- **Prefer**: Flat structures, explicit logic, obvious code paths
- **Rule**: If grug brain cannot understand in 5 minutes, needs simplification

## Decision Framework

### When Choosing Solutions
1. **Can Grug Understand?**: Is the solution immediately comprehensible?
2. **Does It Actually Work?**: Focus on practical functionality over theoretical elegance
3. **Can Grug Debug?**: When it breaks (and it will), can it be fixed quickly?
4. **Can Other Grug Maintain?**: Will team members understand this in 6 months?

## Implementation Guidelines

### Code Structure
- **Functions**: Keep functions small enough to understand completely
- **Classes**: Prefer composition over inheritance ("grug no like family tree of code")
- **Modules**: One clear responsibility per module
- **Dependencies**: Minimize external dependencies ("fewer things to break")

```javascript
// Grug approve: Simple and clear
function calculateTotal(items) {
  let total = 0;
  for (const item of items) {
    total += item.price;
  }
  return total;
}

// Grug no approve: Too clever, hard to debug
const calculateTotal = items => items.reduce((acc, {price}) => acc + price, 0);
```

### Error Handling
- **Be Explicit**: Clear error messages that explain what went wrong
- **Fail Fast**: Don't hide errors or continue with bad state
- **Log Everything**: When things break, grug need information to fix

```python
# Grug approve: Clear what went wrong
def load_user(user_id):
    if not user_id:
        raise ValueError("user_id is required and cannot be empty")
    
    user = database.find_user(user_id)
    if not user:
        raise UserNotFoundError(f"No user found with id: {user_id}")
    
    return user

# Grug no approve: Silent failure, hard to debug
def load_user(user_id):
    try:
        return database.find_user(user_id) or {}
    except:
        return {}
```

### Tool Usage Philosophy
- **Learn Tools Deeply**: "spend time in new place learning tools around him to maximize productivity"
- **Good Debugger Essential**: "worth weight in shiny rocks"
- **IDE Features**: Use code completion, refactoring tools, built-in analysis
- **Never Stop Improving Tooling**: Continuously seek better ways to work

## Concurrency Handling

### Grug Fear Concurrency (And Should You)
- **Default Strategy**: Avoid when possible
- **When Required**: Use simplest possible concurrency model
- **Preferred Patterns**:
  - Stateless request handlers
  - Simple job queues without interdependencies
  - Thread-local variables for framework code only
  - Well-tested concurrent data structures

```rust
// Grug approve: Simple async, clear ownership
async fn process_request(request: Request) -> Result<Response, Error> {
    let data = fetch_data(&request.id).await?;
    let result = transform_data(data)?;
    Ok(Response::new(result))
}

// Grug fear: Complex shared state
// (avoid complex mutex/channel orchestration unless absolutely necessary)
```

## Optimization Philosophy

### Premature Optimization Root of All Evil
- **First Rule**: Always have concrete performance problem before optimizing
- **Measurement Required**: Profile first, optimize second
- **Common Surprise**: Network often bigger issue than CPU
- **Big-O Trap**: Don't optimize theoretical complexity without real-world measurements

### When to Optimize
1. **Have Real Performance Problem**: Users complaining, metrics showing issues
2. **Have Profiling Data**: Know exactly where the bottleneck is
3. **Have Measurable Target**: Know what "good enough" performance looks like
4. **Have Before/After Tests**: Verify optimization actually helps

## Testing Strategy

### Simple Tests That Actually Help
- **Test What Matters**: Focus on behavior users care about
- **Keep Tests Simple**: Test should be easier to understand than code
- **Fast Feedback**: Tests should run quickly and fail clearly
- **Real Scenarios**: Test actual usage patterns, not artificial examples

```python
# Grug approve: Tests real behavior
def test_user_can_checkout_cart():
    user = create_test_user()
    cart = add_items_to_cart(user, ["item1", "item2"])
    result = checkout_cart(cart)
    
    assert result.status == "success"
    assert result.total == 25.99
    assert user.orders[-1].items == 2

# Grug less approve: Tests implementation details
def test_cart_internal_state_transitions():
    # ... complex internal state testing ...
```

## Anti-Patterns to Avoid

### Complexity Demons
- **Over-Engineering**: Building for hypothetical future requirements
- **Clever Code**: Solutions that prioritize showing off over clarity
- **Framework Obsession**: Using heavy frameworks for simple problems
- **Premature Abstraction**: Creating abstractions before understanding actual patterns

### Common Mistakes
- **Too Many Layers**: Abstraction for the sake of abstraction
- **Magic Behavior**: Hidden complexity that makes debugging hard
- **Configuration Hell**: Too many configuration options
- **Dependency Madness**: Pulling in large dependencies for small features

## Problem-Solving Process

### When Stuck
1. **Step Back**: What is the actual problem trying to solve?
2. **Simplify**: What is the simplest solution that could work?
3. **Ask Grug Questions**:
   - "Why this complex?"
   - "What happens if just do simple thing?"
   - "What would break if remove this complexity?"

### Code Review Mindset
- **Can Future Grug Understand?**: Will this make sense in 6 months?
- **Is This Actually Needed?**: Could we solve problem more simply?
- **What Happens When It Breaks?**: Is debugging path clear?
- **Does It Follow Team Patterns?**: Consistency helps all grugs

## Tool Recommendations

### Essential Grug Tools
- **Good Debugger**: Learn all features, conditional breakpoints, expression evaluation
- **IDE with Smart Completion**: Don't memorize APIs, let tools help
- **Simple Profiler**: For when optimization actually needed
- **Plain Text Logs**: When things break, need information to fix
- **Version Control**: Save work, track changes, blame others appropriately

### Code Quality Tools
- **Linters**: Catch common mistakes before runtime
- **Formatters**: No bikeshedding about style
- **Test Runners**: Make running tests easy and fast
- **Dependency Scanners**: Know when things have security problems

## Success Metrics

### How Know If Following Grug Way
- **New Team Members Productive Quickly**: Simple code is learnable code
- **Bugs Are Fixable**: When problems occur, solution path is clear
- **Features Ship Reliably**: Less complexity means fewer things break
- **Code Reviews Are Pleasant**: Everyone can understand what's happening
- **Debugging Sessions Are Short**: Problems are isolated and obvious

### Warning Signs
- **Documentation Needed to Understand Code**: Probably too complex
- **Frequent "It Works on My Machine"**: Too many moving parts
- **Long Debugging Sessions**: Problem source not obvious
- **Fear of Changing Code**: Complexity makes changes risky

## Wisdom for Different Situations

### Starting New Project
- **Start Simple**: Don't build for scale you don't have
- **Choose Boring Technology**: Well-understood tools over shiny new things
- **Solve Real Problem**: Build what users actually need

### Working with Legacy Code
- **Understand First**: Don't change what you don't understand
- **Small Changes**: Big rewrites usually make things worse
- **Add Tests**: Before changing, make sure you know current behavior

### Performance Problems
- **Measure First**: Profile before optimizing
- **Check Network**: Often biggest bottleneck
- **Simple Solutions**: Usually caching or better algorithms, not fancy tricks

## Integration with Modern Development

### Works With Twelve-Factor Apps
- **Simplicity Helps**: Simple services are easier to deploy and scale
- **Clear Separation**: Grug brain likes obvious boundaries
- **Observable Behavior**: Simple code is easier to monitor

### Works With Agile/DevOps
- **Fast Feedback**: Simple code ships faster
- **Easier Testing**: Simple behavior is easier to verify
- **Better Monitoring**: Less complexity means clearer signals

### AI-Assisted Development
- **Clear Intent**: Simple code is easier for AI to understand and modify
- **Better Suggestions**: AI gives better recommendations for straightforward problems
- **Easier Review**: Human can verify AI suggestions more confidently

## Remember Grug Wisdom

> "grug brain developer not so smart, but grug brain developer program many long year and learn some things"

- **Embrace Simplicity**: Smart enough to keep things simple
- **Learn from Tools**: Good tools make grug more productive
- **Avoid Complexity Demons**: They make code hard to understand and maintain
- **Ship Working Code**: Better to have simple solution that works than complex solution that doesn't
- **Help Other Grugs**: Write code that team can understand and maintain

---

**"big brained developers are many, and some not expected to like this, make sour face... is fine!"**

The grug way is not about being anti-intellectual - it's about being pro-practical. Choose simplicity not because you can't handle complexity, but because you're wise enough to avoid it when it's not needed.

**Cross-references:**
- @bash.mdc for practical scripting approaches
- @git-commit-message.mdc for simple, clear communication
- @cursor-rules.mdc for rule structure and best practices
