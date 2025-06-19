---
description:
globs:
alwaysApply: true
---

# Google Style Decision Framework for AI Agents

AI-optimized framework for making Google-style writing decisions through
categorical classification and structured reasoning. Use when creating
documentation, code comments, or technical content requiring Google editorial
standards.

## Core Decision Framework

### Style Classification System

```text
CONTENT_TYPE := DOCUMENTATION | API_REFERENCE | CODE_COMMENTS | UI_TEXT | ERROR_MESSAGES
AUDIENCE_LEVEL := BEGINNER | INTERMEDIATE | EXPERT | MIXED
CONTEXT_PURPOSE := TUTORIAL | REFERENCE | TROUBLESHOOTING | ANNOUNCEMENT | EXPLANATION
PLATFORM_SCOPE := GENERAL | ANDROID_SPECIFIC | CLOUD_SPECIFIC | MULTI_PLATFORM
```

### Google Priority Matrix

```text
DECISION_WEIGHT = (
  CLARITY × 0.40 +           // Reader understanding first
  CONSISTENCY × 0.25 +       // Project pattern adherence  
  ACCESSIBILITY × 0.20 +     // Global audience reach
  ACTIONABILITY × 0.15       // Clear next steps
)
```

### Reference Hierarchy Decision Tree

```text
IF project_style_exists THEN use_project_style()
ELIF google_guide_explicit THEN apply_google_pattern()
ELIF improves_clarity THEN break_rule_consistently()
ELSE default_to_simple_clear_language()
```

## Pattern Templates (Abstract Frameworks)

### Documentation Structure Pattern

```markdown
**Template**: [PURPOSE] + [OUTCOME] + [STEPS] + [VALIDATION] **Variables**:
{audience_level}, {task_complexity}, {platform_context} **Validation**:
scannable + actionable + accessible + tested

**Instantiation**:

- Tutorial → "Learn how to [OUTCOME]. Follow these steps: [STEPS]"
- Reference → "[FUNCTION] does [PURPOSE]. Parameters: [DETAILS]"
- Troubleshooting → "Problem: [ISSUE]. Solution: [STEPS]. Verify: [CHECK]"
```

### Voice & Tone Decision Matrix

| Content Type  | Audience | Context   | → Voice Pattern                             |
| ------------- | -------- | --------- | ------------------------------------------- |
| Tutorial      | Beginner | Learning  | → You + Present + Active + Encouraging      |
| API Docs      | Expert   | Reference | → Direct + Technical + Precise + Complete   |
| Error Message | Any      | Problem   | → Clear + Helpful + Specific + Actionable   |
| UI Text       | Mixed    | Action    | → Concise + Friendly + Obvious + Consistent |

### Word Choice Algorithm

```text
CHOOSE_WORD(term, audience, context):
  IF common_word_exists AND conveys_meaning THEN use_common_word()
  ELIF technical_term_required THEN define_on_first_use()
  ELIF global_audience THEN avoid_idioms_and_cultural_refs()
  ELSE apply_consistent_terminology()
```

## Chain-of-Thought Reasoning Process

### Writing Decision Loop

1. **Analyze Context**: What is reader trying to accomplish?
2. **Classify Content**: Which template pattern applies?
3. **Choose Voice**: Apply decision matrix for tone/style
4. **Structure Information**: Lead with purpose, end with action
5. **Validate Against Goals**: Scannable? Actionable? Accessible?
6. **Test Consistency**: Follows project patterns?

### Style Conflict Resolution

```markdown
**Reason**: What makes this writing decision complex? **Evaluate**:
[PROJECT_STYLE] vs [GOOGLE_GUIDE] vs [CLARITY_GOAL] **Choose**: Apply hierarchy
with consistent rationale **Document**: Note exception reasoning for future
consistency **Validate**: Does choice serve reader better than alternatives?
```

## Implementation Patterns

### Quick Decision Templates

#### For API Documentation

```text
PATTERN: function_purpose + parameters + returns + examples + errors
VOICE: direct + technical + complete
VALIDATION: copy_pasteable + realistic + comprehensive
```

#### For User Guides

```text
PATTERN: goal_statement + prerequisites + step_sequence + verification
VOICE: encouraging + clear + specific
VALIDATION: testable + logical_flow + error_handling
```

