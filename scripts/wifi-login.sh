#!/bin/bash

USERID="25BCE2951"
PASSWORD="Daya12345"

response=$(curl -s -X POST "http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://example.com" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data "userId=$USERID&password=$PASSWORD&serviceName=ProntoAuthentication")

if echo "$response" | grep -q "Access Granted"; then
    echo "✓ WiFi login successful"
    exit 0

elif echo "$response" | grep -qi "check your username"; then
    echo "✗ Invalid credentials"
    exit 1

elif echo "$response" | grep -qi "error"; then
    echo "✗ Login error page returned"
    exit 2

else
    echo "✓ Already logged in or unknown state"
    exit 0
fi
