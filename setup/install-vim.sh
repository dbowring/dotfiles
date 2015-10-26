
echo "VIM: installing vim"
sudo apt-get install vim -y

VUNDLE_DIR="${HOME}/.vim/bundle/Vundle.vim"

if [ -d "$VUNDLE_DIR" ]; then
  echo "VIM: Updating Vundle..."
  git --git-dir=$VUNDLE_DIR/.git --work-tree=$VUNDLE_DIR pull
else
  echo "VIM: Downloading Vundle"
  git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
fi


echo "VIM: Writing .vimrc"
cat << EOF > ${HOME}/.vimrc
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

`cat $(dirname $0)/vundle.vimrc`

call vundle#end()

filetype plugin indent on

EOF


echo "VIM: Installing plugins"
vim +PluginInstall +qall


echo "VIM: Updating .vimrc"
cat $(dirname $0)/options.vimrc >> ${HOME}/.vimrc

echo "VIM: You may need to install a compatible font for vim powerline"
echo "VIM: Try https://github.com/powerline/fonts/tree/master/DejaVuSansMono"

