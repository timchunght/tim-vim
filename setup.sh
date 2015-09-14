# Remove directories
rm -rf ~/.vim/
# Install vundle, a vim plugin management system
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install colour scheme
git clone https://github.com/sickill/vim-monokai
mv vim-monokai/colors ~/.vim/ && rm -rf vim-monokai
cp .vimrc ~/
# Install all vim plugins
vim +PluginInstall +qall
