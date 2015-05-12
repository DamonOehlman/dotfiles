DOTFILES_HOME=~/code/dotfiles

sync: deps fonts synapse roxterm atom /usr/share/xsessions
	@ln -sf $(DOTFILES_HOME)/.bashrc-custom ~/.bashrc-custom
	@ln -sf $(DOTFILES_HOME)/.gtkrc-2.0 ~/.gtkrc2.0
	@ln -sf $(DOTFILES_HOME)/.xmonad ~/.xmonad
	@ln -sf $(DOTFILES_HOME)/config/taffybar ~/.config/taffybar
	@echo "sync complete"

deps:
	@hash compton 2> /dev/null || (echo "please install compton"; exit 1)

synapse:
	@rm -rf ~/.config/synapse
	@ln -s $(DOTFILES_HOME)/config/synapse ~/.config/synapse

roxterm:
	@rm -rf ~/.config/roxterm.sourceforge.net
	@ln -s $(DOTFILES_HOME)/config/roxterm.sourceforge.net ~/.config/roxterm.sourceforge.net

atom:
	@rm -rf ~/.atom
	@ln -s $(DOTFILES_HOME)/.atom ~/.atom

/usr/share/xsessions:
	sudo cp $(DOTFILES_HOME)/.xmonad/xmonad.desktop /usr/share/xsessions

fonts: ~/.local/share/fonts/SourceCodePro-Regular.otf

~/.local/share/fonts/SourceCodePro-Regular.otf:
	wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.tar.gz -O /tmp/sourcecodepro.tar.gz
	tar xf /tmp/sourcecodepro.tar.gz --directory /tmp
	mkdir -p ~/.local/share/fonts
	cp /tmp/source-code-pro*/OTF/* ~/.local/share/fonts
