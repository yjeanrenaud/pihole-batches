#!/bin/bash
# bach script to turn on a remote pi.hole dns blocking function
# needs jq to parse json response (sudo apt update;sudo apt install jq)
# REQUIRES app password (you may find/set that at https://pi.hole/admin/settings/api > Expert > Configure app password. Your regular password would also work, but I won't reccomend using it)
# see:
# https://github.com/yjeanrenaud/pihole-scripts
echo "Authenticating at pi.hole and retrieving SID..."
sid=$(curl -ks -X POST "https://pi.hole:443/api/auth" \
     -H "accept: application/json" \
     -H "content-type: application/json" \
     -d '{"password":"APP-PASSWD"}' | jq -r '.session.sid')
echo "SID retrieved: $sid"
echo "Disabling DNS blocking at pi.hole with timer set to 30..."
curl -ks -X POST "https://pi.hole:443/api/dns/blocking" \
     -H "accept: application/json" \
     -H "sid: $sid" \
     -H "content-type: application/json" \
     -d '{"blocking":true}'
echo "Ending session..."
curl -ks -X DELETE "https://pi.hole:443/api/auth" \
     -H "accept: application/json" \
     -H "sid: $sid" \
     -H "content-type: application/json"
