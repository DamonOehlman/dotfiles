DOTFILES_HOME=~/dotfiles
GITHUB_USERNAME=DamonOehlman
WINDOWS_USERNAME=Damon
UNAME := $(shell uname -a)
YARN_BIN := $(shell yarn bin)
UNAME_WSL_KERNEL_MICROSOFT := $(shell uname -r | cut -f2 -d'-')
UNAME_MSYS=$(filter MINGW64_NT-10.0 MSYS2_NT-10.0,$(UNAME))
TEMPLATE_VARS=$(DOTFILES_HOME)/config/template_vars_nix.json

ifeq (microsoft,$(UNAME_WSL_KERNEL_MICROSOFT))
	IS_WINDOWS=1
	APPDATA=/mnt/c/Users/$(WINDOWS_USERNAME)/AppData/Roaming
else ifneq (,$(UNAME_MSYS))
	IS_WINDOWS=1
endif

ifeq ($(IS_WINDOWS),1)
	PATH_VSCODE=$(APPDATA)/Code/User
else ifeq ($(UNAME),Darwin)
	PATH_VSCODE=~/Library/Application\ Support/Code/User
else ifneq (,$(findstring Linux,$(UNAME)))
	PATH_VSCODE=$(HOME)/.config/Code/User
endif

ifeq ($(IS_WINDOWS),1)
TEMPLATE_VARS=$(DOTFILES_HOME)/config/template_vars_win.json
default: vscode mintty alacritty
	@echo "sync complete"
else
default: configfiles macapps bashrc editors localbin code_settings i3 alacritty sway
	@echo "sync complete"
endif

windows: bashrc editors localbin code_settings sublime alacritty
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
	@ln -sf $(DOTFILES_HOME)/config/polybar ~/.config/

synapse:
	@rm -rf ~/.config/synapse
	@ln -s $(DOTFILES_HOME)/config/synapse ~/.config/synapse

vscode: node_modules
	@echo "updating vscode settings in: $(PATH_VSCODE)"
	@mkdir -p "$(PATH_VSCODE)"
	@ln -fs $(DOTFILES_HOME)/config/code/settings.json "$(PATH_VSCODE)"
	@ln -sf $(DOTFILES_HOME)/config/code/keybindings.json "$(PATH_VSCODE)"

localbin:
	@mkdir -p ~/bin
	@ln -sf $(DOTFILES_HOME)/bin/* ~/bin/

editors: vscode vim
	@DOTFILES_HOME=$(DOTFILES_HOME) ./scripts/editors/intellij.sh

vim:
	@ln -sf $(DOTFILES_HOME)/config/vim/.vimrc ~/.vimrc
	@mkdir -p ~/.vim/
	@ln -sf $(DOTFILES_HOME)/config/vim/ftplugin ~/.vim/

sublime:
ifeq ($(IS_WINDOWS),1)
	@cp $(DOTFILES_HOME)/config/sublime-text-3/Packages/User/* $(APPDATA)/Sublime\ Text\ 3/Packages/User/
else
	@rm -rf ~/.config/sublime-text-3/Packages/User
	@mkdir -p ~/.config/sublime-text-3/Packages
	@ln -s $(DOTFILES_HOME)/config/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User
endif

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

code_settings:
	@ln -sf $(DOTFILES_HOME)/config/.editorconfig ~/code/.editorconfig

node_modules:
	yarn install

alacritty:
ifeq ($(IS_WINDOWS),1)
	@mkdir -p $(APPDATA)/alacritty
	@cp $(DOTFILES_HOME)/config/alacritty/alacritty.toml $(APPDATA)/alacritty/alacritty.toml
else
	@ln -sf $(DOTFILES_HOME)/config/alacritty/alacritty.toml ~/.config/alacritty.toml
endif

gtk3:
	@ln -sf $(DOTFILES_HOME)/config/gtk-3.0 ~/.config/

bspwm:
	@ln -sf $(DOTFILES_HOME)/config/bspwm ~/.config/
	@ln -sf $(DOTFILES_HOME)/config/sxhkd ~/.config/
	@ln -sf $(DOTFILES_HOME)/config/yabar ~/.config/
	@ln -sf $(DOTFILES_HOME)/config/rofi ~/.config/

tmux:
	@DOTFILES_HOME=$(DOTFILES_HOME) $(DOTFILES_HOME)/scripts/configure-tmux.sh

sway: waybar
	@ln -sf $(DOTFILES_HOME)/config/sway ~/.config/

waybar:
	@ln -sf $(DOTFILES_HOME)/config/waybar ~/.config/

# WINDOWS THINGS

mintty:
	@cp $(DOTFILES_HOME)/config/.minttyrc ~/.minttyrc

