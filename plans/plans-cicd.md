---
vault:
categories:
subCategories:
topics:
subTopics:
dateCreated: 2025-08-16
dateRevised: 2025-08-16
aliases: []
tags: []
---

# Plans-cicd

## Streamlined Deployment Pipeline

### 🎯 CI/CD Philosophy

**Keep It Simple**: Leverage existing GitHub Actions with minimal complexity. Focus on reliability over features.

**Current State**: Basic deployment pipeline exists but needs refinement and additional stages.

---

## Current CI/CD Analysis

### What's Already Working ✅

```yaml
Existing Pipeline (.github/workflows/deploy.yml):
  Trigger: Push to main branch + manual workflow dispatch
  Environment: Node.js 22, Ubuntu latest
  Process: 
    1. Checkout code
    2. Install Quartz dependencies  
    3. Copy content with rsync
    4. Build static site
    5. Deploy to GitHub Pages
  
Status: ✅ Functional but basic
```

### What's Missing ❌

```yaml
Missing Elements:
  - Content validation before deployment
  - Build caching for faster deploys
  - Preview deployments for pull requests
  - Automated testing (links, accessibility)
  - Deployment notifications
  - Rollback capabilities
  - Performance monitoring
```

---

## Phase C1: Enhanced CI/CD Pipeline (2 hours)

### Hour 1: Pipeline Improvements

#### 1.1 Enhanced Build Process (20 minutes)

```yaml
# .github/workflows/deploy.yml improvements

Current Issues:
  - No caching (slow builds)
  - No content validation
  - No error handling
  - No build artifacts retention

Improvements Needed:
  1. Add dependency caching
  2. Validate content before build
  3. Add proper error handling  
  4. Store build artifacts
  5. Add build notifications
```

```yaml
name: Deploy to vibecoding.gold

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write
  pull-requests: write

concurrency:
  group: "pages-${{ github.ref }}"
  cancel-in-progress: false

jobs:
  # Content validation job
  validate-content:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        
      - name: Validate content structure
        run: |
          # Check for required frontmatter
          find content -name "*.md" -exec grep -L "publish:" {} \; > missing-frontmatter.txt
          if [ -s missing-frontmatter.txt ]; then
            echo "Files missing 'publish:' frontmatter:"
            cat missing-frontmatter.txt
            exit 1
          fi
          
      - name: Check for broken internal links
        run: |
          # Simple markdown link checker
          find content -name "*.md" -exec grep -H "\[\[.*\]\]" {} \; > internal-links.txt
          # Validate internal links exist
          # (Add more sophisticated link checking as needed)
          
      - name: Validate images exist
        run: |
          # Check that referenced images exist
          find content -name "*.md" -exec grep -Ho "!\[.*\](.*)" {} \; | while read line; do
            file=$(echo $line | cut -d: -f1)
            img=$(echo $line | sed 's/.*](\([^)]*\)).*/\1/')
            if [ ! -f "content/$img" ] && [ ! -f "$img" ]; then
              echo "Missing image: $img in file: $file"
            fi
          done

  # Build job
  build:
    runs-on: ubuntu-latest
    needs: validate-content
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '22'
          cache: 'npm'
          cache-dependency-path: 'quartz/package-lock.json'

      - name: Cache Quartz build
        uses: actions/cache@v4
        with:
          path: |
            quartz/.quartz-cache
            quartz/public
          key: quartz-build-${{ hashFiles('content/**/*.md', 'quartz/quartz.config.ts') }}
          restore-keys: |
            quartz-build-

      - name: Install Quartz dependencies
        run: |
          cd quartz
          npm ci

      - name: Copy Obsidian content to Quartz
        run: |
          # Enhanced content copy with validation
          echo "Copying content..."
          rsync -av --exclude='.obsidian' \
                    --exclude='quartz' \
                    --exclude='.github' \
                    --exclude='.git' \
                    --exclude='node_modules' \
                    --exclude='*.git*' \
                    --include='*.md' \
                    --include='*/' \
                    --exclude='*' \
                    ./ quartz/content/
          
          echo "Content copied. Files:"
          find quartz/content -name "*.md" | wc -l

      - name: Build Quartz site
        run: |
          cd quartz
          echo "Building site..."
          npx quartz build
          
          echo "Build complete. Generated files:"
          ls -la public/
          
      - name: Validate build output
        run: |
          cd quartz
          # Check that essential files were generated
          test -f public/index.html || (echo "Missing index.html" && exit 1)
          test -d public/static || (echo "Missing static assets" && exit 1)
          echo "Build validation passed"
          
      - name: Upload artifact for GitHub Pages
        if: github.ref == 'refs/heads/main'
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./quartz/public
          
      - name: Upload preview artifact
        if: github.event_name == 'pull_request'
        uses: actions/upload-artifact@v4
        with:
          name: preview-build
          path: ./quartz/public
          retention-days: 7

  # Deploy to production
  deploy:
    if: github.ref == 'refs/heads/main'
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
        
      - name: Post deployment verification
        run: |
          # Wait for deployment and verify
          sleep 30
          curl -f https://vibecoding.gold/ || echo "Deployment verification failed"
          
  # Notify on completion
  notify:
    if: always()
    runs-on: ubuntu-latest
    needs: [validate-content, build, deploy]
    steps:
      - name: Notify deployment status
        run: |
          if [ "${{ needs.deploy.result }}" == "success" ]; then
            echo "✅ Deployment successful to https://vibecoding.gold"
          else
            echo "❌ Deployment failed"
          fi
```

