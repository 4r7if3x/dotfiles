ls() {
  command ls --all --group-directories-first --color=auto --indicator-style=classify --time-style=long-iso "$@"
}

gpg() {
  if [[ "$1" == 'import' && -n "$2" && -n "$3" ]]; then
    command gpg --import "$2"
    command gpg --import "$3"
    KEY_ID=$(command gpg --with-colons --import-options show-only --import "$2" | awk -F: '/fpr/{print $10; exit}')
    echo -e "5\ny\n" | command gpg --command-fd 0 --expert --edit-key "$KEY_ID" trust
  elif [[ "$1" == 'export' ]]; then
    command gpg --export --armor --output gpg-public.key "$2"
    command gpg --export-secret-key --armor --output gpg-private.key "$2"
  else
    command gpg "$@"
  fi
}

git() {
  if [[ "$1" == 'clone' || "$1" == 'init' ]]; then
    command git "$@"
    # FIXME: requires cd to dir post-clone
    command git config --local core.filemode false
  elif [[ "$1" == 'unstage' ]]; then
    command git rm --cached "${@:2}"
  elif [[ "$1" == 'commit' && ! "$2" =~ ^-.* ]]; then
    command git commit --gpg-sign --message "$2"
  else
    command git "$@"
  fi
}

docker() {
  if [[ "$1" == 'compose' && "$2" == 'down' && "$3" == '-v' && -n "$4" ]]; then
    docker compose stop "$4"
    docker compose rm -f "$4"
  elif [[ "$1" == 'cleanup' ]]; then
    # TODO: make this automatic where it's needed
    command docker system prune --all --force
  else
    command docker "$@"
  fi
}