#### For Code Comments

```text
PATTERN: why_not_what + business_context + non_obvious_decisions
VOICE: explanatory + concise + current
VALIDATION: maintainable + accurate + helpful
```

### Formatting Decision Framework

```text
FOR ui_elements USE **bold**
FOR code_items USE `backticks`  
FOR emphasis USE *italic* (sparingly)
FOR structure USE headings + lists + whitespace
FOR accessibility USE descriptive_links + alt_text + logical_hierarchy
```

## Quality Validation Loops

### Real-Time Validation

- [ ] **Purpose Clear**: Reader knows what they'll accomplish
- [ ] **Action Obvious**: Next steps are explicit
- [ ] **Accessible**: Works for global audiences and screen readers
- [ ] **Tested**: Examples actually work as shown
- [ ] **Consistent**: Follows established project patterns

### Content Quality Gates

```markdown
## Validation Questions (Always Ask)

1. **Clarity**: Can non-expert understand main points?
2. **Completeness**: Can reader accomplish stated goal?
3. **Accuracy**: Do all examples and procedures work?
4. **Accessibility**: Works for diverse audiences and tools?
5. **Consistency**: Matches project terminology and style?
```

### Anti-Pattern Detection

```text
❌ REJECT_IF_CONTAINS:
- "Please note that..." (unnecessary hedge)
- "Simply" or "Just" (minimizes complexity)
- "Obviously" or "Clearly" (assumes knowledge)
- Undefined acronyms or jargon
- Cultural references or idioms
- Missing error handling or edge cases

✅ ACCEPT_IF_DEMONSTRATES:
- Active voice with clear subjects
- Specific rather than vague language  
- Global English without cultural assumptions
- Complete examples with expected outcomes
- Logical information hierarchy
```

## Context-Specific Adaptations

### Platform Annotations

```text
IF android_specific THEN mark_with_android_indicator()
IF cloud_specific THEN mark_with_cloud_indicator()  
IF general_guidance THEN apply_across_all_platforms()
```

### Audience Adaptations

```text
FOR beginners: more_context + step_by_step + common_gotchas
FOR experts: concise_reference + comprehensive_parameters + edge_cases
FOR mixed: progressive_disclosure + quick_start + detailed_sections
```

## Grug-Brain Simplification Rules

### Decision Shortcuts (When Overwhelmed)

1. **Choose clarity** over cleverness
2. **Use common words** over impressive ones
3. **Write for global audience** (simple sentence structure)
4. **Lead with what reader accomplishes**
5. **End with specific next action**

### Emergency Simplification

```text
IF writing_too_complex THEN:
  - Break into shorter sentences
  - Replace jargon with common terms
  - Add concrete examples
  - Remove unnecessary qualifiers
  - Test with beginner mindset
```

## Integration with Project Standards

### Cross-Rule Coordination

- **Reference**: @grugbed.mdc for simplicity principles
- **Build on**: @cursor-rules.mdc for structure patterns
- **Complement**: @git-commit-message.mdc for concise communication
- **Follow**: @meta.mdc for decision-making frameworks

### Development Workflow

```text
ON documentation_change:
  1. Apply Google style decision framework
  2. Validate against quality gates
  3. Test examples and procedures
  4. Check accessibility compliance
  5. Ensure project consistency
```

## Continuous Improvement

### Feedback Integration

```markdown
## Style Decision Retrospective

1. **What served readers well?** [EFFECTIVE_PATTERNS]
2. **What caused confusion?** [PROBLEMATIC_AREAS]
3. **What patterns emerged?** [REUSABLE_SOLUTIONS]
4. **How to improve next time?** [PROCESS_REFINEMENTS]
```

### Pattern Evolution

- Monitor user feedback and analytics
- Update templates based on successful patterns
- Refine decision matrix weights based on outcomes
- Document new patterns for team consistency

---

## Meta-Rule: Clarity Through Structure

Google style isn't about following rules—it's about making decisions that serve
readers. Use this framework to reason through writing choices systematically
rather than memorizing style minutiae.

**Remember**: Break any rule to avoid saying anything outright barbarous.
Consistency within documents trumps adherence to guidelines. Serve the reader,
not the style guide.

**Decision mantra**: Project style → Google patterns → Clarity principles →
Consistent application
