update:
	@echo 'Updating git submodules...' && \
		git submodule foreach git pull -f origin master || \
		growlnotify "Failed to update" -m "There was a problem updating git submodules"
	@echo 'Updating brew packages...' && \
		brew update && brew upgrade `brew outdated` || \
		growlnotify "Failed to update" -m "There was a problem updating brew packages"
	@echo 'Updating oh-my-zsh...' && \
		/bin/sh ~/.oh-my-zsh/tools/upgrade.sh || \
		growlnotify "Failed to update" -m "There was a problem updating oh-my-zsh"
	@echo 'Updating global node modules' && \
		npm update -g || \
		growlnotify "Failed to update" -m "There was a problem updating npm packages"
	@growlnotify "Update completed" -m "Update completed. Check logs if there was an error."

clean:
	@find $(HOME) -name '.DS_Store' -or \
						 -name '._*' -or \
						 -name '.localized' \
						 -name '.Spotlight-*' \
						 -delete
