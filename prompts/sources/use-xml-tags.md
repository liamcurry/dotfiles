# Use XML tags to structure your prompts

When your prompts involve multiple components like context, instructions, and
examples, XML tags can be a game-changer. They help Claude parse your prompts
more accurately, leading to higher-quality outputs.

<Tip>**XML tip**: Use tags like `<instructions>`, `<example>`, and
`<formatting>` to clearly separate different parts of your prompt. This prevents
Claude from mixing up instructions with examples or context.</Tip>

## Why use XML tags?

- **Clarity:** Clearly separate different parts of your prompt and ensure your
  prompt is well structured.
- **Accuracy:** Reduce errors caused by Claude misinterpreting parts of your
  prompt.
- **Flexibility:** Easily find, add, remove, or modify parts of your prompt
  without rewriting everything.
- **Parseability:** Having Claude use XML tags in its output makes it easier to
  extract specific parts of its response by post-processing.

<Note>There are no canonical "best" XML tags that Claude has been trained with
in particular, although we recommend that your tag names make sense with the
information they surround.</Note>

---

## Tagging best practices

1. **Be consistent**: Use the same tag names throughout your prompts, and refer
   to those tag names when talking about the content (e.g,
   `Using the contract in <contract> tags...`).
2. **Nest tags**: You should nest tags `<outer><inner></inner></outer>` for
   hierarchical content.

<Tip>**Power user tip**: Combine XML tags with other techniques like multishot
prompting (`<examples>`) or chain of thought (`<thinking>`, `<answer>`). This
creates super-structured, high-performance prompts.</Tip>

### Examples

#### Example: Generating financial reports

Without XML tags, Claude misunderstands the task and generates a report that
doesn't match the required structure or tone. After substitution, there is also
a chance that Claude misunderstands where one section (like the the Q1 report
example) stops and another begins.

_**No XML Tags:**_

USER:

> You’re a financial analyst at AcmeCorp. Generate a Q2 financial report for our
> investors. Include sections on Revenue Growth, Profit Margins, and Cash Flow,
> like with this example from last year: {{Q1_REPORT}}. Use data points from
> this spreadsheet: {{SPREADSHEET_DATA}}. The report should be extremely
> concise, to the point, professional, and in list format. It should and
> highlight both strengths and areas for improvement.

ASSISTANT:

> Q2 Financial Report for AcmeCorp Investors
>
> Dear Valued Investors,
>
> I am pleased to present our Q2 financial report, showcasing AcmeCorp’s
> continued growth and resilience in the B2B SaaS market.
>
> 1. Revenue Growth: Our Q2 revenue reached $15.2M, a 22% YoY increase. This
>    growth is primarily driven by a 30% expansion in our enterprise client
>    base. However, our SMB segment saw a slight decline of 5%, which we aim to
>    address through targeted marketing initiatives in Q3.
> 2. Profit Margins: Gross margin improved to 72% (up 3% from Q1) due to
>    infrastructure optimizations. EBITDA margin, however, dipped to 18% (down
>    2%) as we invested heavily in R&D for our upcoming AI-driven features.
> 3. Cash Flow: Operating cash flow remains strong at $4.1M. Our cash reserves
>    stand at $28M, providing a 15-month runway at current burn rate. We did see
>    a 20% increase in customer acquisition costs, which we’re addressing
>    through more efficient sales strategies.
>
> In summary, AcmeCorp’s core financials remain robust. We’re balancing growth
> investments with prudent cash management. Our focus for Q3 will be
> revitalizing SMB growth and optimizing sales efficiency.
>
> Thank you for your continued trust.
>
> Sincerely, CFO, AcmeCorp

_**With XML Tags:**_

USER:

> You’re a financial analyst at AcmeCorp. Generate a Q2 financial report for our
> investors.
>
> AcmeCorp is a B2B SaaS company. Our investors value transparency and
> actionable insights.
>
> Use this data for your report: <data>{{SPREADSHEET_DATA}}</data>
>
> <instructions>
>
> 1. Include sections: Revenue Growth, Profit Margins, Cash Flow.
> 2. Highlight strengths and areas for improvement.
>
> </instructions>
>
> Make your tone concise and professional. Follow this structure:
>
> <formatting-example>
>
> {{Q1_REPORT}}
>
> </formatting-example>

ASSISTANT:

> Q2 Financial Report for AcmeCorp Investors
>
> Revenue Growth:
>
> - Q2 revenue: $15.2M (22% YoY ↑)
> - Enterprise clients: 30% ↑
> - SMB segment: 5% ↓ Action: Targeted Q3 marketing
>
> Profit Margins:
>
> - Gross margin: 72% (3% ↑ from Q1) Reason: Infrastructure optimizations
> - EBITDA margin: 18% (2% ↓) Reason: R&D investment in AI features
>
> Cash Flow:
>
> - Operating cash flow: $4.1M (strong)
> - Cash reserves: $28M (15-month runway)
> - Customer acquisition cost: 20% ↑ Action: Optimize sales strategies
>
> Outlook:
>
> - Core financials: Robust
> - Q3 focus: Revitalize SMB, optimize sales
>
> Management remains committed to balancing growth investments with financial
> discipline.
