# Simon Willison's Practical Prompt Patterns for Developers

This document extracts reusable prompt patterns and pragmatic approaches from
Simon Willison's extensive work on prompt engineering for developers.

## Core Philosophy

Simon Willison emphasizes that LLMs are "fancy autocomplete" tools that augment
rather than replace human expertise. His approach is deeply practical, focusing
on patterns that deliver immediate value to developers.

### Key Principles

1. **Be Extremely Specific** - Provide detailed requirements, signatures, and
   constraints
2. **Iterate Rapidly** - Start simple, test, refine
3. **Manage Context Carefully** - Reset when conversations drift
4. **Test Everything** - Never trust LLM output without verification
5. **Learn Through Play** - "Vibe-coding" to build intuition

## Essential Prompt Patterns

### 1. Function Specification Pattern

**Purpose**: Generate precise code implementations

**Template**:

```
Write a [language] function that [specific behavior] with this signature:

    [exact function signature with types]

Requirements:
- [specific requirement 1]
- [specific requirement 2]
- Use [specific library/approach]
```

**Real Example**:

```
Write a Python function that uses asyncio httpx with this signature:

    async def download_db(url, max_size_bytes=5 * 1025 * 1025): -> pathlib.Path

Requirements:
- Download the content
- Respect the max_size_bytes limit
- Return a Path object to the downloaded file
```

### 2. Iterative Specification Development

**Purpose**: Build detailed specifications through conversation

**Pattern**:

```
Ask me one question at a time so we can develop a thorough, step-by-step spec for this idea. Each question should build on my previous answers, and our end goal is to have a detailed specification I can hand off to a developer.
```

**Benefits**:

- Uncovers hidden requirements
- Builds comprehensive understanding
- Creates actionable documentation

### 3. Plan-Then-Execute Pattern

**Purpose**: Handle complex refactoring or multi-step changes

**Template**:

```
First, write a detailed plan for [task description]. I'll review and iterate on this plan with you. Once we agree on the approach, we'll implement it step by step.

The plan should include:
1. Current state analysis
2. Proposed changes
3. Potential risks
4. Implementation order
```

**Usage**: Particularly effective for refactoring, where the LLM creates a
"meta-program" that guides implementation

### 4. Structured Output Pattern

**Purpose**: Generate parseable, consistent outputs

**Template**:

```
Respond with a single line of JSON with this structure:
{
  "field1": "description",
  "field2": "description"
}

Rules:
- Use only the specified fields
- Omit any other information
- Ensure valid JSON syntax
```

### 5. Context Seeding Pattern

**Purpose**: Guide LLM behavior with examples

**Approach**:

1. Provide existing code samples
2. Show desired patterns
3. Request similar implementation

**Example**:

```
Here's how we currently handle database connections:
[paste existing code]

Now write a similar function for handling Redis connections following the same patterns.
```

### 6. Safety and Confirmation Pattern

**Purpose**: Prevent unintended actions in agent systems

**Template**:

```
Before executing any action that has external effects:
1. Summarize what you're about to do
2. Ask for explicit confirmation
3. Only proceed after receiving a clear "yes"
```

## Multi-Agent Patterns

### Parallel Sub-Agent Processing

**Purpose**: Handle complex queries efficiently

**Pattern**:

- Break query into independent subtasks
- Process subtasks in parallel
- Aggregate results

**Key Insight**: "Subagents facilitate compression by operating in parallel with
their own context windows"

## Practical Development Workflows

### 1. The Rapid Prototype Flow

1. Start with a vague idea
2. Ask LLM for initial implementation
3. Test immediately
4. Request specific modifications
5. Iterate until satisfactory

### 2. The Documentation-First Flow

1. Write detailed documentation/spec
2. Feed to LLM as context
3. Request implementation matching docs
4. Verify against specification

### 3. The Debugging Flow

1. Paste error message and relevant code
2. Ask for specific fix (not general advice)
3. Test fix
4. If unsuccessful, provide new error and repeat

## Command-Line Integration

Simon's `llm` tool demonstrates practical patterns:

### Quick Queries

```bash
llm "Ten fun names for a pet pelican"
```

### Code Explanation

```bash
cat complex_function.py | llm -s "Explain this code"
```

### Multi-Modal Analysis

```bash
llm "Extract all the text" -a screenshot.png
```

### Interactive Development

```bash
llm chat -m gpt-4
# Then use !edit for complex prompts
# Use !multi for multi-line input
```

## Common Pitfalls and Solutions

### Pitfall 1: Over-Confident Hallucinations

**Solution**: Always verify library existence and method signatures

### Pitfall 2: Context Drift

**Solution**: Reset conversations when they become unproductive

### Pitfall 3: Vague Instructions

**Solution**: Be authoritative and specific - "Write a function that..." not
"Can you help me..."

### Pitfall 4: Treating LLMs as Oracles

**Solution**: Remember they're "over-confident interns" - helpful but require
supervision

## Advanced Techniques

### 1. Template Slot-Filling

For generating structured documents:

```
Fill the slots marked with <SLOT> in this template:

Title: <SLOT:title>
Description: <SLOT:one-paragraph-description>
Prerequisites: <SLOT:bullet-list-of-prerequisites>
```

### 2. Incremental Context Building

Start with minimal context, add as needed:

1. Initial prompt with core requirement
2. Add constraints based on first output
3. Provide examples if pattern isn't clear
4. Reset if context becomes polluted

### 3. Cross-Model Validation

Use multiple models for critical code:

```bash
# Generate with one model
llm -m gpt-4 "Write function X"

# Validate with another
llm -m claude-3 "Review this code for bugs: [paste code]"
```

## Key Takeaways

1. **Specificity Wins** - Detailed prompts produce better results
2. **Iteration is Normal** - First attempts are rarely final
3. **Context is King** - Good examples guide good outputs
4. **Test Everything** - LLMs make confident mistakes
5. **Build Intuition** - Practice with "vibe-coding" to understand capabilities

## Resources

- Simon's Blog:
  [simonwillison.net/tags/prompt-engineering/](https://simonwillison.net/tags/prompt-engineering/)
- LLM Tool: [github.com/simonw/llm](https://github.com/simonw/llm)
- Files-to-Prompt:
  [github.com/simonw/files-to-prompt](https://github.com/simonw/files-to-prompt)
- Practical Guide:
  [simonw.substack.com/p/how-i-use-llms-to-help-me-write-code](https://simonw.substack.com/p/how-i-use-llms-to-help-me-write-code)

---

_"The best way to learn LLMs is to play with them... The experience you build
up - your intuition for what they can and cannot do - is hard to put into
words."_ - Simon Willison

