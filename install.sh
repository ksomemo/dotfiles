#!/bin/sh

install() {
    local files=(
     .gitconfig
     .gitignore_global
     .kerlrc
     .tmux.conf
     .vim
     .vimrc
     .zshrc
    )
    local script_dir_path=$(dirname $(readlink -f $0))
    echo $script_dir_path
    for f in ${files[@]}
    do
        echo $script_dir_path/$f to $HOME/$f
        ln -s $script_dir_path/$f $HOME/$f
    done
}

install
