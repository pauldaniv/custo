#!/usr/bin/env bash

function aws_sso_to_env
   set cache_file "$HOME/.aws/cli/cache/$(ls -Art ~/.aws/cli/cache/ | tail -n 1)"

   set -x AWS_ACCESS_KEY_ID (cat $cache_file | jq -r '.Credentials.AccessKeyId')
   set -x AWS_SECRET_ACCESS_KEY (cat $cache_file | jq -r '.Credentials.SecretAccessKey')
   set -x AWS_SESSION_TOKEN (cat $cache_file | jq -r '.Credentials.SessionToken')
end

function aws_config_set
    echo "Enter your input (Press Enter on an empty line to stop):"


    echo "Paste the copied AWS credentials content (end with an empty line):"

    set -l profile_name="default"
    set -l aws_access_key_id=""
    set -l aws_secret_access_key=""
    set -l aws_session_token=""

    # Read lines from stdin
    while IFS= read -r line; do
        # Break the loop on an empty line
        if [[ -z "$line" ]]; then
            break
        fi

        # Skip lines starting with '<s-' as they are meant to be ignored
        if [[ "$line" =~ ^\<s- ]]; then
            continue
        fi

        # Detect AWS Access Key ID
        if [[ "$line" =~ ^aws_access_key_id=.*$ ]]; then
            set -l aws_access_key_id (echo "$line" | cut -d '=' -f 2)
            continue
        fi

        # Detect AWS Secret Access Key
        if [[ "$line" =~ ^aws_secret_access_key=.*$ ]]; then
            set -l aws_secret_access_key (echo "$line" | cut -d '=' -f 2)
            continue
        fi

        # Detect AWS Session Token
        if [[ "$line" =~ ^aws_session_token=.*$ ]]; then
            set -l aws_session_token (echo "$line" | cut -d '=' -f 2)
            continue
        fi
    done

    # Validate that required information is gathered
    if [[ -z "$profile_name" || -z "$aws_access_key_id" || -z "$aws_secret_access_key" ]]; then
        echo "Error: Missing required AWS credentials."
        exit 1
    fi

    # Set the AWS credentials using the AWS CLI
    aws configure set aws_access_key_id "$aws_access_key_id" --profile "$profile_name"
    aws configure set aws_secret_access_key "$aws_secret_access_key" --profile "$profile_name"
    aws configure set aws_session_token "$aws_session_token" --profile "$profile_name"

    echo "AWS credentials have been updated for the profile: $profile_name"

    echo "Done reading input."
end
