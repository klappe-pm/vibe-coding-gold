# Vibe Coding Gold 🌟

**Where AI Absurdity Meets Working Code** - The internet's premier collection of hilariously over-engineered LLM solutions that actually work!

## What is Vibe Coding Gold?

Vibe Coding Gold showcases the most absurd, over-complicated AI-generated solutions to simple problems. We educate through humor by demonstrating ridiculously complex solutions to trivial tasks - solutions that are technically correct but wonderfully ridiculous.

### 🎯 Our Mission
- **Satirical Education**: Learn automation concepts through laughter
- **Actually Functional**: Every solution works (no matter how absurd)
- **LLM Showcase**: Real outputs from AI gone wonderfully wrong
- **Over-Engineering**: Why simple when you can be enterprise-ready?

## 🏗️ Featured Absurd Solutions

- **[Enterprise Light Switch Solution](https://vibecoding.gold/enterprise-light-switch-solution)** - 500 lines to turn on a bulb
- **[Blockchain TODO List](https://vibecoding.gold/blockchain-todo-list)** - Smart contracts for task management  
- **[Quantum FizzBuzz](https://vibecoding.gold/quantum-fizzbuzz)** - Superposition-based algorithms
- **[Enterprise Hello World](https://vibecoding.gold/enterprise-hello-world)** - Industrial-grade greetings

## 🚀 Visit the Site

**Live Site**: [vibecoding.gold](https://vibecoding.gold)

## 🛠️ Technical Stack

- **Framework**: Quartz v4.5.1 (static site generator)
- **Theme**: Custom golden theme (#FFCB05) 
- **Content**: Obsidian-flavored Markdown
- **Deployment**: GitHub Pages with custom domain
- **Build**: Node.js 22+ with automated CI/CD

## 🎨 Project Philosophy

> "Why use 1 line when 500 will do?" - Vibe Coding Gold

Every piece of content follows our golden standards:
- ✅ **Actually Functional** - All code is tested and works
- ✅ **Ridiculously Over-Engineered** - Maximum complexity for minimum tasks
- ✅ **Educational Through Humor** - Learn by seeing what NOT to do  
- ✅ **LLM-Generated** - Real AI outputs with educational commentary

## 📁 Project Structure

```
/
├── content/                  # Satirical posts and guides
│   ├── posts/               # Individual satirical solutions  
│   └── index.md             # Homepage content
├── quartz/                   # Quartz configuration and generated files
│   ├── quartz.config.ts     # Main Quartz configuration
│   └── static/              # Static assets (images, CNAME, etc.)
├── .github/workflows/        # Automated CI/CD
│   ├── deploy.yml           # GitHub Pages deployment
│   ├── security-scan.yml    # Security vulnerability scanning
│   └── pull_request_template.md # PR template for contributors
├── docs/                     # Quartz documentation
├── public/                   # Generated site (ignored by git)
├── package.json              # Node.js dependencies and scripts
├── .nvmrc                    # Node.js version specification (22)
├── .gitignore               # Git ignore patterns
├── CONTRIBUTING.md          # Contributor guidelines
├── SECURITY.md              # Security policies
└── LICENSE.txt              # MIT License
```

## 🔧 Development

### Prerequisites

- **Node.js 22+**: Required for Quartz v4.5.1
- **npm 10+**: Comes with Node.js 22+
- **Git**: Version control

### Quick Start

```bash
# Clone the repository
git clone https://github.com/klappe-pm/vibe-coding-gold.git
cd vibe-coding-gold

# Use specified Node.js version (optional but recommended)
nvm use  # reads from .nvmrc

# Install dependencies
npm ci

# Build the site
npx quartz build

# Start local development server
npx quartz build --serve
# Site available at http://localhost:8080
```

### Development Workflow

```bash
# Create feature branch for new content
git checkout -b feature/add-quantum-toast

# Add your absurd solution in content/
# Remember: add publish: true to frontmatter

# Test locally
npx quartz build --serve

# Commit and push
git add .
git commit -m "Add Quantum Toast Algorithm: 500 lines of superposition"
git push origin feature/add-quantum-toast

# Create pull request on GitHub
```

### Troubleshooting

**Build fails with "Node version not supported"**:
- Install Node.js 22+ or use `nvm install 22 && nvm use 22`

**Local server won't start**:
- Clear cache: `rm -rf .quartz-cache public`
- Reinstall: `rm -rf node_modules && npm ci`

**Content not appearing**:
- Check frontmatter includes `publish: true`
- Verify markdown syntax with `npx quartz build` output

**Deploy fails**:
- Automatic deployment on push to main
- Check GitHub Actions tab for build logs

## 🤝 Contributing

Have an absurdly over-engineered solution? We'd love to see it! 

1. Fork the repository
2. Create your satirical content in `/content/`
3. Add `publish: true` to frontmatter
4. Submit a pull request

## 📄 License

Licensed under the MIT License - see [LICENSE.txt](LICENSE.txt) for details.

## 🌟 Credits

- **Built with**: [Quartz](https://quartz.jzhao.xyz/) by [Jack Zhao](https://jzhao.xyz/)
- **Hosted on**: GitHub Pages
- **Domain**: GoDaddy
- **AI Assistant**: Claude Code by Anthropic

---

*Vibe Coding Gold - Where Knowledge Meets Puzzled Frustration* ✨
