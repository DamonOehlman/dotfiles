DOTFILES_HOME=~/code/dotfiles

default: macapps bashrc vscode localbin
	@echo "sync complete"

bashrc:
	@ln -sf $(DOTFILES_HOME)/.bashrc-custom ~/.bashrc-custom

synapse:
	@rm -rf ~/.config/synapse
	@ln -s $(DOTFILES_HOME)/config/synapse ~/.config/synapse
	
vscode:
	@mkdir -p ~/Library/Application\ Support/Code
	@rm -rf ~/Library/Application\ Support/Code/User
	@ln -sf $(DOTFILES_HOME)/Library/Application\ Support/Code/User ~/Library/Application\ Support/Code

localbin:
	@mkdir -p ~/bin
	@ln -sf $(DOTFILES_HOME)/bin/* ~/bin/ 

roxterm:
	@rm -rf ~/.config/roxterm.sourceforge.net
	@ln -s $(DOTFILES_HOME)/config/roxterm.sourceforge.net ~/.config/roxterm.sourceforge.net

editors:
	./scripts/editors/intellij.sh

atom:
	@rm -rf ~/.atom
	@ln -s $(DOTFILES_HOME)/.atom ~/.atom

sublime:
	@rm -rf ~/.config/sublime-text-3/Packages/User
	@mkdir -p ~/.config/sublime-text-3/Packages
	@ln -s $(DOTFILES_HOME)/config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User

macapps:
	@ln -sf $(DOTFILES_HOME)/Library/Preferences/*.plist ~/Library/Preferences
	@$(DOTFILES_HOME)/scripts/mac-defaults.sh

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
