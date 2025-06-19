# Extended thinking tips

This guide provides advanced strategies and techniques for getting the most out
of Claude's extended thinking features. Extended thinking allows Claude to work
through complex problems step-by-step, improving performance on difficult tasks.

## Use general instructions first, then troubleshoot with more step-by-step instructions

Claude often performs better with high level instructions to just think deeply
about a task rather than step-by-step prescriptive guidance. The model's
creativity in approaching problems may exceed a human's ability to prescribe the
optimal thinking process.

For example, instead of:

> Think through this math problem step by step:
>
> 1. First, identify the variables
> 2. Then, set up the equation
> 3. Next, solve for x

Consider:

> Please think about this math problem thoroughly and in great detail. Consider
> multiple approaches and show your complete reasoning. Try different methods if
> your first approach doesn't work.

That said, Claude can still effectively follow complex structured execution
steps when needed. The model can handle even longer lists with more complex
instructions than previous versions. We recommend that you start with more
generalized instructions, then read Claude's thinking output and iterate to
provide more specific instructions to steer its thinking from there.

## Multishot prompting with extended thinking

Multishot prompting works well with extended thinking. When you provide Claude
examples of how to think through problems, it will follow similar reasoning
patterns within its extended thinking blocks.

You can include few-shot examples in your prompt in extended thinking scenarios
by using XML tags like `<thinking>` or `<scratchpad>` to indicate canonical
patterns of extended thinking in those examples.

Claude will generalize the pattern to the formal extended thinking process.
However, it's possible you'll get better results by giving Claude free rein to
think in the way it deems best.

Example:

> I'm going to show you how to solve a math problem, then I want you to solve a
> similar one.
>
> Problem 1: What is 15% of 80?
>
> <thinking>
>
> To find 15% of 80:
>
> 1. Convert 15% to a decimal: 15% = 0.15
> 2. Multiply: 0.15 × 80 = 12
>
> </thinking>
>
> The answer is 12.
>
> Now solve this one: Problem 2: What is 35% of 240?

## Maximizing instruction following with extended thinking

To maximize instruction following:

- Be clear and specific about what you want
- For complex instructions, consider breaking them into numbered steps that
  Claude should work through methodically

## Making the best of long outputs and longform thinking

For dataset generation use cases, try prompts such as "Please create an
extremely detailed table of..." for generating comprehensive datasets.

For use cases such as detailed content generation where you may want to generate
longer extended thinking blocks and more detailed responses, try these tips:

- Explicitly ask for longer outputs
- For very long outputs (20,000+ words), request a detailed outline with word
  counts down to the paragraph level. Then ask Claude to index its paragraphs to
  the outline and maintain the specified word counts

### Examples

Here are example use cases where Claude excels due to longer extended thinking:

#### Complex STEM problems

Complex STEM problems require Claude to build mental models, apply specialized
knowledge, and work through sequential logical steps—processes that benefit from
longer reasoning time.

**Standard prompt:**

> Write a python script for a bouncing yellow ball within a square, make sure to
> handle collision detection properly. Make the square slowly rotate.

**Enhanced prompt:**

> Write a Python script for a bouncing yellow ball within a tesseract, making
> sure to handle collision detection properly. Make the tesseract slowly rotate.
> Make sure the ball stays within the tesseract.

#### Constraint optimization problems

Constraint optimization challenges Claude to satisfy multiple competing
requirements simultaneously, which is best accomplished when allowing for long
extended thinking time so that the model can methodically address each
constraint.

**Standard prompt:**

> Plan a week-long vacation to Japan.

**Enhanced prompt:**

> Plan a 7-day trip to Japan with the following constraints:
>
> - Budget of $2,500
> - Must include Tokyo and Kyoto
> - Need to accommodate a vegetarian diet
> - Preference for cultural experiences over shopping
> - Must include one day of hiking
> - No more than 2 hours of travel between locations per day
> - Need free time each afternoon for calls back home
> - Must avoid crowds where possible

#### Thinking frameworks

Structured thinking frameworks give Claude an explicit methodology to follow,
which may work best when Claude is given long extended thinking space to follow
each step.

**Standard prompt:**

> Develop a comprehensive strategy for Microsoft entering the personalized
> medicine market by 2027.

**Enhanced prompt:**

> Develop a comprehensive strategy for Microsoft entering the personalized
> medicine market by 2027.
>
> Begin with:
>
> 1. A Blue Ocean Strategy canvas
> 2. Apply Porter's Five Forces to identify competitive pressures
>
> Next, conduct a scenario planning exercise with four distinct futures based on
> regulatory and technological variables.
>
> For each scenario:
>
> - Develop strategic responses using the Ansoff Matrix
>
> Finally, apply the Three Horizons framework to:
>
> - Map the transition pathway
> - Identify potential disruptive innovations at each stage

## Have Claude reflect on and check its work for improved consistency and error handling

You can use simple natural language prompting to improve consistency and reduce
errors:

1. Ask Claude to verify its work with a simple test before declaring a task
   complete
2. Instruct the model to analyze whether its previous step achieved the expected
   result
3. For coding tasks, ask Claude to run through test cases in its extended
   thinking

**Example:**

> Write a function to calculate the factorial of a number. Before you finish,
> please verify your solution with test cases for:
>
> - n=0
> - n=1
> - n=5
> - n=10
>
> And fix any issues you find.
