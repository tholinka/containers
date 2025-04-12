#!/usr/bin/env bash

set -x

set -Eeuo pipefail

# see https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/generating-a-json-web-token-jwt-for-a-github-app

now=$(date +%s)
iat=$((now - 60)) # Issues 60 seconds in the past
exp=$((now + 599)) # Expires 10 minutes in the future, minus 1 second because the api will complain if it's been under a second when we hit it

b64enc() { openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n'; }

header_json='{
    "typ":"JWT",
    "alg":"RS256"
}'
# Header encode
header=$( echo -n "${header_json}" | b64enc )

payload_json="{
    \"iat\":${iat},
    \"exp\":${exp},
    \"iss\":\"${GITHUB_APP_CLIENT_ID}\"
}"
# Payload encode
payload=$( echo -n "${payload_json}" | b64enc )

# Signature
header_payload="${header}"."${payload}"
signature=$(
    openssl dgst -sha256 -sign <(echo -n "${GITHUB_APP_PRIVATE_KEY}") \
    <(echo -n "${header_payload}") | b64enc
)

# Create JWT
APP_JWT="${header_payload}"."${signature}"

# we have an app token, not get an installation token
curl --request POST \
--url "https://api.github.com/app/installations/$GITHUB_APP_INSTALLATION_ID/access_tokens" \
--header "Accept: application/vnd.github+json" \
--header "Authorization: Bearer $APP_JWT" \
--header "X-GitHub-Api-Version: 2022-11-28" | jq  > /out/token

# token expires in 1 hour unless revoked
