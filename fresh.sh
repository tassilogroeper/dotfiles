#!/bin/sh

echo "Setting up your Mac..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $HOME/.dotfiles/Brewfile

# Set default MySQL root password and auth type
# mysql -u root -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'password'; FLUSH PRIVILEGES;"

# Install PHP extensions with PECL
# pecl install imagick swoole

# Install global Composer packages
# /usr/local/bin/composer global require laravel/installer laravel/valet spatie/visit

# Install Laravel Valet
# $HOME/.composer/vendor/bin/valet install

# Create a Screenshot directory
mkdir $HOME/Screenshots

# Create a Sites directory
mkdir $HOME/Sites

echo 'Git setup'
echo '------------'
# Set user name
git config --global user.name "Tassilo Gröper"

# Set vim as default editor
git config --global core.editor "nano"

# Activate rebase on pull
git config --global pull.rebase true

# Create a new upstream branch for your local branch automatically if it doesn't exist yet
git config --global push.autoSetupRemote true

# Clone Github repositories
# $HOME/.dotfiles/clone.sh

# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source $HOME/.dotfiles/.macos
