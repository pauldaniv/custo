#!/usr/bin/env fish

function update
  ~/.custo/install.sh
  source ~/.config/fish/config.fish
end

function version
  set branch (git -C ~/.custo --no-pager branch --show-current)
  switch "$branch"
    case 'develop' fish_vi_key_bindings
      set branch_color "$Purple"
    case 'master'
      set branch_color "$Green"
    case '*'
      set branch_color "$NC"
  end
  set message (git -C ~/.custo --no-pager show -s --format=%s)
  set commit_hash (git -C ~/.custo rev-parse --short HEAD)
  echo -e "$branch_color$branch $Green-> $Black$commit_hash $Blue-> $Green$message$NC"
end
