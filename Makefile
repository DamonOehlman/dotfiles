DOTFILES_HOME=~/code/dotfiles
GITHUB_USERNAME=DamonOehlman
UNAME := $(shell uname -s)

default: macapps bashrc editors localbin private_settings code_settings
	@echo "sync complete"

windows: bashrc editors localbin code_settings
	@echo "windows sync complete"

bashrc:
	@ln -sf $(DOTFILES_HOME)/.bashrc-custom ~/.bashrc-custom

tools:
	@ln -sf $(DOTFILES_HOME)/config/.mertrc ~/.mertrc

synapse:
	@rm -rf ~/.config/synapse
	@ln -s $(DOTFILES_HOME)/config/synapse ~/.config/synapse

vscode:
	@rm -rf ~/Library/Application\ Support/Code/User
	@mkdir -p ~/Library/Application\ Support/Code/User
	@ln -sf $(DOTFILES_HOME)/config/code/* ~/Library/Application\ Support/Code/User

localbin:
	@mkdir -p ~/bin
	@ln -sf $(DOTFILES_HOME)/bin/* ~/bin/

roxterm:
	@rm -rf ~/.config/roxterm.sourceforge.net
	@ln -s $(DOTFILES_HOME)/config/roxterm.sourceforge.net ~/.config/roxterm.sourceforge.net

editors:
	@ln -sf $(DOTFILES_HOME)/.vimrc ~/.vimrc
	@DOTFILES_HOME=$(DOTFILES_HOME) ./scripts/editors/intellij.sh
	@DOTFILES_HOME=$(DOTFILES_HOME) ./scripts/editors/atom.sh

sublime:
	@rm -rf ~/.config/sublime-text-3/Packages/User
	@mkdir -p ~/.config/sublime-text-3/Packages
	@ln -s $(DOTFILES_HOME)/config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User

macapps:
ifeq ($(UNAME),Darwin)
	@ln -sf $(DOTFILES_HOME)/Library/Preferences/*.plist ~/Library/Preferences
	@ln -sf $(DOTFILES_HOME)/config/.kwm ~/.kwm
	@ln -sf $(DOTFILES_HOME)/config/.khdrc ~/.khdrc
	@$(DOTFILES_HOME)/scripts/mac-defaults.sh
endif

/usr/share/xsessions:
	sudo cp $(DOTFILES_HOME)/.xmonad/xmonad.desktop /usr/share/xsessions

tmux:
	@ln -sf $(DOTFILES_HOME)/.tmux/.tmux.conf ~/.tmux.conf
	@mkdir -p $(DOTFILES_HOME)/.tmux/plugins
	@rm -rf $(DOTFILES_HOME)/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm $(DOTFILES_HOME)/.tmux/plugins/tpm

fonts: ~/.local/share/fonts/SourceCodePro-Regular.otf

~/.local/share/fonts/SourceCodePro-Regular.otf:
	wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.tar.gz -O /tmp/sourcecodepro.tar.gz
	tar xf /tmp/sourcecodepro.tar.gz --directory /tmp
	mkdir -p ~/.local/share/fonts
	cp /tmp/source-code-pro*/OTF/* ~/.local/share/fonts

private:
	@echo "cloning private configuration repo"
	@git clone -q git@github.com:$(GITHUB_USERNAME)/dotfiles.private.git private

pull_private:
	@echo "fetching latest private configuration"
	@cd private/
	@git pull -q origin master
	@cd ..

private_settings: private pull_private
ifeq ($(UNAME),Darwin)
	@echo "running private configuration tasks"
	@private/mac_defaults.sh
endif

clean:
	@rm -rf private/

code_settings:
	@ln -sf $(DOTFILES_HOME)/config/.editorconfig ~/code/.editorconfig
