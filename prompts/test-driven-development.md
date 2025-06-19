# Test-Driven Development

Write tests before code. Use tests to guide software design and catch bugs
early.

## Key Takeaways

- **Red-Green-Refactor cycle**: Write failing test → Make it pass → Clean up
  code
- **Tests drive design**: Writing tests first shapes better software
  architecture
- **Fast feedback loop**: Catch bugs in seconds, not days
- **Living documentation**: Tests show how your code should work
- **High confidence**: Change code safely with comprehensive test coverage

## Concepts

### The TDD Process

TDD follows three simple steps in a loop:

1. **Red**: Write a failing test for new functionality
2. **Green**: Write minimal code to make the test pass
3. **Refactor**: Clean up code while keeping tests green

This cycle takes about one minute. Repeat until feature is complete.

### The Three Laws of TDD

1. Write no production code without a failing unit test
2. Write only enough test code to fail (compilation counts as failing)
3. Write only enough production code to pass the failing test

These laws keep you in the Red-Green-Refactor cycle.

### Test-First Design

Writing tests first forces you to:

- Think about the interface before implementation
- Consider how the code will be used
- Create modular, testable code
- Focus on requirements, not clever solutions

### The TDD Cycles

**Nano-cycle (seconds)**: Follow the three laws **Micro-cycle (minutes)**:
Red-Green-Refactor\
**Milli-cycle (10 minutes)**: Make code more generic as tests get specific
**Primary cycle (hours)**: Review architecture and boundaries

### When to Use TDD

**Use TDD when**:

- Building new features from scratch
- Code needs long-term maintenance
- Team commits to TDD practice
- High code quality is critical
- Working with complex business logic

**Don't use TDD when**:

- Building throwaway prototypes
- Tight deadlines with simple requirements
- Testing user interfaces (use other approaches)
- Working with legacy code (start with characterization tests)
- Team lacks TDD experience and time to learn

## Rules

1. **Write the simplest failing test first**: Start with the most basic case
2. **Write minimal code to pass**: Resist the urge to solve future problems
3. **Refactor continuously**: Clean code minute-by-minute, not at the end
4. **Keep tests fast**: Under 100ms for unit tests, use mocks for slow
   dependencies
5. **One assertion per test**: Test one behavior at a time
6. **Use descriptive test names**: Test name should explain what it verifies
7. **Test behavior, not implementation**: Focus on what code does, not how
8. **Delete tests for deleted features**: Keep test suite lean and relevant
9. **Run tests frequently**: After every small change
10. **All tests must pass before committing**: Never commit broken tests

## Examples

### Example 1: Basic TDD Cycle

**GOOD TDD Approach**:

```python
# 1. RED: Write failing test
def test_calculate_total_for_empty_cart():
    cart = ShoppingCart()
    assert cart.calculate_total() == 0

# 2. GREEN: Make it pass
class ShoppingCart:
    def calculate_total(self):
        return 0

# 3. REFACTOR: Clean up (nothing to clean yet)
```

**BAD Approach**:

```python
# Writing complex implementation first
class ShoppingCart:
    def __init__(self):
        self.items = []
        self.tax_rate = 0.08
        self.discount_rules = DiscountEngine()
    
    def calculate_total(self):
        # 50 lines of complex logic
        # No tests to verify correctness
```

### Example 2: Test Naming

**GOOD Test Names**:

```python
def test_empty_cart_returns_zero_total()
def test_single_item_cart_returns_item_price()
def test_cart_with_discount_applies_percentage_reduction()
def test_invalid_discount_code_raises_exception()
```

**BAD Test Names**:

```python
def test_cart()
def test_calculate()
def test_discount_stuff()
def test_case_1()
```

### Example 3: Test Structure

**GOOD Test Structure**:

```python
def test_user_can_withdraw_money_from_account():
    # Arrange
    account = BankAccount(initial_balance=100)
    
    # Act
    account.withdraw(30)
    
    # Assert
    assert account.balance == 70
```

