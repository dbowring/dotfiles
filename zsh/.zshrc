
for conf in $(find $ZDOTDIR/conf.d -maxdepth 1 -type f -name '*.zsh' | sort -n); do
    source $conf
done
