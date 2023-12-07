#!/usr/bin/env bash

aws_sso_to_env() {
   cache_file=$(ls -Art ~/.aws/cli/cache/ | tail -n 1)

   export AWS_ACCESS_KEY_ID=$(cat $cache_file | jq -r '.Credentials.AccessKeyId')
   export AWS_SECRET_ACCESS_KEY=$(cat $cache_file | jq -r '.Credentials.SecretAccessKey')
   export AWS_SESSION_TOKEN=$(cat $cache_file | jq -r '.Credentials.SessionToken')
}

