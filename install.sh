
sudo --reset-timestamp

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install tmux git -y
sudo apt-get install python-pip openssh-server -y


./setup/install-vim.sh
./setup/setup-git.sh
./setup/setup-keys.sh



