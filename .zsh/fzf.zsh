function ghq-fzf() {
  local selected_dir=$(ghq list | fzf --query="$LBUFFER")

  if [ -n "$selected_dir" ]; then
    BUFFER="cd $(ghq root)/${selected_dir}"
    zle accept-line
  fi

  zle reset-prompt
}

zle -N ghq-fzf
bindkey "^]" ghq-fzf

function fzf-src-remote () {
  local selected_repo=$(ghq list -p | fzf --query "$LBUFFER" | rev | cut -d "/" -f -2 | rev)
  echo $selected_repo
  if [ -n "$selected_repo" ]; then
    BUFFER="hub browse ${selected_repo}"
    # fzfで選択中, Enter を押した瞬間に実行する
    zle accept-line
  fi
  zle clear-screen
}

zle -N fzf-src-remote
bindkey '^^' fzf-src-remote
