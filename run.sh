#!/bin/bash
set -e;

main() {
    # check if all the required environment variables 
    # are present or not
    check_for_env_variables;

    check_if_heroku_present;

    init_netrc;

}

check_if_heroku_present() {
    info "Checking heroku";
    info "$(heroku --version)";
}

init_netrc() {
    local username="$WERCKER_HEROKU_RELEASE_USER";
    local password="$WERCKER_HEROKU_RELEASE_PASSWORD";
    local netrcFile="$HOME/.netrc";

    {
        echo "machine api.heroku.com"
        echo " login $username"
        echo " password $password"
    } >> "$netrcFile";

    chmod 0600 "$netrcFile";

}

check_for_env_variables() {
    if [ -z "$WERCKER_HEROKU_RELEASE_APP_NAME"]; then
        fail "app-name is missing it is required by heroku-release step";
    fi

    if [ -z "$WERCKER_HEROKU_RELEASE_USER"]; then
        fail "user is missing it is reuired by heroku-release step";
    fi

    if [ -z "$WERCKER_HEROKU_RELEASE_PASSWORD"]; then
        fail "password is missing it is reuired by heroku-release step";
    fi
}

main;
