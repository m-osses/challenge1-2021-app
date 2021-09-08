# challenge1-2021-app

# Pyenv setup on Ubuntu 20.04

Always updated on [docs](https://github.com/pyenv/pyenv)

### Clone the project:

    $ git clone https://github.com/pyenv/pyenv.git ~/.pyenv

### Define environment variables:

For bash:

    $ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
    $ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
    
For Ubuntu Desktop:

    $ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    $ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc

For Zsh:

    $ echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    $ echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc

### Add pyenv init to shell startup:

For bash:

    $ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
    
For Ubuntu Desktop:

    $ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc
    
For Zsh:

    $ echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc
    
### Install build dependencies [(reference here)](https://github.com/pyenv/pyenv/wiki#suggested-build-environment):

    $ sudo apt-get update; sudo apt-get install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

### Install python version 3.7.8:

    $ pyenv install 3.7.8

### Check previous pointer to python version (default is system):

    $ pyenv global

### Set version 3.7.8 to global version:

    $ pyenv global 3.7.8

This can be checked with:
    
    $ pyenv global
    3.7.8

### Check pip:

    $ which pip
    /home/USER/.pyenv/shims/pip

### Install virtualenv:

    $ pip install virtualenv

Finally, clone project and follow the installation process next described.

# Local Setup

### Create virtualenv

    $ make virtualenv-update

### Install dependencies

    $ make pip-compile pip-sync

### Upgrade existing dependencies

    $ make pip-compile-upgrade pip-sync
