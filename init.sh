# install deps. 
# haveged is required for gpg for fast key generation
sudo apt-get update
sudo apt-get install -y neovim zsh pass haveged rng-tools 

# set up shell
mkdir -p ~/.config/nvim
printf "set runtimepath^=~/.vim runtimepath+=~/.vim/after \nlet &packpath = &runtimepath \nsource ~/.vimrc\n" > ~/.config/nvim/init.vim
printf "set number\nset tabstop=2\nset shiftwidth=2\nset smarttab\nset expandtab\nset smartindent\n" > ~/.vimrc

yes "yes" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sed -i 's/robbyrussell/spaceship/g' ~/.zshrc
chsh -s /usr/bin/zsh

# set up docker and docker-compose
sudo apt-get update
sudo apt-get install -y \
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
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.25.4/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
sudo docker version
sudo docker-compose version

# set up docker registry auth storage
# use same name for gpg2 and for pass init
wget https://github.com/docker/docker-credential-helpers/releases/download/v0.6.3/docker-credential-pass-v0.6.3-amd64.tar.gz && tar -xf docker-credential-pass-v0.6.3-amd64.tar.gz && chmod +x docker-credential-pass && sudo mv docker-credential-pass /usr/local/bin/
gpg2 --gen-key
pass init "rakurs"
sed -i '0,/{/s/{/{\n\t"credsStore": "pass",/' ~/.docker/config.json
