#!/usr/bin/env bash

function aws_sso_to_env
   set cache_file "$HOME/.aws/cli/cache/$(ls -Art ~/.aws/cli/cache/ | tail -n 1)"

   set -x AWS_ACCESS_KEY_ID (cat $cache_file | jq -r '.Credentials.AccessKeyId')
   set -x AWS_SECRET_ACCESS_KEY (cat $cache_file | jq -r '.Credentials.SecretAccessKey')
   set -x AWS_SESSION_TOKEN (cat $cache_file | jq -r '.Credentials.SessionToken')
end

