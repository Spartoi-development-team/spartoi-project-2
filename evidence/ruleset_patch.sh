#!/bin/bash

# Define variables
token='<REPLACE_WITH_CORRECT_TOKEN>'  # Replace with personal access token with `admin:org` and `repo` scopes
owner='shw097'
repo='spartoi-project-2'
branch='main'
ruleset_name='Updated Required Gates Ruleset'
logfile="/workspaces/spartoi-project-2/evidence/ruleset_patch.log"

# API endpoint
api_url="https://api.github.com/repos/$owner/$repo/rulesets"

# Log function
log() {
  echo "$(date -u) $1" | tee -a "$logfile"
}

log "Starting Ruleset Fix Patch..."

# Payload for ruleset
read -r -d '' payload <<EOF
{
  "name": "$ruleset_name",
  "target": "branch",
  "enforcement": "enabled",
  "conditions": {
    "ref_name": {
      "include": ["$branch"]
    }
  },
  "required_status_checks": {
    "strict": true,
    "contexts": ["gates"]
  }
}
EOF

log "Payload: $payload"

# Create ruleset
response=$(curl -s -o response.json -w "%{http_code}" -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $token" -H "Content-Type: application/json" -d "$payload" "$api_url")

# Log response
log "HTTP Status: $response"
log "Response Body: $(cat response.json)"

# Cleanup sensitive data
unset token

# Print the last 200 lines of the log, if any
if [ -f "$logfile" ]; then
  tail -200 "$logfile"
fi
