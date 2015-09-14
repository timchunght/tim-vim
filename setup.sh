cp .vimrc ~/

# Remove directories
rm -rf ~/.vim/bundle/*
# Install vundle, a vim plugin management system
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install all vim plugins
vim +PluginInstall +qall
