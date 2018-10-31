DOTFILES_HOME=~/dotfiles
GITHUB_USERNAME=DamonOehlman
UNAME := $(shell uname -s)

default: configfiles macapps bashrc editors localbin private_settings code_settings i3
	@echo "sync complete"

windows: bashrc editors localbin code_settings
	@echo "windows sync complete"

i3:
ifeq ($(UNAME),Linux)
	@ln -sf $(DOTFILES_HOME)/.i3 ~/
endif

bashrc:
	@ln -sf $(DOTFILES_HOME)/.bashrc-custom ~/.bashrc-custom

configfiles:
	@mkdir -p ~/.config
	@ln -sf $(DOTFILES_HOME)/config/.Xresources ~/.Xresources
	@ln -sf $(DOTFILES_HOME)/config/termite ~/.config/

tools: dotfiles.private
	@cat $(DOTFILES_HOME)/config/.mertrc $(DOTFILES_HOME)/private/.mertrc > ~/.mertrc

synapse:
	@rm -rf ~/.config/synapse
	@ln -s $(DOTFILES_HOME)/config/synapse ~/.config/synapse

vscode:
ifeq ($(UNAME),Darwin)
	@rm -rf ~/Library/Application\ Support/Code/User
	@mkdir -p ~/Library/Application\ Support/Code/User
	@ln -sf $(DOTFILES_HOME)/config/code/* ~/Library/Application\ Support/Code/User
endif
ifeq ($(UNAME),Linux)
	@ln -sf $(DOTFILES_HOME)/config/code/* ~/.config/Code\ -\ OSS/User
endif

localbin:
	@mkdir -p ~/bin
	@ln -sf $(DOTFILES_HOME)/bin/* ~/bin/

editors: vscode
	@ln -sf $(DOTFILES_HOME)/.vimrc ~/.vimrc
	@DOTFILES_HOME=$(DOTFILES_HOME) ./scripts/editors/intellij.sh

sublime:
	@rm -rf ~/.config/sublime-text-3/Packages/User
	@mkdir -p ~/.config/sublime-text-3/Packages
	@ln -s $(DOTFILES_HOME)/config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User

macapps:
ifeq ($(UNAME),Darwin)
	@ln -sf $(DOTFILES_HOME)/Library/Preferences/*.plist ~/Library/Preferences
	@ln -sf $(DOTFILES_HOME)/config/chunkwmrc ~/.chunkwmrc
	@ln -sf $(DOTFILES_HOME)/config/.khdrc ~/.khdrc
	@$(DOTFILES_HOME)/scripts/mac-defaults.sh
endif

fonts: ~/.local/share/fonts/SourceCodePro-Regular.otf ~/.local/share/fonts/FiraCode-Regular.ttf
ifeq ($(UNAME),Darwin)
	@mkdir -p ~/Library/Fonts
	@cp -f ~/.local/share/fonts/* ~/Library/Fonts/
endif

~/.local/share/fonts/SourceCodePro-Regular.otf:
	wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.tar.gz -O /tmp/sourcecodepro.tar.gz
	tar xf /tmp/sourcecodepro.tar.gz --directory /tmp
	mkdir -p ~/.local/share/fonts
	cp /tmp/source-code-pro*/OTF/* ~/.local/share/fonts

~/.local/share/fonts/FiraCode-Regular.ttf:
	@./scripts/install-firacode.sh

dotfiles.private:
	@echo "cloning private configuration repo"
	@rm -rf $(DOTFILES_HOME)/private
	@git clone -q git@github.com:$(GITHUB_USERNAME)/dotfiles.private.git private

pull_private:
	@echo "fetching latest private configuration"
	@cd private/
	@git pull -q origin master
	@cd ..

private_settings: dotfiles.private pull_private
ifeq ($(UNAME),Darwin)
	@echo "running private configuration tasks"
	@private/mac_defaults.sh
endif

clean:
	@rm -rf $(DOTFILES_HOME)/private

code_settings:
	@ln -sf $(DOTFILES_HOME)/config/.editorconfig ~/code/.editorconfig
