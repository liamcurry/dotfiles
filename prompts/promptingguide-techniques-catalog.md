# PromptingGuide.ai Comprehensive Techniques Catalog

## Overview

PromptingGuide.ai is a comprehensive prompt engineering resource that has served
over 3 million learners. It provides the latest papers, advanced prompting
techniques, learning guides, model-specific prompting guides, lectures, and
tools for prompt engineering.

## Prompting Techniques Categorization

### 1. Basic Techniques

#### Zero-Shot Prompting

- **Description**: Model performs tasks without specific training examples
- **When to Use**:
  - Simple, well-understood tasks
  - Tasks frequently encountered in training data
  - Basic arithmetic, general queries, sentiment classification
  - When efficiency is prioritized over precision
- **Key Benefit**: No examples needed, relies on pre-trained knowledge

#### Few-Shot Prompting

- **Description**: Provides limited examples (2+ examples) to guide model's
  response
- **When to Use**:
  - Complex tasks requiring pattern recognition
  - Tasks with varied inputs requiring precise formatting
  - Structured information extraction
  - Content generation with specific patterns
  - When zero-shot isn't sufficient
- **Key Benefit**: Helps model generalize from multiple examples

#### Chain-of-Thought (CoT) Prompting

- **Description**: Encourages step-by-step reasoning
- **When to Use**:
  - Complex reasoning tasks
  - Mathematical problem-solving
  - Multi-step logical deductions
  - When transparency in reasoning is needed
- **Key Benefit**: Improves complex problem-solving capabilities

### 2. Advanced Techniques

#### Meta Prompting

- **Description**: Advanced technique for generating or refining prompts
- **When to Use**: When optimizing prompt quality and model performance
- **Key Benefit**: Enhances prompt effectiveness

#### Self-Consistency

- **Description**: Generates multiple solution paths and aggregates results
- **When to Use**:
  - When reliability is critical
  - Complex problems with multiple valid approaches
  - To validate response accuracy
- **Key Benefit**: Improves response reliability through consensus

#### Generate Knowledge Prompting

- **Description**: Model first generates relevant background knowledge before
  answering
- **When to Use**:
  - Tasks requiring domain-specific knowledge
  - When context enhancement is needed
  - Complex questions needing background information
- **Key Benefit**: More informed and contextual responses

#### Prompt Chaining

- **Description**: Breaks complex tasks into sequential prompts
- **When to Use**:
  - Multi-stage workflows
  - Tasks too complex for single prompts
  - When intermediate results need validation
- **Key Benefit**: Structured and manageable problem-solving

#### Tree of Thoughts (ToT)

- **Description**: Explores multiple reasoning paths simultaneously
- **When to Use**:
  - Complex decision-making scenarios
  - Problems with branching possibilities
  - Strategic planning tasks
- **Key Benefit**: Enhanced decision-making through parallel exploration

#### Retrieval Augmented Generation (RAG)

- **Description**: Incorporates external knowledge retrieval
- **When to Use**:
  - Tasks requiring up-to-date information
  - Domain-specific queries
  - When model's training data is insufficient
- **Key Benefit**: Improved accuracy with contextual information

### 3. Specialized Techniques

#### Automatic Reasoning and Tool-use (ART)

- Enables models to use external tools and APIs
- For tasks requiring computation or external data access

#### Automatic Prompt Engineer (APE)

- Automatically generates and optimizes prompts
- For systematic prompt improvement

#### Active-Prompt

- Dynamically adapts prompts based on model responses
- For iterative refinement scenarios

#### Directional Stimulus Prompting

- Provides specific directional cues to guide generation
- For controlled content generation

#### Program-Aided Language Models (PAL)

- Combines natural language with programmatic execution
- For tasks requiring precise computation

#### ReAct (Reasoning + Acting)

- Combines reasoning with action execution
- For agent-based tasks and tool interaction

#### Reflexion

- Enables self-reflection and improvement
- For iterative task refinement

#### Multimodal Chain-of-Thought

- Applies CoT to multimodal inputs (text + images)
- For visual reasoning tasks

#### Graph Prompting

- Uses graph structures in prompts
- For relational reasoning and network analysis

## Selection Framework

### Task Complexity Assessment

1. **Simple Tasks** → Zero-shot prompting
2. **Moderate Complexity** → One-shot or Few-shot prompting
3. **Complex Reasoning** → Chain-of-Thought prompting
4. **Multi-stage Tasks** → Prompt Chaining
5. **Exploratory Tasks** → Tree of Thoughts

### Performance Requirements

- **Speed Priority** → Zero-shot
- **Accuracy Priority** → Few-shot or Self-Consistency
- **Reliability Priority** → Self-Consistency or Multiple techniques

### Special Considerations

- **Limited Context Window** → Consider RAG-based few-shot
- **Need for External Data** → RAG or Tool-use techniques
- **Require Transparency** → Chain-of-Thought
- **Iterative Improvement** → Reflexion or Active-Prompt

## Best Practices

1. **Start Simple**: Begin with zero-shot and escalate complexity as needed
2. **Test Incrementally**: Try techniques in order of complexity
3. **Combine Techniques**: Many techniques can be used together
4. **Consider Context Limits**: Be mindful of token limits when using few-shot
5. **Validate Results**: Use self-consistency for critical applications

## Educational Resources

- **1-hour Comprehensive Lecture**: Overview of techniques and applications
- **Professional Courses**: Advanced prompt engineering and AI agent building
- **Corporate Training**: Tailored consulting and workshops
- **Multilingual Support**: Available in 13+ languages

## Key Applications

- Question answering and information retrieval
- Arithmetic and logical reasoning
- Text summarization and generation
- Code generation and debugging
- Safety improvements for LLMs
- Domain knowledge augmentation
- External tool integration

## Research Foundation

The guide is backed by extensive research including:

- Prompt injection threat analysis
- Prompt pattern catalogs
- Directional stimulus prompting studies
- Universal prompt retrieval methods
- Chain of thought optimization research

---

_Source: PromptingGuide.ai - A comprehensive prompt engineering resource by
DAIR.AI_

