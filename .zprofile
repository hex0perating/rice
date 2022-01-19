# add user's local bin if exists
if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

# add user's .local/bin if exists
if [ -d $HOME/.local/bin ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# load .zshrc if it exists
if [ -f $HOME/.zshrc ]; then
    source $HOME/.zshrc
fi