**BAD Test Structure**:

```python
def test_bank_operations():
    account = BankAccount(100)
    account.deposit(50)
    assert account.balance == 150
    account.withdraw(30)
    assert account.balance == 120
    account.withdraw(200)  # Should fail but test continues
    assert account.balance == 120  # Wrong assertion
```

### Example 4: Avoiding Anti-Patterns

**GOOD - Focused Test**:

```python
def test_password_validator_rejects_short_passwords():
    validator = PasswordValidator(min_length=8)
    result = validator.validate("abc123")
    assert result.is_valid == False
    assert "too short" in result.error_message
```

**BAD - The Giant Anti-Pattern**:

```python
def test_password_validator():
    validator = PasswordValidator()
    # 50 different test cases in one test
    assert validator.validate("short").is_valid == False
    assert validator.validate("").is_valid == False
    assert validator.validate("NoNumbers").is_valid == False
    assert validator.validate("nonumbers").is_valid == False
    # ... 46 more assertions
```

### Example 5: When NOT to Use TDD

**GOOD - Skip TDD for UI**:

```python
# Use integration tests for UI instead
def test_login_flow():
    # Use browser automation tools
    browser.visit("/login")
    browser.fill("username", "user@example.com")
    browser.fill("password", "secret")
    browser.click("Login")
    assert browser.url == "/dashboard"
```

**BAD - Forcing TDD on UI**:

```python
# Trying to unit test UI interactions
def test_login_button_click():
    button = LoginButton()
    button.on_click()
    # Hard to test UI state changes in isolation
```

### Example 6: Mock Usage

**GOOD Mock Usage**:

```python
def test_user_service_sends_welcome_email():
    # Arrange
    email_service = Mock()
    user_service = UserService(email_service)
    
    # Act
    user_service.create_user("john@example.com")
    
    # Assert
    email_service.send_welcome_email.assert_called_once_with("john@example.com")
```

**BAD - The Mockery Anti-Pattern**:

```python
def test_user_service():
    # Mocking everything
    database = Mock()
    email_service = Mock()
    logger = Mock()
    config = Mock()
    validator = Mock()
    # ... 10 more mocks
    
    # Test only verifies mock interactions, not real behavior
    user_service = UserService(database, email_service, logger, config, validator)
    user_service.create_user("test@example.com")
    
    # Only testing mocks, not actual logic
```

## Resources

| Name | Fetch When |
|------|------------|
| [Martin Fowler's TDD Guide](https://martinfowler.com/bliki/TestDrivenDevelopment.html) | Understanding TDD fundamentals |
| [Uncle Bob's TDD Cycles](https://blog.cleancoder.com/uncle-bob/2014/12/17/TheCyclesOfTDD.html) | Learning TDD cycle timing |
| [TDD Anti-Patterns Reference](https://www.codurance.com/publications/tdd-anti-patterns-chapter-1) | Avoiding common TDD mistakes |

### Local Resources

| Name | Fetch When |
|------|------------|
| @claude-code.md | Using AI assistance for TDD workflows |
| @simple-writing.md | Writing clear test descriptions |

## Checklist

- [ ] Write failing test before any production code
- [ ] Keep tests fast (under 100ms for unit tests)
- [ ] Use descriptive test names that explain behavior
- [ ] One assertion per test method
- [ ] Test behavior, not implementation details
- [ ] Mock external dependencies (databases, APIs, file system)
- [ ] Run tests after every small change
- [ ] Refactor code continuously while tests stay green
- [ ] All tests pass before committing code
- [ ] Delete tests when deleting features
- [ ] Tests serve as living documentation
- [ ] Test edge cases and error conditions
- [ ] Keep test code clean and maintainable
- [ ] Use arrange-act-assert structure
- [ ] Avoid test anti-patterns (giant, liar, slow poke, excessive setup,
      mockery)

