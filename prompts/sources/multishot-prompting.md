# Use examples (multishot prompting) to guide Claude's behavior

Examples are your secret weapon shortcut for getting Claude to generate exactly
what you need. By providing a few well-crafted examples in your prompt, you can
dramatically improve the accuracy, consistency, and quality of Claude's outputs.
This technique, known as few-shot or multishot prompting, is particularly
effective for tasks that require structured outputs or adherence to specific
formats.

<Tip>**Power up your prompts**: Include 3-5 diverse, relevant examples to show
Claude exactly what you want. More examples = better performance, especially for
complex tasks.</Tip>

## Why use examples?

- **Accuracy**: Examples reduce misinterpretation of instructions.
- **Consistency**: Examples enforce uniform structure and style.
- **Performance**: Well-chosen examples boost Claude's ability to handle complex
  tasks.

## Crafting effective examples

For maximum effectiveness, make sure that your examples are:

- **Relevant**: Your examples mirror your actual use case.
- **Diverse**: Your examples cover edge cases and potential challenges, and vary
  enough that Claude doesn't inadvertently pick up on unintended patterns.
- **Clear**: Your examples are wrapped in `<example>` tags (if multiple, nested
  within `<examples>` tags) for structure.

<Tip>Ask Claude to evaluate your examples for relevance, diversity, or clarity.
Or have Claude generate more examples based on your initial set.</Tip>

### Example: Analyzing customer feedback

Notice that in the "no examples" version, Claude does not list multiple options
for each category, despite its written analysis indicating that there are
multiple categories for certain feedback. It also includes a long explanation
when we may not want it to.

_**No examples:**_

USER:

> Analyze this customer feedback and categorize the issues. Use these
> categories: UI/UX, Performance, Feature Request, Integration, Pricing, and
> Other. Also rate the sentiment (Positive/Neutral/Negative) and priority
> (High/Medium/Low).
>
> Here is the feedback: {{FEEDBACK}}

ASSISTANT:

> Here’s the analysis of the customer feedback:
>
> Issue: UI/UX Sentiment: Negative Priority: High The customer is frustrated
> with the new dashboard design, which they find cluttered and slow to load.
> They specifically call out the missing “export” button, which is likely a
> critical feature. This issue needs to be addressed as a high priority.
>
> Issue: Integration Sentiment: Positive Priority: Medium The customer is
> pleased with the existing Salesforce integration but would like to see support
> for Hubspot as well. This is a feature request that could be considered for a
> future product update.
>
> Issue: Pricing Sentiment: Negative Priority: High The customer finds the
> pricing to be unreasonable, especially for the basic features. They are
> threatening to switch to a competitor, so this is a high-priority issue that
> needs to be reviewed.
>
> Issue: Performance Sentiment Negative Priority: High The customer is
> experiencing critical issues with the mobile app, where large file uploads
> consistently result in crashes. This is a significant problem that impacts the
> customer’s ability to use the product effectively and should be addressed as a
> high priority.
>
> Issue: UI/UX Sentiment: Positive Priority: Low The customer is overall
> satisfied with the product, specifically calling out the intuitive UI and
> excellent customer support. This is a positive piece of feedback that does not
> require any immediate action.

_**With examples:**_

USER:

> Our CS team is overwhelmed with unstructured feedback. Your task is to analyze
> feedback and categorize issues for our product and engineering teams. Use
> these categories: UI/UX, Performance, Feature Request, Integration, Pricing,
> and Other. Also rate the sentiment (Positive/Neutral/Negative) and priority
> (High/Medium/Low). Here is an example:
>
> <example>
>
> Input: "The new dashboard is a mess! It takes forever to load, and I can’t
> find the export button. Fix this ASAP!"
>
> - Category: UI/UX
> - Performance Sentiment:
> - Negative Priority: High
>
> </example>
>
> Now, analyze this feedback: {{FEEDBACK}}

ASSISTANT:

> Here’s the analysis of the customer feedback:
>
> 1. "The new dashboard is a mess! It takes forever to load, and I can’t find
>    the export button. Fix this ASAP!"
>
> - Category: UI/UX, Performance
> - Sentiment: Negative
> - Priority: High
>
> 2. "Love the Salesforce integration! But it’d be great if you could add
>    Hubspot too."
>
> - Category: Integration, Feature Request
> - Sentiment: Positive
> - Priority: Medium
>
> 3. "Your pricing is ridiculous! $99/mo for basic features? I’m switching to
>    Competitor X."
>
> - Category: Pricing
> - Sentiment: Negative
> - Priority: High
>
> 4. "The mobile app keeps crashing when I try to upload large files (>50MB).
>    This is critical for our field agents."
>
> - Category: Performance
> - Sentiment: Negative
> - Priority: High
>
> 5. "Overall, I’m happy with the product. The UI is intuitive, and the customer
>    support is top-notch. Keep it up!"
>
> - Category: UI/UX, Other (Customer Support)
> - Sentiment: Positive
> - Priority: Low