#### 1.2 Preview Deployments (25 minutes)

```yaml
# .github/workflows/preview.yml
name: Preview Deployment

on:
  pull_request:
    branches: [main]

jobs:
  build-preview:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4
        
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '22'
          cache: 'npm'
          cache-dependency-path: 'quartz/package-lock.json'

      - name: Install dependencies
        run: |
          cd quartz
          npm ci

      - name: Copy content
        run: |
          rsync -av --exclude='.obsidian' \
                    --exclude='quartz' \
                    --exclude='.github' \
                    --exclude='.git' \
                    --exclude='node_modules' \
                    --include='*.md' \
                    --include='*/' \
                    --exclude='*' \
                    ./ quartz/content/

      - name: Build preview
        run: |
          cd quartz
          # Modify config for preview (different base URL)
          sed -i 's/baseUrl: "vibecoding.gold"/baseUrl: "preview-deploy.netlify.app"/' quartz.config.ts
          npx quartz build

      - name: Deploy to Netlify preview
        uses: nwtgck/actions-netlify@v3
        with:
          publish-dir: './quartz/public'
          github-token: ${{ secrets.GITHUB_TOKEN }}
          deploy-message: "Deploy preview for PR #${{ github.event.number }}"
        env:
          NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
          NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}

      - name: Comment preview URL
        uses: actions/github-script@v7
        with:
          script: |
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: '🔍 **Preview deployment**: Your changes are available at: ${{ env.DEPLOY_URL }}'
            })
```

#### 1.3 Quality Checks (15 minutes)

```yaml
# .github/workflows/quality-checks.yml
name: Quality Checks

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  lint-content:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Check markdown formatting
        uses: DavidAnson/markdownlint-action@v1
        with:
          files: 'content/**/*.md'
          config: '.markdownlint.json'
          
      - name: Check spelling
        uses: streetsidesoftware/cspell-action@v6
        with:
          files: 'content/**/*.md'
          config: '.cspell.json'

  accessibility-check:
    runs-on: ubuntu-latest
    needs: [build]
    steps:
      - uses: actions/checkout@v4
      
      - name: Run accessibility tests
        run: |
          npm install -g @axe-core/cli
          axe --dir ./quartz/public --save axe-results.json
          
      - name: Upload accessibility results
        uses: actions/upload-artifact@v4
        with:
          name: accessibility-results
          path: axe-results.json

  performance-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Lighthouse CI
        uses: treosh/lighthouse-ci-action@v12
        with:
          configPath: '.lighthouserc.json'
          uploadArtifacts: true
```

### Hour 2: Monitoring and Maintenance

#### 2.1 Deployment Monitoring (30 minutes)

```yaml
# Monitoring Configuration

# .github/workflows/health-check.yml
name: Health Check

on:
  schedule:
    - cron: '0 */6 * * *'  # Every 6 hours
  workflow_dispatch:

jobs:
  health-check:
    runs-on: ubuntu-latest
    steps:
      - name: Check site availability
        run: |
          if ! curl -f https://vibecoding.gold/; then
            echo "Site is down!"
            exit 1
          fi
          
      - name: Check DNS resolution
        run: |
          nslookup vibecoding.gold
          
      - name: Check SSL certificate
        run: |
          echo | openssl s_client -servername vibecoding.gold -connect vibecoding.gold:443 2>/dev/null | openssl x509 -noout -dates
          
      - name: Performance check
        run: |
          # Simple performance check
          time curl -o /dev/null -s -w "%{time_total}\n" https://vibecoding.gold/
          
      - name: Notify if issues
        if: failure()
        run: |
          echo "Health check failed - site may be down"
          # Add notification logic (Slack, email, etc.)
```

