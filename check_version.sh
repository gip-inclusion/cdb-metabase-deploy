#!/bin/bash

CURRENT_VERSION=$(curl                            \
  --header "Accept: application/json"             \
  --silent                                        \
  "https://$METABASE_HOST/api/session/properties" \
  | jq --raw-output '.version.tag')

NEXT_VERSION=$(curl                              \
  --header "Accept: application/json"            \
  --silent                                       \
  "http://static.metabase.com/version-info.json" \
  | jq --raw-output '.latest.version')

jq --null-input                            \
   --arg version "$CURRENT_VERSION"        \
   --arg available_version "$NEXT_VERSION" \
   '{type: "software_version", software: "metabase", $version, $available_version}'
