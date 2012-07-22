update:
	git submodule foreach git pull -f origin master
	brew update && brew upgrade `brew outdated`
	/bin/sh ~/.oh-my-zsh/tools/upgrade.sh
	npm update -g
