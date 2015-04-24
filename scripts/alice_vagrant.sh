# Maybe I should first pass in args for a directory to do the following things in 
# For now, just run this script in the vagrant instance i'm in. 
# install vim and zsh
sudo apt-get update && sudo apt-get install -y vim zsh tmux
# install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh # will need to enter password here
# Put my dotfiles in place
git clone https://github.com/aricearice/my-essentials.git ~/my-essentials
cp -r ~/my-essentials/dotfiles/.vim* ~/
cp -r ~/my-essentials/dotfiles/.zshrc ~/
cp -r ~/my-essentials/dotfiles/.tmux.conf ~/
# INstall vim plugins
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Configure git 
git config --global user.name "Alice Yang"
git config --global user.email alice.yang@me.com
git config --global core.editor vim
