
if [ ! -f ~/.ssh/github ]; then
  echo "SSH: github email"
  read email
  ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/github
fi

echo "SSH: GITHUB Public Key"
echo
echo
cat ~/.ssh/github.pub
echo
echo

cat << EOF >> ~/.ssh/config

Host github.com
    HostName github.com
    User git
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/github
    IdentitiesOnly yes

EOF




