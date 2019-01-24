#!/bin/bash
# Install Dependencies

# Ensure xcode-select is installed
printf "Checking xcode-select installation\\n"
if ! XCODESELECT=$( command -v xcode-select)
then
    printf "\\nXCode must be installed in order to proceed.\\n\\n"
    printf "Exiting now.\\n"
    exit 1
fi

printf "xcode-select installation found @ \\n"
printf "%s \\n\\n" "${XCODESELECT}"

# Ensure Ruby is installed
printf "Checking Ruby installation.\\n"
if ! RUBY=$( command -v ruby)
then
    printf "\\nRuby must be installed in order to proceed.\\n\\n"
    printf "Exiting now.\\n"
    exit 1
fi

printf "Ruby installation found @ \\n"
printf "%s \\n\\n" "${RUBY}"

# Ensure Homebrew is installed
printf "Checking Home Brew installation\\n"
if ! BREW=$( command -v brew )
then
    printf "Homebrew must be installed to continue.\\n\\n"
    printf "Do you wish to install Homebrew?\\n"
    select yn in "Yes" "No"; do
        case "${yn}" in
            [Yy]* )
            "${XCODESELECT}" --install 2>/dev/null;
            if ! "${RUBY}" -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            then
                echo "Unable to install homebrew at this time. Exiting now."
                exit 1;
            else
                BREW=$( command -v brew )
            fi
            break;;
            [Nn]* ) echo "User aborted homebrew installation. Exiting now.";
                    exit 1;;
            * ) echo "Please enter 1 for yes or 2 for no.";;
        esac
    done
fi

# Install jq
brew install jq

# Install Node.js and NPM
brew install node

# Install EOSIO Software
brew tap eosio/eosio && brew install eosio

# Install CDT
brew tap eosio/eosio.cdt && brew install eosio.cdt