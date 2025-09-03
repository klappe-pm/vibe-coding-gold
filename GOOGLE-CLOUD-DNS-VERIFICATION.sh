#!/bin/bash
# Google Cloud DNS Verification Script for vibecoding.gold

echo "🔍 Google Cloud DNS Verification for vibecoding.gold"
echo "==================================================="
echo

echo "1. Testing nameserver delegation..."
dig +short NS vibecoding.gold
echo

echo "2. Querying Google nameservers directly..."
echo "ns-cloud-a1.googledomains.com:"
dig @ns-cloud-a1.googledomains.com vibecoding.gold A +short
echo

echo "ns-cloud-a2.googledomains.com:"
dig @ns-cloud-a2.googledomains.com vibecoding.gold A +short
echo

echo "3. Testing global DNS resolution..."
echo "Local resolver:"
dig +short vibecoding.gold
echo

echo "Google DNS (8.8.8.8):"
dig @8.8.8.8 +short vibecoding.gold
echo

echo "4. Testing HTTPS connectivity..."
curl -I -s --connect-timeout 10 https://vibecoding.gold | head -1 2>/dev/null || echo "Connection failed"
echo

echo "✅ Success indicators:"
echo "- Nameserver queries return GitHub Pages IPs (185.199.x.x)"
echo "- Global DNS returns same IPs"
echo "- HTTPS shows 200/301/302 response"
echo "- No REFUSED or SERVFAIL errors"
echo

echo "🔧 If still not working:"
echo "- Check Google Cloud Console for zone errors"
echo "- Verify billing is enabled on your project"
echo "- Ensure nameservers are updated in GoDaddy"
echo "- Wait up to 48 hours for full propagation"