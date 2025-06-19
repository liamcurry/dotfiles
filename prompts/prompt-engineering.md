# Prompt Engineering

Write better prompts for AI models using proven techniques and clear patterns.

## KEY TAKEAWAYS

- **Clear, specific instructions**: Remove ambiguity by stating exactly what you want, including format, length, style, and constraints
- **Few-shot examples**: Provide 2-5 relevant examples to establish patterns—this single technique can improve accuracy by 20-40%
- **Chain-of-thought reasoning**: Add "Let's think step by step" or demonstrate reasoning in examples for complex problem-solving
- **Task decomposition**: Break complex requests into smaller, manageable subtasks that build toward the final solution
- **Systematic iteration**: Test prompts empirically, measure results, and refine based on actual outputs—prompt engineering is experimental
- **Context is crucial**: Provide relevant background, constraints, and role definitions to guide model behavior effectively
- **Match technique to task**: Use zero-shot for simple tasks, few-shot for pattern matching, CoT for reasoning, and advanced techniques for specialized needs

## CONCEPTS

### What is Prompt Engineering?

Prompt engineering means writing inputs that get the outputs you want from AI models. It combines creativity with testing. You write in plain language, but you need to understand what models can and can't do.

### Core Principles

**Clarity Over Cleverness**: Models work best with clear instructions. "Write a 3-paragraph product description focusing on benefits" beats "Write something good about this product."

**Examples Guide Behavior**: Models learn from patterns. Giving 2-5 examples (few-shot prompting) works better than long explanations. Research shows this improves results by 20-40%.

**Reasoning Improves Accuracy**: For logic or math tasks, ask models to show their work step by step. This cuts errors, especially in large models (100B+ parameters).

### Understanding Model Behavior

**Instruction Following**: Modern LLMs are trained to follow instructions precisely. Later instructions often override earlier ones, so place critical requirements near the end of prompts. Models also respond better to structured formats using markdown, XML tags, or numbered lists.

**Context Windows**: Every model has a limited context window (2K-128K tokens). Understanding these limits helps design prompts that fit within constraints while providing necessary information. Prioritize essential context and use techniques like summarization for longer inputs.

**Emergent Capabilities**: Certain techniques only work at scale. Chain-of-thought reasoning, for instance, becomes effective around 100B parameters. Smaller models may produce illogical reasoning chains that hurt performance.

### Types of Prompting

**Zero-Shot Prompting**: Give instructions without examples. Best for simple tasks the model knows well. Fast but limited for complex tasks.

**Few-Shot Prompting**: Give 2-5 examples before your task. Much better for specific formats or patterns. Pick diverse examples that show what you want.

**Chain-of-Thought (CoT)**: Ask models to think step by step. Use "Let's think step by step" or show examples with reasoning. Essential for math and logic problems.

**Advanced Techniques**: Tree of Thoughts (explore many paths), Self-Consistency (try multiple times), RAG (use external data), and ReAct (reason then act) for complex tasks.

## RULES

### Instruction Design

1. **Be explicit and specific**: State exactly what you want, including format, length, style, tone, and any constraints
2. **Use structured formats**: Leverage markdown headers, numbered lists, or XML tags to organize complex prompts
3. **Place key instructions prominently**: Put critical requirements at the beginning and end of prompts for emphasis
4. **Define success criteria**: Specify what constitutes a good response to guide model behavior

### Example Construction

5. **Provide 2-5 high-quality examples**: Too few limits pattern recognition; too many dilutes focus
6. **Ensure example diversity**: Cover different scenarios, edge cases, and variations in your examples
7. **Maintain consistent formatting**: Use the same structure across all examples to reinforce patterns
8. **Include both positive and negative examples**: Show what to do AND what to avoid when helpful

### Context Management

9. **Front-load essential context**: Provide critical background information before instructions
10. **Use delimiters for clarity**: Separate different prompt sections with clear markers like triple quotes or XML tags
11. **Manage token limits**: Be aware of model context windows and prioritize information accordingly
12. **Provide relevant constraints**: Specify limitations, requirements, or boundaries for the task

### Reasoning and Complexity

13. **Decompose complex tasks**: Break multi-faceted problems into sequential, manageable steps
14. **Use chain-of-thought for logic**: Add reasoning steps for mathematical, analytical, or decision-making tasks
15. **Enable self-correction**: Prompt models to review and verify their outputs when accuracy is critical

### Iteration and Testing

16. **Test systematically**: Evaluate prompts on representative examples, not just ideal cases
17. **Measure quantitatively**: Track success rates, accuracy, and other metrics across iterations
18. **Document variations**: Keep records of what works and what doesn't for future reference
19. **Adapt to specific models**: Different models may respond better to different phrasings or structures

## EXAMPLES

### Basic Instruction Clarity

**GOOD**:
```
Analyze the customer review below and extract:
1. Overall sentiment (positive/negative/neutral)
2. Specific product features mentioned
3. Would they recommend? (yes/no/unclear)

Format as JSON with keys: sentiment, features, recommendation

Review: """The laptop arrived quickly and the screen is gorgeous. Battery life is disappointing though - only 4 hours. Overall decent for the price."""
```

