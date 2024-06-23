export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

set -o vi 
set -o noclobber

plugins=(
    git
    jq
    zsh-autosuggestions
)

if command -v kubecolor >/dev/null; then 
    alias k="kubecolor"
    alias ksudo="kubecolor --as=nobody --as-group=core-operators --as-group=system:authenticated"
else 
    alias k="kubectl"
    alias ksudo="kubectl --as=nobody --as-group=core-operators --as-group=system:authenticated"
fi

alias vim="nvim"
alias ctx="kubie ctx"
alias ns="kubie ns"
alias sha256sum="shasum -a 256"
alias ls="/bin/ls -Fh --color=auto"
alias woolshears-yaml="/usr/local/bin/woolshears-yaml"
alias git amend="git add . ; git commit --amend --reuse-message=HEAD"

. ~/bashUtils/*

eval "$(starship init zsh)"

pwd | grep -q go/src/bitbucket.cfdata.org || cd ~/go/src/bitbucket.cfdata.org/k8s

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/johnwood/Downloads/google-cloud-sdk 2/path.zsh.inc' ]; then . '/Users/johnwood/Downloads/google-cloud-sdk 2/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/johnwood/Downloads/google-cloud-sdk 2/completion.zsh.inc' ]; then . '/Users/johnwood/Downloads/google-cloud-sdk 2/completion.zsh.inc'; fi
