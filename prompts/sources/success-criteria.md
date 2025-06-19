# Define your success criteria

Building a successful LLM-based application starts with clearly defining your
success criteria. How will you know when your application is good enough to
publish?

Having clear success criteria ensures that your prompt engineering &
optimization efforts are focused on achieving specific, measurable goals.

## Building strong criteria

Good success criteria are:

- **Specific**: Clearly define what you want to achieve. Instead of "good
  performance," specify "accurate sentiment classification."
- **Measurable**: Use quantitative metrics or well-defined qualitative scales.
  Numbers provide clarity and scalability, but qualitative measures can be
  valuable if consistently applied _along_ with quantitative measures.
- **Achievable**: Base your targets on industry benchmarks, prior experiments,
  AI research, or expert knowledge. Your success metrics should not be
  unrealistic to current frontier model capabilities.
- **Relevant**: Align your criteria with your application's purpose and user
  needs. Strong citation accuracy might be critical for medical apps but less so
  for casual chatbots.

### Metrics and measurement methods

**Quantitative metrics**:

- Task-specific: F1 score, BLEU score, perplexity
- Generic: Accuracy, precision, recall
- Operational: Response time (ms), uptime (%)

**Quantitative methods**:

- A/B testing: Compare performance against a baseline model or earlier version.
- User feedback: Implicit measures like task completion rates.
- Edge case analysis: Percentage of edge cases handled without errors.

**Qualitative scales**:

- Likert scales: "Rate coherence from 1 (nonsensical) to 5 (perfectly logical)"
- Expert rubrics: Linguists rating translation quality on defined criteria

### Example: measurable safety criteria

Even "hazy" topics such as ethics and safety can be quantified.

**Bad:**

> Safe outputs

**Good:**

> Less than 0.1% of outputs out of 10,000 trials flagged for toxicity by our
> content filter.

### Example: task fidelity criteria for sentiment analysis

**Bad:**

> The model should classify sentiments well

**Good:**

> Our sentiment analysis model should achieve an F1 score of at least 0.85
> (Measurable, Specific) on a held-out test set[^1] of 10,000 diverse Twitter
> posts (Relevant), which is a 5% improvement over our current baseline
> (Achievable).

[^1]: More on held-out test sets in the next section

## Common success criteria to consider

Here are some criteria that might be important for your use case. This list is
non-exhaustive.

### Task fidelity

How well does the model need to perform on the task? You may also need to
consider edge case handling, such as how well the model needs to perform on rare
or challenging inputs.

### Consistency

How similar does the model's responses need to be for similar types of input? If
a user asks the same question twice, how important is it that they get
semantically similar answers?

### Relevance and coherence

How well does the model directly address the user's questions or instructions?
How important is it for the information to be presented in a logical, easy to
follow manner?

### Tone and style

How well does the model's output style match expectations? How appropriate is
its language for the target audience?

### Privacy preservation

What is a successful metric for how the model handles personal or sensitive
information? Can it follow instructions not to use or share certain details?

### Context utilization

How effectively does the model use provided context? How well does it reference
and build upon information given in its history?

### Latency

What is the acceptable response time for the model? This will depend on your
application's real-time requirements and user expectations.

### Price

What is your budget for running the model? Consider factors like the cost per
API call, the size of the model, and the frequency of usage.

### Example: multidimensional criteria for sentiment analysis

Most use cases will need multidimensional evaluation along several success
criteria.

**Bad:**

> The model should classify sentiments well

**Good:**

> On a held-out test set of 10,000 diverse Twitter posts, our sentiment analysis
> model should achieve:
>
> - an F1 score of at least 0.85
> - 99.5% of outputs are non-toxic
> - 90% of errors are would cause inconvenience, not egregious error[^2]
> - 95% response time < 200ms

[^2]: In reality, we would also define what “inconvenience” and “egregious”
    means.
