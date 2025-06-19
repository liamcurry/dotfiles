# AI Rule Optimization Template

_Research-backed template for optimizing AI assistant rules_

## XML Structure for Claude Optimization

```xml
<role>
[Specific role definition - Expert X with Y years experience]
</role>

<purpose>
[Clear, concise statement of what this rule accomplishes]
</purpose>

<principles>
[3-5 core principles, action-oriented]
1. [Principle 1 - actionable]
2. [Principle 2 - actionable] 
3. [Principle 3 - actionable]
</principles>

<examples>
<example>
Scenario: [Specific context]
Good: [Concrete positive example]
Why: [Reasoning for effectiveness]
</example>

<example>
Scenario: [Different context]
Bad: [Concrete negative example]
Good: [Improved version]
Why: [Reasoning for improvement]
</example>

<example>
Scenario: [Edge case context]
Approach: [Recommended handling]
Rationale: [Decision reasoning]
</example>
</examples>

<anti_patterns>
Common mistakes to avoid:
- [Anti-pattern 1]: [Why it fails]
- [Anti-pattern 2]: [Why it fails]
- [Anti-pattern 3]: [Why it fails]
</anti_patterns>

<quality_gates>
Success criteria:
- [ ] [Measurable criterion 1]
- [ ] [Measurable criterion 2]
- [ ] [Measurable criterion 3]
</quality_gates>

<thinking>
When applying this rule, consider:
1. [Key decision point 1]
2. [Key decision point 2]
3. [Key decision point 3]
</thinking>
```

## Optimization Checklist

### Clarity (Target: 9/10)
- [ ] Instructions are unambiguous
- [ ] Technical terms defined
- [ ] Context sufficient for understanding
- [ ] Success criteria explicit

### Specificity (Target: 9/10)
- [ ] Output format clearly defined
- [ ] Scope and constraints explicit
- [ ] Edge cases addressed
- [ ] Quality standards specified

### Structure (Target: 9/10)
- [ ] Logical information flow
- [ ] XML tags for Claude optimization
- [ ] Clear section separation
- [ ] Hierarchical organization

### Efficiency (Target: 8/10)
- [ ] Redundant language eliminated
- [ ] Power words replace weak constructions
- [ ] Token count optimized (25-30% reduction)
- [ ] Essential information preserved

### Examples (Target: 9/10)
- [ ] 3-5 relevant examples provided
- [ ] Examples match task complexity
- [ ] Diverse scenarios covered
- [ ] Clear good/bad contrasts

## Word Efficiency Optimization

### Elimination Targets
| Wordy | Efficient | Savings |
|-------|-----------|---------|
| "due to the fact that" | "because" | 4 → 1 tokens |
| "in order to" | "to" | 3 → 1 tokens |
| "for the purpose of" | "to" | 4 → 1 tokens |
| "at this point in time" | "now" | 5 → 1 tokens |
| "it is important to note that" | _delete_ | 7 → 0 tokens |

### Power Word Substitutions
| Weak | Strong | Impact |
|------|--------|---------|
| "went quickly" | "rushed" | Verb + adverb → precise verb |
| "very unique" | "unique" | Remove redundant intensifier |
| "quite good" | "effective" | Replace vague qualifier |
| "sort of like" | "resembles" | Remove hedging language |

## Quality Metrics

### Pre-Optimization Assessment
- Clarity: [1-10 score]
- Specificity: [1-10 score]
- Structure: [1-10 score]
- Efficiency: [1-10 score]
- Examples: [1-10 score]
- Token count: [exact count]

### Post-Optimization Targets
- All scores: 8+ (9+ for critical areas)
- Token reduction: 25-30%
- Maintained domain knowledge accuracy
- Improved actionability

## Implementation Notes

1. **Backup Original**: Always preserve original version
2. **Incremental Changes**: Test improvements step by step
3. **Domain Expertise**: Preserve all critical knowledge
4. **Consistency**: Follow unified template structure
5. **Validation**: Test against real-world scenarios