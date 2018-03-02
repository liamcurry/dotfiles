#!/usr/bin/env bash

DIR=`pwd`

ln -fs $DIR/.aliases $HOME
ln -fs $DIR/.dir_colors $HOME
ln -fs $DIR/.gitconfig $HOME
ln -fs $DIR/.tmux.conf $HOME
ln -fs $DIR/.vimrc $HOME
ln -fs $DIR/.Xmodmap $HOME
ln -fs $DIR/.yarnrc $HOME
ln -fs $DIR/.zshrc $HOME

source $HOME/.aliases

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

if command_exists yarn; then
    echo "Yarn installed, adding globals"
    yarn global add \
        typescript tslint \
        elm elm-format \
        stylelint
fi

if command_exists code; then
    echo "Visual Studio Code detected; adding settings and installing extensions"
    if [ "$(uname)" == "Darwin" ]; then
        ln -fs $DIR/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
        rm -Rf $HOME/Library/Application\ Support/Code/User/snippets
        ln -fs $DIR/vscode/snippets $HOME/Library/Application\ Support/Code/User/snippets
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        ln -fs $DIR/vscode/settings.json $HOME/.config/Code/User/settings.json
        rm -Rf $HOME/.config/Code/User/snippets
        ln -fs $DIR/vscode/snippets $HOME/.config/Code/User/snippets
    fi
    code --install-extension esbenp.prettier-vscode
    code --install-extension PeterJausovec.vscode-docker
    code --install-extension sbrink.elm
    code --install-extension ms-vscode.cpptools
    code --install-extension eg2.tslint
    code --install-extension yzhang.markdown-all-in-one
    code --install-extension shinnn.stylelint
    code --install-extension 2gua.rainbow-brackets
    code --install-extension SmukkeKim.theme-setimonokai
    code --install-extension mikestead.dotenv
    code --install-extension teabyii.ayu
    code --install-extension cssho.vscode-svgviewer
fi

echo "Done"
