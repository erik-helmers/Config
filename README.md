# Config

First step for installing
```
ssh-keygen -t rsa -b 4096 -C "erik.helmers@outlook.fr" \
&& eval "$(ssh-agent -s)" \
&& ssh-add ~/.ssh/id_rsa \
&& sudo apt-get install xclip \
&& xclip -sel clip < ~/.ssh/id_rsa.pub
```

Paste in https://github.com/settings/keys,
then `cd Documents && git clone git@github.com:erik-helmers/Config.git`

