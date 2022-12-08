#!/bin/bash

SESSION_ID=$(jq --null-input \
    '{username:$ENV.METABASE_USER, password:$ENV.METABASE_PASSWORD}' |
  curl                                      \
  --data "@-"                               \
  --header "Content-Type: application/json" \
  --header "Accept: application/json"       \
  --silent                                  \
  "https://$METABASE_HOST/api/session" | jq --raw-output '.id')

curl                                           \
  --header "Accept: application/json"          \
  --header "X-Metabase-Session: ${SESSION_ID}" \
  --silent                                     \
  "https://$METABASE_HOST/api/session/properties" | jq --compact-output '{type: "software_version", software: "metabase", version: .version.tag, available_version: ."version-info".latest.version}'
