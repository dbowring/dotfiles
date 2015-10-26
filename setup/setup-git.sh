

echo "GIT: Full name?"
read fullname
git config --global user.name "$fullname"
echo "Git: Email?"
read email
git config --global user.email "$email"