#### 2.2 Automated Maintenance (30 minutes)

```yaml
# .github/workflows/maintenance.yml
name: Automated Maintenance

on:
  schedule:
    - cron: '0 2 * * 0'  # Weekly on Sunday at 2 AM
  workflow_dispatch:

jobs:
  update-dependencies:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Update Quartz dependencies
        run: |
          cd quartz
          npm update
          npm audit fix --force
          
      - name: Create pull request if changes
        uses: peter-evans/create-pull-request@v6
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          commit-message: "chore: update dependencies"
          title: "Automated dependency updates"
          body: "Automated weekly dependency updates"
          branch: automated-updates

  cleanup-artifacts:
    runs-on: ubuntu-latest
    steps:
      - name: Clean old artifacts
        uses: actions/github-script@v7
        with:
          script: |
            const artifacts = await github.rest.actions.listArtifactsForRepo({
              owner: context.repo.owner,
              repo: context.repo.repo,
              per_page: 100
            });
            
            const oldArtifacts = artifacts.data.artifacts.filter(artifact => {
              const age = Date.now() - new Date(artifact.created_at).getTime();
              return age > 7 * 24 * 60 * 60 * 1000; // 7 days
            });
            
            for (const artifact of oldArtifacts) {
              await github.rest.actions.deleteArtifact({
                owner: context.repo.owner,
                repo: context.repo.repo,
                artifact_id: artifact.id
              });
            }
```

---

## Phase C2: Development Workflow (1 hour)

### Development Branch Strategy

```yaml
Branch Strategy (Simple):
  main: Production-ready code
  feature/*: Feature development branches
  hotfix/*: Emergency fixes
  
Workflow:
  1. Create feature branch from main
  2. Make changes, test locally
  3. Create pull request
  4. Automated checks run
  5. Preview deployment created
  6. Manual review and approval
  7. Merge to main
  8. Automatic production deployment
```

### Local Development Setup

```yaml
# scripts/local-dev.sh
#!/bin/bash

echo "🚀 Starting local development environment..."

# Check prerequisites
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is required"
    exit 1
fi

# Install dependencies
cd quartz
npm install

# Copy content
echo "📄 Copying content..."
rsync -av --exclude='.obsidian' \
          --exclude='quartz' \
          --exclude='.github' \
          --exclude='.git' \
          --exclude='node_modules' \
          --include='*.md' \
          --include='*/' \
          --exclude='*' \
          ../ content/

# Start development server
echo "🌟 Starting development server..."
echo "📖 Site will be available at: http://localhost:8080"
npx quartz build --serve
```

### Quality Gates

```yaml
Pre-merge Requirements:
  ✅ All automated checks pass
  ✅ Content validation successful
  ✅ Preview deployment works
  ✅ Manual review approved
  ✅ No merge conflicts

Post-merge Actions:
  ✅ Production deployment successful
  ✅ Health check passes
  ✅ Performance metrics acceptable
  ✅ No 404 errors detected
```

---

## Implementation Timeline

### Week 1: Enhanced Pipeline (2 hours)

```yaml
Day 1 (1 hour):
  - [ ] Implement enhanced build workflow
  - [ ] Add content validation
  - [ ] Set up build caching
  - [ ] Test deployment improvements

Day 2 (1 hour):  
  - [ ] Set up preview deployments
  - [ ] Add quality checks workflow
  - [ ] Configure monitoring
  - [ ] Test complete pipeline
```

### Week 2: Monitoring & Maintenance (1 hour)

```yaml
Day 1 (30 minutes):
  - [ ] Set up health checks
  - [ ] Configure alerts
  - [ ] Test monitoring systems

Day 2 (30 minutes):
  - [ ] Implement automated maintenance
  - [ ] Set up dependency updates
  - [ ] Document procedures
```

---

## Success Metrics

### Performance Targets

```yaml
Build Time: < 2 minutes (with caching)
Deployment Time: < 5 minutes total
Uptime: > 99.9%
Failed Deployments: < 1%
```

### Quality Targets

```yaml
Content Validation: 100% pass rate
Accessibility: No critical issues
Performance: Lighthouse score > 90
Security: No vulnerabilities in dependencies
```

---

*This CI/CD plan provides a robust but simple deployment pipeline that ensures quality and reliability while maintaining fast development velocity.*
