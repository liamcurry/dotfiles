# Let Claude think (chain of thought prompting) to increase performance

When faced with complex tasks like research, analysis, or problem-solving,
giving Claude space to think can dramatically improve its performance. This
technique, known as chain of thought (CoT) prompting, encourages Claude to break
down problems step-by-step, leading to more accurate and nuanced outputs.

## Before implementing CoT

### Why let Claude think?

- **Accuracy:** Stepping through problems reduces errors, especially in math,
  logic, analysis, or generally complex tasks.
- **Coherence:** Structured thinking leads to more cohesive, well-organized
  responses.
- **Debugging:** Seeing Claude's thought process helps you pinpoint where
  prompts may be unclear.

<Tip>Use CoT for tasks that a human would need to think through, like complex
math, multi-step analysis, writing complex documents, or decisions with many
factors.</Tip>

## How to prompt for thinking

The chain of thought techniques below are **ordered from least to most
complex**.

Include "Think step-by-step" in your prompt.

### Examples

#### Example: Writing donor emails (basic CoT)

**Basic prompt:** Lacks guidance on _how_ to think (which is especially not
ideal if a task is very specific to your app, use case, or organization)

USER:

> Draft personalized emails to donors asking for contributions to this year’s
> Care for Kids program.
>
> Program information:
> <program> {{PROGRAM_DETAILS}}
> </program>
>
> Donor information:
> <donor>{{DONOR_DETAILS}}
> </donor>
>
> Think step-by-step before you write the email.

#### Example: Writing donor emails (guided CoT)

**Guided prompt:** Outline specific steps for Claude to follow in its thinking
process. Lacks structuring to make it easy to strip out and separate the answer
from the thinking.

USER:

> Draft personalized emails to donors asking for contributions to this year’s
> Care for Kids program.
>
> Program information:
> <program>{{PROGRAM_DETAILS}}
> </program>
>
> Donor information:
> <donor>{{DONOR_DETAILS}}
> </donor>
>
> Think before you write the email. First, think through what messaging might
> appeal to this donor given their donation history and which campaigns they’ve
> supported in the past. Then, think through what aspects of the Care for Kids
> program would appeal to them, given their history. Finally, write the
> personalized donor email using your analysis.

#### Example: Writing donor emails (structured guided CoT)

**Structured prompt**: Use XML tags like `<thinking>` and `<answer>` to separate
reasoning from the final answer.

USER:

> Draft personalized emails to donors asking for contributions to this year’s
> Care for Kids program.
>
> Program information:
> <program>{{PROGRAM_DETAILS}}
> </program>
>
> Donor information:
> <donor>{{DONOR_DETAILS}}
> </donor>
>
> Think before you write the email in <thinking> tags. First, think through what
> messaging might appeal to this donor given their donation history and which
> campaigns they’ve supported in the past. Then, think through what aspects of
> the Care for Kids program would appeal to them, given their history. Finally,
> write the personalized donor email in <email> tags, using your analysis.

#### Example: Financial analysis without thinking

Without step-by-step thinking, Claude gives a recommendation that seems
reasonable but lacks depth. It doesn’t quantify the potential outcomes or
consider historical market performance, which are crucial for making an informed
decision.

USER:

> You’re a financial advisor. A client wants to invest $10,000. They can choose
> between two options: A) A stock that historically returns 12% annually but is
> volatile, or B) A bond that guarantees 6% annually. The client needs the money
> in 5 years for a down payment on a house. Which option do you recommend?

ASSISTANT:

> Based on the information provided, I would recommend option B, the bond that
> guarantees a 6% annual return. Here’s why:
>
> 1. Certainty: The bond offers a guaranteed 6% annual return, which provides
>    certainty in financial planning. This is crucial when the client has a
>    specific financial goal (down payment) with a fixed timeline (5 years).
> 2. Risk aversion: Since the client needs this money for an important life
>    event (buying a house), they likely have a low risk tolerance. The
>    volatility of the stock market could jeopardize their plans if there’s a
>    downturn close to when they need the funds.
> 3. Time horizon: With only 5 years, there’s less time to recover from
>    potential stock market downturns. Longer investment horizons (10+ years)
>    are generally better suited for weathering stock market volatility.
>
> While the stock’s historical 12% return is attractive, past performance
> doesn’t guarantee future results. The guaranteed 6% from the bond ensures the
> client will have the funds they need when it’s time to make the down payment.

#### Example: Financial analysis with thinking

With step-by-step thinking, the advisor provides a much richer analysis. It
calculates exact figures for both scenarios, considers historical market
volatility, and deeply analyzes the client’s risk tolerance. This thorough
reasoning leads to a more confident and justifiable recommendation.

USER:

> You’re a financial advisor. A client wants to invest $10,000. They can choose
> between two options: A) A stock that historically returns 12% annually but is
> volatile, or B) A bond that guarantees 6% annually. The client needs the money
> in 5 years for a down payment on a house. Which option do you recommend? Think
> step-by-step.

ASSISTANT:

> To determine the best investment option for our client, I’ll consider several
> factors step-by-step:
>
> <thinking>
>
> 1. Understand the client’s goal and timeline:
>
> - Goal: Down payment for a house
> - Timeline: 5 years
> - Implication: This is a short-term, high-priority financial goal. The client
>   likely cannot afford significant risk or volatility.
>
> 2. Analyze Option A (Stock):
>
> - Pro: Higher historical return (12% annually)
> - Con: Volatile (implying potential for significant gains or losses)
> - Calculate potential 5-year return:
> - Best case (12% annually): $10,000 * (1.12)^5 ≈ $17,623.42
> - Worst case (market crash): Could lose a substantial portion, e.g., 50% crash
>   = $5,000
>
> 3. Analyze Option B (Bond):
>
> - Pro: Guaranteed return (6% annually)
> - Con: Lower return compared to historical stock performance
> - Calculate 5-year return:
> - Guaranteed: $10,000 * (1.06)^5 ≈ $13,382.25
>
> 4. Consider risk tolerance:
>
> - Goal is a house down payment (essential, not discretionary)
> - Short timeline (5 years) limits ability to recover from market downturns
> - Conclusion: Client likely has low risk tolerance
>
> 5. Historical perspective:
>
> - Stock’s 12% is historical, not guaranteed
> - In 5-year periods, stock market can vary wildly:
> - 2003-2007 (pre-financial crisis): S&P 500 up ~82%
> - 2007-2011 (during crisis): S&P 500 down ~2%
> - Conclusion: Past performance doesn’t guarantee future results, especially
>   short-term
>
> 6. Final analysis:
>
> - Option A (Stock): Higher potential return but unacceptable risk of not
>   meeting the down payment goal
> - Option B (Bond): Guaranteed to meet ~80% of best-case stock scenario, 100%
>   certainty of having funds
>
> </thinking>
>
> <answer>
>
> I recommend Option B, the bond with a guaranteed 6% annual return. While the
> stock’s historical 12% return is tempting, the bond ensures you’ll have
> $13,382.25 in 5 years for your house down payment. Given the importance and
> short timeline of your goal, the stock’s volatility poses an unacceptable
> risk. The bond provides certainty, which is invaluable for such a crucial
> financial milestone.
>
> </answer>
