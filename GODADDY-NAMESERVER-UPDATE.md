# GoDaddy Nameserver Update Instructions

## After running the Google Cloud CLI script, use these steps:

### Step 1: Get Your Nameservers
Run this command to get your Google Cloud nameservers:
```bash
gcloud dns managed-zones describe vibecoding-gold --format="value(nameServers[].join('\n'))"
```

### Step 2: Update GoDaddy Nameservers

#### Method 1: GoDaddy Web Interface
1. **Log into GoDaddy**: Go to [sso.godaddy.com](https://sso.godaddy.com)
2. **Navigate to Domains**: My Products → All Products → Domains
3. **Find vibecoding.gold**: Click the domain name
4. **DNS Management**: Click "Manage DNS" or "DNS"
5. **Change Nameservers**:
   - Look for "Nameservers" section (usually at top)
   - Click "Change" or "Edit" next to nameservers
   - Select "Custom" or "I'll use my own nameservers"
   - **Replace all existing nameservers** with the Google Cloud ones
   - Save changes

#### Method 2: GoDaddy CLI (if you have it)
```bash
# Install GoDaddy CLI first
npm install -g @godaddy/godaddy-cli

# Set up authentication (requires API keys)
godaddy login

# Update nameservers (replace with your actual nameservers)
godaddy domain update vibecoding.gold --nameservers ns-cloud-a1.googledomains.com,ns-cloud-a2.googledomains.com,ns-cloud-a3.googledomains.com,ns-cloud-a4.googledomains.com
```

### Step 3: Verify Nameserver Update
Wait 15-30 minutes, then run:
```bash
dig +short NS vibecoding.gold
```

Should return your Google Cloud nameservers.

### Step 4: Test Full Resolution
```bash
./GOOGLE-CLOUD-DNS-VERIFICATION.sh
```

## Timeline
- **Nameserver update**: Immediate in GoDaddy interface
- **DNS propagation**: 15-30 minutes typically
- **Global propagation**: Up to 48 hours (usually much faster)
- **Site accessibility**: Should work within 1 hour