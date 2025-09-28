#!/bin/bash

URL=$1  

if [ -z "$URL" ]; then
    echo " <URL> is not given as an argument"
fi

# Use curl to get the HTTP status code
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -L  "$URL")

echo "Checking application: $URL"
echo "HTTP Status Code: $STATUS"

if [[ "$STATUS" -ge 200 && "$STATUS" -lt 400 ]]; then
    echo "Application is UP and functioning properly"
else
    echo "Application is DOWN or not responding"
fi

