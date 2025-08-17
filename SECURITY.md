# Security Policy

## Supported Versions

We actively maintain security for the following versions of Vibe Coding Gold:

| Version | Supported          |
| ------- | ------------------ |
| Latest  | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability in Vibe Coding Gold, please report it responsibly:

### How to Report

1. **DO NOT** open a public GitHub issue for security vulnerabilities
2. Email security concerns to: kevin.lappe@gmail.com
3. Include detailed information about the vulnerability
4. Provide steps to reproduce if possible

### What to Include

- **Description**: Clear description of the vulnerability
- **Impact**: Potential impact and severity
- **Reproduction**: Steps to reproduce the issue
- **Environment**: System details (OS, Node.js version, etc.)
- **Proposed Fix**: If you have suggestions for fixing

### Response Timeline

- **Initial Response**: Within 48 hours
- **Investigation**: Within 1 week
- **Fix & Disclosure**: Within 2 weeks (depending on severity)

## Security Measures

### Automated Security

- **Snyk Scanning**: Daily vulnerability scans
- **NPM Audit**: Dependency security auditing
- **Dependency Review**: PR-based dependency analysis
- **GitHub Security Advisories**: Automated vulnerability alerts

### Development Security

- **Dependencies**: Regular updates and security patches
- **Code Review**: All changes reviewed before merging
- **Static Analysis**: Automated security scanning in CI/CD
- **Least Privilege**: Minimal required permissions

### Deployment Security

- **HTTPS**: Enforced for all connections
- **CSP Headers**: Content Security Policy implementation
- **Dependency Integrity**: Verified package checksums
- **Automated Updates**: Security patches applied automatically

## Security Best Practices

### For Contributors

1. Keep dependencies up to date
2. Follow secure coding practices
3. Never commit secrets or API keys
4. Use strong authentication (2FA enabled)
5. Report suspicious activity immediately

### For Users

1. Use HTTPS when accessing the site
2. Keep your browser updated
3. Report any suspicious behavior
4. Don't trust code examples for production use (they're satirical!)

## Vulnerability Disclosure

Once a security vulnerability is fixed:

1. **Private Disclosure**: Reported vulnerability details are shared privately
2. **Fix Deployment**: Security patch is deployed immediately
3. **Public Disclosure**: Details are made public after fix is deployed
4. **Credit**: Reporter receives appropriate credit (if desired)

## Contact

For security-related questions or concerns:
- **Email**: kevin.lappe@gmail.com  
- **GitHub**: @klappe-pm
- **Website**: https://vibecoding.gold

---

*This security policy applies to the Vibe Coding Gold project and associated infrastructure.*