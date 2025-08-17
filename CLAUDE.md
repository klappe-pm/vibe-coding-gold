# CLAUDE.md - AI Assistant Instructions for Vibe Coding Gold

# 🚨🚨🚨 CRITICAL - READ FIRST 🚨🚨🚨

## ⚠️ MANDATORY: BEFORE DOING ANYTHING, YOU MUST READ AND FOLLOW: ⚠️
## 👉 [`CLAUDE-DON'T FUCKING BREAK THESE RULES.md`](./CLAUDE-DON'T%20FUCKING%20BREAK%20THESE%20RULES.md) 👈

**THE ABOVE FILE CONTAINS IMMUTABLE RULES THAT MUST BE FOLLOWED WITHOUT EXCEPTION.**
**FAILURE TO FOLLOW THESE RULES WILL RESULT IN DATA LOSS AND PROJECT DAMAGE.**

### QUICK SUMMARY OF CRITICAL RULES:
1. **NEVER** move folders without explicit permission
2. **NEVER** delete, archive, or backup anything without explicit permission
3. **ALWAYS** ask before assuming user intent
4. **DO NOT** perform unrequested tasks
5. **ALWAYS** evaluate and select the correct persona for every request

**READ THE FULL RULES FILE NOW BEFORE PROCEEDING WITH ANY OPERATIONS.**

---

**IMPORTANT: Update this file with each commit to maintain accurate project context**

## Project Identity

**Vibe Coding Gold** is a satirical platform showcasing absurd, over-engineered LLM-generated code that actually works. We educate through humor by demonstrating ridiculously complex solutions to simple problems.

### Core Concept
- **What We Do**: Show hilariously over-complicated AI solutions that function
- **Why**: To teach automation concepts through laughter
- **How**: Absurd but working code examples with educational explanations

## Current Project State (Last Updated: August 16, 2025)

### ✅ Completed
- Project vision defined as satirical LLM content platform
- Removed unrelated Claudia and agents subprojects  
- Created first example: Enterprise Light Switch (500 lines)
- Updated all documentation to reflect satirical vision
- Cleaned project structure and archived old content

### 🚧 In Progress
- Creating more absurd LLM examples
- Setting up GitHub Pages deployment
- Configuring DNS at GoDaddy

### 📋 Next Actions
1. Create 4-5 more absurd examples
2. Configure DNS and enable GitHub Pages
3. Test deployment pipeline
4. Build content submission system

## Content Guidelines

### What Makes Good Vibe Coding Gold Content

1. **Absurdly Over-Engineered**: Simple task, complex solution
2. **Actually Functional**: The code must work, no matter how ridiculous
3. **Educational Value**: Demonstrates real patterns/concepts (badly)
4. **Humor Through Truth**: Funny because it's technically correct

### Content Structure

```markdown
---
publish: true
title: [Ridiculous Solution Name]
categories: ["Guides"]
subCategories: ["Absurd Solutions"]
tags: [absurd, over-engineered, working-code]
---

# [Title]

## The Problem
[One line description of simple task]

## The Solution  
[Brief description of absurd approach]

## Complete Working Code
[500+ lines of over-engineered code]

## Why This Is Educational
[Explain real concepts demonstrated]

## The Lesson
[What developers should actually do]
```

## File Structure

```
/
├── content/              # All absurd examples and guides
│   ├── guides/          # Over-engineered tutorials
│   ├── concepts/        # LLM concepts for humans
│   ├── references/      # Resources and links
│   └── index.md         # Homepage
├── quartz/              # Static site generator (don't modify)
├── scripts/             # Utility scripts
├── archive/             # Old content (ignore)
├── PROJECT-VISION.md    # Project identity (read this!)
├── PROJECT-STATUS.md    # Current status
├── tasks.md            # Task tracking
├── CLAUDE.md           # THIS FILE - UPDATE OFTEN
└── README.md           # Public project description
```

## Technical Details

