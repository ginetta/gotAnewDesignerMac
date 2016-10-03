#!/usr/bin/env bash

# logging
function notify() { echo -e "\n\033[1m$@\033[0m"; }

# Set the Application folder to the User
export HOMEBREW_CASK_OPTS="--appdir=~/Applications"

notify 'Welcome to ginetta, this script will install the Apps you need'
notify 'in order to be up and running as quickly as possible'

# checks if apple ID was used as argument, if not ask for it
if [ $# -eq 0 ]
  then
    notify ' Enter your AppleID followed by [ENTER]:'
    read APPLEID
else
    APPLEID=$1
fi

# install homebrew
if [[ ! "$(type -P brew)" ]]; then
    notify '🌶 Installing homebrew'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
fi

# installs bundle Bundle
brew tap Homebrew/bundle
brew install mas

notify '🍎 Signing in with your appleID'
mas signin $APPLEID

notify '❗ next time you are asked for you password, enter you system passowrd'
notify '❗ NOT the apple store password:'

# restore installed apps
brew bundle

notify '✅ Making sure you are using the latest node'
n latest

notify '💪 Updates NPM'
npm update -g npm

# install NPM stuff
notify '🍉 Installing global node modules'
#node stuff
npm_globals=(
  gulp-cli
)

for npmglobal in "${npm_globals[@]}"
do
  npm install -g ${npmglobal};
done

notify '✅ Everything should be installed by now'
notify 'enjoy your freshly installed MAC  @ ginetta'
