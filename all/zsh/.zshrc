# ── Core config ──
source $HOME/.config/zsh/env
source $HOME/.config/zsh/alias
eval "$(starship init zsh)"

# ── Secrets (gitignored) ──
[ -f $HOME/.config/zsh/secrets ] && source $HOME/.config/zsh/secrets

# ── Syntax highlighting ──
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ── fzf ──
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ── Google Cloud SDK ──
if [ -f '/home/laznp/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/laznp/Downloads/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/home/laznp/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/laznp/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# ── Terragrunt ──
export TERRAGRUNT_PROVIDER_CACHE=1

# ── PATH additions ──
export PATH=$PATH:/home/laznp/.kubescape/bin:/home/laznp/.cargo/bin:/opt/rocm/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$HOME/.opencode/bin:$PATH

# ── Completions ──
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
[ -s "/home/laznp/.bun/_bun" ] && source "/home/laznp/.bun/_bun"

# ── Node Version Manager ──
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ── opencode completions ──
_opencode_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "${words[@]}"))
  IFS=$si
  if [[ ${#reply} -gt 0 ]]; then
    _describe 'values' reply
  else
    _default
  fi
}
if [[ "'${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _opencode_yargs_completions "$@"
else
  compdef _opencode_yargs_completions opencode
fi

# ── bun ──
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

