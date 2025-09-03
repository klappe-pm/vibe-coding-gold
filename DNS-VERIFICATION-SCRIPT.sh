#!/bin/bash
# DNS Verification Script for vibecoding.gold
# Run this script after configuring A records in Google Cloud DNS

echo "🔍 DNS Verification for vibecoding.gold"
echo "========================================"
echo

echo "1. Checking A record resolution..."
dig +short vibecoding.gold
echo

echo "2. Checking specific DNS servers..."
echo "Google DNS (8.8.8.8):"
dig @8.8.8.8 +short vibecoding.gold
echo

echo "Cloudflare DNS (1.1.1.1):"
dig @1.1.1.1 +short vibecoding.gold
echo

echo "3. Testing HTTPS connectivity..."
curl -I -s --connect-timeout 10 https://vibecoding.gold | head -1
echo

echo "4. GitHub Pages IP addresses (expected):"
echo "185.199.108.153"
echo "185.199.109.153" 
echo "185.199.110.153"
echo "185.199.111.153"
echo

echo "✅ Success indicators:"
echo "- dig commands return GitHub Pages IPs"
echo "- curl shows HTTP 200 or 301/302 redirect"
echo "- No SERVFAIL errors"
echo
echo "⏱️  Allow 5-15 minutes for DNS propagation"
echo "🌐 Check global propagation: whatsmydns.net/vibecoding.gold"