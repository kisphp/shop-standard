#!/bin/bash

PHP=`which php`
COMPOSER=`which composer`
NPM=`which npm`
PHPUNIT=`which phpunit`

ERROR=`tput setab 1` # background red
GREEN=`tput setab 2` # background green
BACKGROUND=`tput setab 4` # background blue
INFO=`tput setaf 3` # yellow text
BLACKTEXT=`tput setaf 0`
COLOR=`tput setaf 7` # text white
NC=`tput sgr0` # reset


function labelText {
    echo -e "\n${BACKGROUND}${COLOR}-> ${1} ${NC}\n"
}

function errorText {
    echo -e "\n${ERROR}${COLOR}=> ${1} <=${NC}\n"
}

function infoText {
    echo -e "\n${INFO}=> ${1} <=${NC}\n"
}

function successText {
    echo -e "\n${GREEN}${BLACKTEXT}=> ${1} <=${NC}\n"
}

function writeErrorMessage {
    if [[ $? != 0 ]]; then
        errorText "${1}"
    fi
}

if [[ `echo "$@" | grep 'test'` ]]; then
    ENVIRONMENT='test'
fi
if [[ `echo "$@" | grep 'dev'` ]]; then
    ENVIRONMENT='dev'
fi
if [[ `echo "$@" | grep 'prod'` ]]; then
    ENVIRONMENT='prod'
fi

if [[ -z $ENVIRONMENT ]]; then
    errorText "You need to specify the environment: 'prod', 'dev', 'test'"
    exit 1
fi

export SYMFONY_ENV=$ENVIRONMENT

if [[ ! -f "./web/index.php" ]]; then
    echo "<?php" > ./web/index.php
    echo " " >> ./web/index.php
    echo "require_once __DIR__ . '/../app/web/app_$ENVIRONMENT.php';" >> ./web/index.php
    echo " " >> ./web/index.php
fi

labelText "Setup environment: $ENVIRONMENT"

if [[ "$ENVIRONMENT" != "prod" ]]; then
    labelText "Install composer dependencies"
    $COMPOSER install --prefer-dist

    labelText "Remove dev cache"
    rm -rf app/cache/dev
    if [[ -d "app/cache/de_" ]]; then
        rm -rf app/cache/de_
    fi

    labelText "Remove test cache"
    rm -rf app/cache/test
#    if [[ -d "app/cache/de_" ]]; then
#        rm -rf app/cache/de_
#    fi
else
    labelText "Install composer dependencies, optimize autoloader"
    $COMPOSER install --no-dev --prefer-dist -o -a
    writeErrorMessage "Composer is not installed"
fi

#labelText "Run setup:install"
#$PHP $PWD/app/console setup:install

#labelText "Run npm install"
#$NPM install

if [[ $ENVIRONMENT != "prod" ]]; then
    $PHPUNIT -c app/
    writeErrorMessage "phpunit is not installed"
else
    infoText "Not development, no tests run"
fi

successText "Setup finished"

exit 0
