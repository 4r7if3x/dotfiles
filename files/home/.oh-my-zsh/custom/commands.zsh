# shellcheck disable=SC2034
msg() {
  local information='\e[1;36m'
  local success='\e[1;32m'
  local warning='\e[1;33m'
  local error='\e[1;31m'
  local reset='\e[0m'
  echo -e "\n${!1}▣ ${2}:${reset}\n"
}

inf() { msg information "${1}"; }
scs() { msg success "${1}"; }
wrn() { msg warning "${1}"; }
err() { msg error "${1}"; }

up() {
  inf 'Updating system packages'
  sudo apt update -y

  inf 'Upgrading system packages'
  sudo apt upgrade -y

  inf 'Updating Snap apps'
  sudo snap refresh

  inf 'Cleanup'
  sudo apt autoremove -y
  sudo apt autoclean -y

  inf 'Updating Rust toolchain'
  rustup self update
  rustup update

  inf 'Updating Go'
  rm -rf /usr/local/go
  LATEST_GO=$(curl -s https://api.github.com/repos/golang/go/git/matching-refs/tags/go | jq -r '.[-1].ref | split("/") | .[2]')
  curl -SL "https://go.dev/dl/${LATEST_GO}.linux-amd64.tar.gz" | sudo tar -xz -C /usr/local

  inf 'updating Poetry'
  poetry self update

  inf 'Updating Foundry toolchain'
  foundryup

  inf 'Updating Node.js packages'
  npm install -g npm@latest
  npm update -g
  pnpm update -g

  inf 'Updating Composer packages'
  composer global update
}
