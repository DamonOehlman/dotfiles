DOTFILES_HOME=~/code/dotfiles

sync:
	@ln -sf $(DOTFILES_HOME)/.bashrc-custom ~/.bashrc-custom
	@echo "sync complete"

synapse:
	@rm -rf ~/.config/synapse
	@ln -s $(DOTFILES_HOME)/config/synapse ~/.config/synapse

roxterm:
	@rm -rf ~/.config/roxterm.sourceforge.net
	@ln -s $(DOTFILES_HOME)/config/roxterm.sourceforge.net ~/.config/roxterm.sourceforge.net

atom:
	@rm -rf ~/.atom
	@ln -s $(DOTFILES_HOME)/.atom ~/.atom

sublime:
	@rm -rf ~/.config/sublime-text-3/Packages/User
	@mkdir -p ~/.config/sublime-text-3/Packages
	@ln -s $(DOTFILES_HOME)/config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User

/usr/share/xsessions:
	sudo cp $(DOTFILES_HOME)/.xmonad/xmonad.desktop /usr/share/xsessions

intellij:
	@mkdir -p ~/.IntelliJIdea14
	@ln -sf $(DOTFILES_HOME)/.IntelliJIdea14/config ~/.IntelliJIdea14/

fonts: ~/.local/share/fonts/SourceCodePro-Regular.otf

~/.local/share/fonts/SourceCodePro-Regular.otf:
	wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.tar.gz -O /tmp/sourcecodepro.tar.gz
	tar xf /tmp/sourcecodepro.tar.gz --directory /tmp
	mkdir -p ~/.local/share/fonts
	cp /tmp/source-code-pro*/OTF/* ~/.local/share/fonts
