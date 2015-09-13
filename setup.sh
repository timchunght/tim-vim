cp .vimrc ~/
# Install vundle, a vim plugin management system
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install all vim plugins
vim +PluginInstall +qall
