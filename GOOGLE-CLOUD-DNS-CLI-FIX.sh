#!/bin/bash
# Google Cloud DNS CLI Fix Script for vibecoding.gold
# This script will diagnose and fix your DNS configuration

set -e

echo "🔧 Google Cloud DNS CLI Fix Script"
echo "=================================="
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

DOMAIN="vibecoding.gold"
ZONE_NAME="vibecoding-gold"

# GitHub Pages IP addresses
GITHUB_IPS=(
    "185.199.108.153"
    "185.199.109.153" 
    "185.199.110.153"
    "185.199.111.153"
)

echo "Step 1: Authenticating with Google Cloud..."
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q .; then
    echo -e "${YELLOW}No active authentication found. Please authenticate:${NC}"
    echo "gcloud auth login"
    exit 1
fi
echo -e "${GREEN}✅ Authenticated${NC}"
echo

echo "Step 2: Checking current project..."
PROJECT_ID=$(gcloud config get-value project 2>/dev/null || echo "")
if [ -z "$PROJECT_ID" ]; then
    echo -e "${RED}❌ No project selected.${NC}"
    echo "Available projects:"
    gcloud projects list
    echo
    echo "Set your project:"
    echo "gcloud config set project PROJECT_ID"
    exit 1
fi
echo -e "${GREEN}✅ Using project: $PROJECT_ID${NC}"
echo

echo "Step 3: Checking Cloud DNS API..."
if ! gcloud services list --enabled --filter="name:dns.googleapis.com" --format="value(name)" | grep -q dns.googleapis.com; then
    echo -e "${YELLOW}Enabling Cloud DNS API...${NC}"
    gcloud services enable dns.googleapis.com
    echo -e "${GREEN}✅ Cloud DNS API enabled${NC}"
else
    echo -e "${GREEN}✅ Cloud DNS API is enabled${NC}"
fi
echo

echo "Step 4: Checking for existing DNS zone..."
if gcloud dns managed-zones list --format="value(name)" | grep -q "^${ZONE_NAME}$"; then
    echo -e "${GREEN}✅ Zone '$ZONE_NAME' exists${NC}"
else
    echo -e "${YELLOW}Creating DNS zone '$ZONE_NAME'...${NC}"
    gcloud dns managed-zones create $ZONE_NAME \
        --dns-name="${DOMAIN}." \
        --description="DNS zone for Vibe Coding Gold website"
    echo -e "${GREEN}✅ Zone created${NC}"
fi
echo

echo "Step 5: Getting current nameservers..."
echo "Nameservers for your zone:"
gcloud dns managed-zones describe $ZONE_NAME --format="value(nameServers[].join(' '))"
echo
echo -e "${YELLOW}⚠️  You need to update these nameservers in GoDaddy!${NC}"
echo

echo "Step 6: Checking existing A records..."
if gcloud dns record-sets list --zone=$ZONE_NAME --name="${DOMAIN}." --type=A --format="value(name)" | grep -q .; then
    echo -e "${YELLOW}Existing A record found. Deleting...${NC}"
    # Get current A record data to delete it
    CURRENT_IPS=$(gcloud dns record-sets list --zone=$ZONE_NAME --name="${DOMAIN}." --type=A --format="value(rrdatas[].join(','))" | tr ',' ' ')
    CURRENT_TTL=$(gcloud dns record-sets list --zone=$ZONE_NAME --name="${DOMAIN}." --type=A --format="value(ttl)")
    
    if [ ! -z "$CURRENT_IPS" ]; then
        gcloud dns record-sets delete "${DOMAIN}." --zone=$ZONE_NAME --type=A
        echo -e "${GREEN}✅ Old A record deleted${NC}"
    fi
fi

echo "Step 7: Creating GitHub Pages A records..."
IPS_STRING=$(IFS=','; echo "${GITHUB_IPS[*]}")
gcloud dns record-sets create "${DOMAIN}." \
    --zone=$ZONE_NAME \
    --type=A \
    --ttl=300 \
    --rrdatas="$IPS_STRING"
echo -e "${GREEN}✅ A records created with 300 second TTL${NC}"
echo

echo "Step 8: Checking/Creating WWW CNAME record..."
if gcloud dns record-sets list --zone=$ZONE_NAME --name="www.${DOMAIN}." --type=CNAME --format="value(name)" | grep -q .; then
    echo -e "${YELLOW}Existing WWW CNAME found. Deleting...${NC}"
    gcloud dns record-sets delete "www.${DOMAIN}." --zone=$ZONE_NAME --type=CNAME
fi

echo "Creating WWW CNAME record..."
gcloud dns record-sets create "www.${DOMAIN}." \
    --zone=$ZONE_NAME \
    --type=CNAME \
    --ttl=300 \
    --rrdatas="klappe-pm.github.io."
echo -e "${GREEN}✅ WWW CNAME record created${NC}"
echo

echo "Step 9: Verifying DNS records..."
echo "Current DNS records in zone:"
gcloud dns record-sets list --zone=$ZONE_NAME
echo

echo "Step 10: Testing nameserver response..."
NAMESERVER=$(gcloud dns managed-zones describe $ZONE_NAME --format="value(nameServers[0])")
echo "Testing nameserver: $NAMESERVER"
dig @$NAMESERVER $DOMAIN A +short || echo -e "${RED}❌ Nameserver not responding correctly${NC}"
echo

echo "🎯 NEXT STEPS:"
echo "============="
echo "1. Copy the nameservers shown above"
echo "2. Log into GoDaddy and update nameservers for vibecoding.gold"
echo "3. Wait 15-30 minutes for propagation"
echo "4. Run the verification script: ./GOOGLE-CLOUD-DNS-VERIFICATION.sh"
echo
echo "Nameservers to use in GoDaddy:"
gcloud dns managed-zones describe $ZONE_NAME --format="value(nameServers[].join('\n'))"
echo
echo -e "${GREEN}✅ Google Cloud DNS configuration complete!${NC}"