#!/bin/bash

PHP=`which php`
COMPOSER=`which composer`
NPM=`which npm`
PHPUNIT=`which phpunit`

if [[ "dev" == "$1" ]]; then
    export SYMFONY_ENV=dev
else
    export SYMFONY_ENV=prod
fi

ERROR="\e[41m" # background red
GREEN="\e[42m" # background green
INFO="\e[43m" # yellow text
BACKGROUND="\e[44m" # background blue
BLACKTEXT="\e[30m"
COLOR="\e[39m" # text white
NC="\e[0m" # reset

function labelText {
    echo -e "\n${BACKGROUND}${COLOR} ${1} ${NC}\n"
}

function errorText {
    echo -e "\n${ERROR}${COLOR} ${1} ${NC}\n"
}

function infoText {
    echo -e "\n${INFO}${BLACKTEXT} ${1} ${NC}\n"
}

function successText {
    echo -e "\n${GREEN}${BLACKTEXT} ${1} ${NC}\n"
}

function writeErrorMessage {
    if [[ $? != 0 ]]; then
        errorText "${1}"
        exit 1
    fi
}

if [[ `echo "$@" | grep '\-r'` ]]; then
    labelText "remove bower directory"
    rm -rf ./bower
    labelText "remove node_modules directory"
    rm -rf ./node_modules
    labelText "remove vendor directory"
    rm -rf ./vendor
    labelText "remove web/bundles directory"
    rm -rf ./web/bundles
    labelText "remove web/css directory"
    rm -rf ./web/css
    labelText "remove web/js directory"
    rm -rf ./web/js
fi

if [[ "dev" == "$1" ]]; then
    labelText "Development run"
    $COMPOSER install

    labelText "Copy dev index file"
    cp ./app/web/app_dev.php ./web/index.php
else
    labelText "PRODUCTION optimize autoloader"
    $COMPOSER install --no-dev -o -a

    labelText "Copy prod index file"
    cp ./app/web/app_prod.php ./web/index.php
fi

labelText "Copy .htaccess file"
cp ./app/web/.htaccess ./web/.htaccess

echo " " >> ./web/index.php
echo "// DO NOT EDIT THIS FILE. WILL BE REWRITTEN AT EVERY RELEASE !!!\n" >> ./web/index.php

#labelText "Run setup:install"
#$PHP $PWD/app/console setup:install

labelText "Run assets:install"
$PHP $PWD/bin/console assets:install

labelText "Remove cache files"
find var/cache/* -maxdepth 0 -type d | xargs rm -rf

labelText "Run npm install"
$NPM install

if [[ "dev" == "$1" ]]; then
    #$PHPUNIT -c app/
    echo "phpunit"
else
    infoText "Not development, no tests run"
fi

successText "Setup finished"

exit 0