_Why: Clear structure, specific outputs requested, defined format, uses delimiters_

**BAD**:
```
What do you think about this review? The laptop arrived quickly and the screen is gorgeous. Battery life is disappointing though - only 4 hours. Overall decent for the price.
```

_Why: Vague request, no structure, ambiguous desired output, missing format specification_

### Few-Shot Pattern Establishment

**GOOD**:
```
Convert product features into customer benefits:

Feature: 8GB RAM
Benefit: Run multiple applications smoothly without slowdowns or freezing

Feature: Waterproof design  
Benefit: Use confidently in rain or near water without worry about damage

Feature: 10-hour battery
Benefit: Work all day without searching for power outlets

Feature: Dual-band WiFi
Benefit:
```

_Why: Clear examples showing transformation pattern, consistent format, practical benefits focus_

**BAD**:
```
8GB RAM is good. Waterproof is nice. 10-hour battery lasts long.
Now do dual-band WiFi.
```

_Why: No clear pattern, inconsistent format, doesn't demonstrate feature-to-benefit transformation_

### Chain-of-Thought Reasoning

**GOOD**:
```
A store has 120 apples. They sell 30% on Monday, 25% of the remainder on Tuesday, and receive a shipment of 40 apples on Wednesday. How many apples do they have?

Let's solve step by step:
1. Monday sales: 120 × 0.30 = 36 apples sold
2. Remaining after Monday: 120 - 36 = 84 apples
3. Tuesday sales: 84 × 0.25 = 21 apples sold  
4. Remaining after Tuesday: 84 - 21 = 63 apples
5. Wednesday shipment: 63 + 40 = 103 apples

The store has 103 apples.
```

_Why: Clear step-by-step breakdown, shows calculations, easy to verify logic_

**BAD**:
```
A store has 120 apples. They sell 30% on Monday, 25% of the remainder on Tuesday, and receive a shipment of 40 apples on Wednesday. Answer: 103 apples.
```

_Why: No reasoning shown, can't verify logic, prone to calculation errors_

### Complex Task Decomposition

**GOOD**:
```
Create a marketing email campaign for our new productivity app. Break this into steps:

Step 1: Define target audience and pain points
Step 2: Craft compelling subject lines (provide 3 options)
Step 3: Write email body with:
   - Hook addressing main pain point
   - 3 key benefits with examples
   - Social proof element
   - Clear CTA
Step 4: Create A/B test variations
Step 5: Define success metrics

Begin with Step 1:
```

_Why: Clear breakdown, specific deliverables per step, logical sequence, measurable outcomes_

**BAD**:
```
Write a good marketing email for our productivity app that converts well.
```

_Why: Too vague, no structure, unclear success criteria, single monolithic task_

### Error Prevention Through Constraints

**GOOD**:
```
Generate 5 unique usernames following these rules:
- Length: 8-12 characters
- Must include: letters and numbers
- Cannot include: special characters or spaces
- Cannot start with: numbers
- Must be: pronounceable and memorable

Examples of good usernames: TechNinja42, CloudWave89
Examples to avoid: 42TechNinja, T3chN!nj@

Generate 5 usernames:
```

_Why: Clear constraints, positive and negative examples, specific requirements, prevents common errors_

**BAD**:
```
Make some usernames
```

_Why: No constraints, no examples, likely to generate unsuitable options_

## CHECKLIST

### Planning Phase

1. [ ] **Define clear objectives** - What specific output do you need? What format? What quality criteria?
2. [ ] **Identify task complexity** - Is this zero-shot suitable or does it need examples/reasoning?
3. [ ] **Gather relevant context** - What background information does the model need?
4. [ ] **Choose appropriate technique** - Zero-shot, few-shot, CoT, or advanced methods?

### Prompt Construction

5. [ ] **Write clear instructions** - Remove ambiguity, be specific about requirements
6. [ ] **Structure with formatting** - Use markdown, lists, or tags for organization  
7. [ ] **Create quality examples** - If using few-shot, ensure diverse, representative examples
8. [ ] **Add reasoning steps** - For complex tasks, include chain-of-thought demonstrations
9. [ ] **Specify output format** - JSON, markdown, bullet points, paragraph form?
10. [ ] **Include constraints** - Length limits, style requirements, things to avoid

### Testing and Refinement

11. [ ] **Test on multiple examples** - Don't just test ideal cases; include edge cases
12. [ ] **Measure success rates** - Track accuracy, completeness, format compliance
13. [ ] **Identify failure patterns** - Where does the prompt consistently fail?
14. [ ] **Iterate systematically** - Adjust one element at a time to identify improvements
15. [ ] **Document what works** - Keep records of successful patterns for reuse
16. [ ] **Validate with stakeholders** - Ensure outputs meet actual user needs

### Production Considerations

17. [ ] **Optimize for token usage** - Balance thoroughness with efficiency
18. [ ] **Consider model variability** - Test across different model versions if applicable
19. [ ] **Build in error handling** - What if the model doesn't follow instructions?
20. [ ] **Plan for maintenance** - Prompts may need updates as models evolve