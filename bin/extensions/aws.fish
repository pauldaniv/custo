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
    while read -l line
        # Break the loop on an empty line
        if test -z "$line"
            break
        end

        # Skip lines starting with '<s-' as they are meant to be ignored
        if string match -r '^<s-' "$line"
            continue
        end

       # Detect AWS Access Key ID
       if string match -r '^aws_access_key_id=.*$' "$line"
           set -l aws_access_key_id (echo "$line" | cut -d '=' -f 2)
           continue
       end

       # Detect AWS Secret Access Key
       if string match -r '^aws_secret_access_key=.*$' "$line"
           set -l aws_secret_access_key (echo "$line" | cut -d '=' -f 2)
           continue
       end

       # Detect AWS Session Token
       if string match -r '^aws_session_token=.*$' "$line"
           set -l aws_session_token (echo "$line" | cut -d '=' -f 2)
           continue
       end
    end

    # Validate that required information is gathered
    if test -z "$profile_name"; or test -z "$aws_access_key_id"; or test -z "$aws_secret_access_key"
        echo "Error: Missing required AWS credentials."
        exit 1
    end


    # Set the AWS credentials using the AWS CLI
    aws configure set aws_access_key_id "$aws_access_key_id" --profile "$profile_name"
    aws configure set aws_secret_access_key "$aws_secret_access_key" --profile "$profile_name"
    aws configure set aws_session_token "$aws_session_token" --profile "$profile_name"

    echo "AWS credentials have been updated for the profile: $profile_name"

    echo "Done reading input."
end
