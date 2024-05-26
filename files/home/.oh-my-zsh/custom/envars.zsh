source "${HOME}/.cargo/env"

export GOPATH="${HOME}/go"
export BUN_INSTALL="${HOME}/.bun"
export VOLTA_HOME="${HOME}/.volta"

PATH="${PATH}:${HOME}/.local/bin"
PATH="${PATH}:${HOME}/.config/composer/vendor/bin"
PATH="${PATH}:${GOPATH}/bin"
PATH="${PATH}:${BUN_INSTALL}/bin"
PATH="${PATH}:${VOLTA_HOME}/bin"
export PATH

export DOCKER_HOST="unix:///run/user/1000/docker.sock"
export VOLTA_FEATURE_PNPM=1
