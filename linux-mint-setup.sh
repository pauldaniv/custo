#!/usr/bin/env sh

function setupGpgSshAuth() {
  # just going to leave hardcoded key id for now
  gpg --export-ssh-key 69B9DCD16B3B72328E65D4FF9B89AB834D9D68ED >.ssh/id_rsa.pub

  tee -a ~/.gnupg/gpg-agent.conf <<EOF
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
EOF

  tee -a ~/.zshrc <<EOF
enable-ssh-support
default-cache-ttl 60
max-cache-ttl 120
EOF
}

setupGpgSshAuth

source ~/.zshrc
echo Done!