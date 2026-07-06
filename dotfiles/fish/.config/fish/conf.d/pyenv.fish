if status is-interactive
    if command -v pyenv >/dev/null
        pyenv init - fish | source
    end
end
