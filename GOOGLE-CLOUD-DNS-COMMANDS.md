# Google Cloud DNS Commands for vibecoding.gold

## Prerequisites
```bash
# Install Google Cloud CLI if not already installed
# Visit: https://cloud.google.com/sdk/docs/install

# Authenticate
gcloud auth login

# List available projects
gcloud projects list
```

## Find Your DNS Zone
```bash
# List all managed zones
gcloud dns managed-zones list

# Look for zone containing "vibecoding" or similar
# Note the ZONE_NAME for use in commands below
```

## Add GitHub Pages A Records
```bash
# Replace ZONE_NAME with your actual zone name from above
ZONE_NAME="your-zone-name-here"

# Create A record with all 4 GitHub Pages IPs
gcloud dns record-sets create vibecoding.gold. \
    --zone=$ZONE_NAME \
    --type=A \
    --ttl=300 \
    --rrdatas="185.199.108.153,185.199.109.153,185.199.110.153,185.199.111.153"
```

## Add Optional WWW CNAME
```bash
# Add www subdomain CNAME
gcloud dns record-sets create www.vibecoding.gold. \
    --zone=$ZONE_NAME \
    --type=CNAME \
    --ttl=300 \
    --rrdatas="klappe-pm.github.io."
```

## Verify Records
```bash
# List all records in the zone
gcloud dns record-sets list --zone=$ZONE_NAME

# Check specific A record
gcloud dns record-sets list --zone=$ZONE_NAME --name="vibecoding.gold." --type="A"
```

## Troubleshooting Commands
```bash
# Check if you have the right project selected
gcloud config get-value project

# Switch to different project if needed
gcloud config set project PROJECT_ID

# Check permissions
gcloud dns managed-zones list --project=PROJECT_ID
```

## If Zone Doesn't Exist
```bash
# Create new managed zone (if needed)
gcloud dns managed-zones create vibecoding-gold \
    --dns-name="vibecoding.gold." \
    --description="DNS zone for Vibe Coding Gold website"
```

## Expected Timeline
- **Record Creation**: Immediate in Google Cloud
- **DNS Propagation**: 5-15 minutes globally
- **Site Accessibility**: 15-30 minutes
- **HTTPS Certificate**: 1-2 hours via GitHub Pages