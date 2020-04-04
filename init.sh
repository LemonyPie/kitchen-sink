sudo apt-get update
sudo apt-get insall -y neovim zsh

mkdir ~/.config/nvim
printf "set runtimepath^=~/.vim runtimepath+=~/.vim/after \nlet &packpath = &runtimepath \nsource ~/.vimrc" > ~/.config/nvim/init.vim
printf "set tabstop=4\nset shiftwidth=4\nset smarttab\nset expandtab\nset smartindent" > ~/.vimrc

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sed -e "s/robbyrussel/spaceship" ~/.zshrc

sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