### Stack
- **Site Generator**: Quartz v4
- **Content**: Obsidian markdown files
- **Theme**: Golden (#FFCB05) with cosmic black
- **Deployment**: GitHub Pages via Actions
- **Domain**: vibecoding.gold

### Publishing
- Add `publish: true` to frontmatter for public content
- Push to GitHub triggers automatic deployment
- Site builds to `quartz/public/`

## Development Commands

```bash
# Local development
cd quartz && npx quartz build --serve

# Build for production
cd quartz && npm run build

# Create new content
# 1. Create .md file in content/guides/
# 2. Add frontmatter with publish: true
# 3. Write absurd but working code
```

## Content Ideas Queue

### High Priority
1. **Blockchain Sock Sorter** - Smart contracts for laundry
2. **Quantum Toast Algorithm** - Superposition for perfect browning
3. **AI Hello World** - ML model trained to output "Hello World"

### Medium Priority
1. **Microservices FizzBuzz** - Distributed architecture for a loop
2. **Database Connection Enterprise** - 1000 lines to connect
3. **TODO App Ultimate** - With Kubernetes and AI

### Low Priority
1. **Recursive Fibonacci Blockchain** - Each number is a block
2. **Email Validator AI** - 2MB regex from GPT
3. **Hello World as a Service** - HWaaS architecture

## Style Guide

### Tone
- **Satirical but Educational**: Mock over-engineering while teaching
- **Technically Accurate**: Bad practices executed perfectly
- **Self-Aware**: We know it's ridiculous, that's the point

### Code Style
- Use excessive design patterns
- Add unnecessary abstractions
- Include "enterprise" features (audit trails, blockchain, etc.)
- Comment extensively to explain the absurdity

### Writing Style
- Professional technical writing style
- Deadpan delivery of absurd concepts
- Educational explanations of what's wrong
- Always provide the simple alternative

## Common Patterns to Satirize

1. **Over-Architecture**
   - Microservices for simple functions
   - Unnecessary design patterns
   - Excessive abstraction layers

2. **Buzzword Abuse**
   - Blockchain for everything
   - AI/ML for trivial tasks
   - Quantum computing references

3. **Enterprise Syndrome**
   - Configuration files for constants
   - Audit trails for everything
   - Permission systems for single-user apps

## Git Workflow

```bash
# Before starting work
git pull origin main

# After creating content
git add .
git commit -m "Add [absurd example name]"

# Update CLAUDE.md with changes
git add CLAUDE.md
git commit -m "Update CLAUDE.md with latest changes"

git push origin main
```

## Important Notes

### What to Remember
1. **Vision**: Satirical LLM content, not serious documentation
2. **Quality**: Code must actually work despite being absurd
3. **Education**: Always explain the real concepts being mocked
4. **Update**: Keep CLAUDE.md current with each session

### What to Avoid
1. Don't create serious, practical tutorials
2. Don't write broken code (it must work!)
3. Don't forget the educational aspect
4. Don't be mean-spirited - we're laughing with, not at

## Project Mantras

- "Why use 1 line when 500 will do?"
- "It's not over-engineered, it's enterprise-ready!"
- "The best way to learn is to see what NOT to do"
- "If it's worth doing, it's worth over-doing"

## Recent Changes Log

### August 17, 2025 - Session 1
- **MAJOR**: Fixed critical project problems identified in comprehensive analysis
- **CRITICAL**: Moved Enterprise Light Switch from trash to published content (content/guides/)
- **HIGH**: Completely rewrote README.md to reflect actual satirical project vision
- **STRATEGIC**: Created comprehensive architectural documentation (user flows, system maps, entity relationships)
- **PROCESS**: Added MODEL-USAGE.md with mandatory model logging requirement
- Added Rule #5 to CLAUDE-DON'T FUCKING BREAK THESE RULES.md
- Implemented mandatory persona evaluation process for all requests
- Updated implementation checklist to include persona evaluation
- Cross-referenced PERSONAS.md for available personas and sub-agents

### August 17, 2025 - Session 2
- **DOCUMENTATION**: Completed comprehensive project file and folder review
- **CONSISTENCY**: Fixed inconsistencies between duplicate files (quartz/content vs root content)
- **STATUS**: Updated tasks.md to reflect actual completed work status
- **COMPLIANCE**: Logged model usage discrepancy (violated rule: should use mistral for documentation)
- **CLEANUP**: Removed outdated mcp-dependencies/ folder with duplicate framework files
- **VALIDATION**: Ensured all core documents reflect current satirical vision
- **FRAMEWORK**: Established model selection compliance in MODEL-USAGE.md

### August 16, 2025
- Pivoted from serious platform to satirical LLM content
- Created Enterprise Light Switch example
- Removed Claudia and agents subprojects
- Updated all documentation for new vision
- Created this CLAUDE.md file

### Next Session TODOs
- [ ] Design detailed frontend design system in design folder (user requested)
- [ ] Create Blockchain Sock Sorter example
- [ ] Write "Why Your Light Switch Needs a Blockchain" guide
- [ ] Test publishing pipeline
- [ ] Configure DNS settings

---

**Remember: Update this file with each commit to maintain context!**

*Last Updated: August 17, 2025 by Claude*
*Project Status: All documents consistent, ready for CI/CD and content creation*
