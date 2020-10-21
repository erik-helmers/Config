set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

main(){

    source $DIR/programs.sh

    sudo pacman -Syu
    
    echo Installing essentials : ${essentials[@]}
    sudo pacman -S --noconfirm ${essentials[@]}
    
    prompt_yes_no "Archlinux specific ? (${archlinux[@]})" && sudo pacman -S --noconfirm  ${archlinux[@]}

    prompt_yes_no "Misc from AUR (requires pamac) ? (${misc_aur[@]})" && pamac install ${misc_aur[@]}

    for pack in "${languages_pack[@]}"
    do 
        # Just evals to the list of programs to install
        install_list=$(eval echo \${"$pack"[@]})    
        prompt_yes_no "Install $pack ($install_list) ? " && sudo pacman -S --noconfirm $install_list
    done    

    prompt_yes_no "Install Rust ?" && install_rust
    prompt_yes_no "Install pyenv  ?" && install_pyenv
    prompt_yes_no "Link config files to this repository ?" && make_symlink
    prompt_yes_no "Generate Github keys ? " && gen_key
    prompt_yes_no "Set git user.name and user.mail" && set_git_infos
    zsh
}

install_rust(){
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
}
install_pyenv(){
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
}


make_symlink(){

    ln -sf $DIR/.zsh* $HOME

    mkdir -p $HOME/.config/Code/User/
    echo Linking VSCode files to $HOME/.config/Code/User
    ln -sf $DIR/Code/User/* $HOME/.config/Code/User
}


# Generates RSA keys to use on github or other
# xclip should be installed (so make sure to run install_utils before)
gen_key() {
    ssh-keygen -t rsa -b 4096 -C "erik.helmers@outlook.fr"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    xclip -sel clip < ~/.ssh/id_rsa.pub
    echo The key has been set in the clipboard. Please past it at https://github.com/settings/keys
}


set_git_infos() {
    read -p "Git name: " name
    read -p "Git email: " email
    git config --global user.name "$name"
    git config --global user.email "$email"
}

prompt_yes_no(){
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) return  1 ;;
        esac
    done
}

main