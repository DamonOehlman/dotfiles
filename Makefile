DOTFILES_HOME=~/dotfiles
GITHUB_USERNAME=DamonOehlman
WINDOWS_USERNAME=Damon
UNAME := $(shell uname -a)
YARN_BIN := $(shell yarn bin)
UNAME_WSL_KERNEL_MICROSOFT := $(shell uname -r | cut -f2 -d'-')
UNAME_DARWIN := $(shell uname -a | cut -f1 -d' ')
UNAME_MSYS=$(filter MINGW64_NT-10.0 MSYS2_NT-10.0,$(UNAME))
TEMPLATE_VARS=$(DOTFILES_HOME)/config/template_vars_nix.json
MENSLO_LGS_FONTS = Regular Bold Italic Bold\ Italic

ifeq (microsoft,$(UNAME_WSL_KERNEL_MICROSOFT))
	IS_WINDOWS=1
	APPDATA=/mnt/c/Users/$(WINDOWS_USERNAME)/AppData/Roaming
else ifneq (,$(UNAME_MSYS))
	IS_WINDOWS=1
endif

ifeq (Darwin,$(UNAME_DARWIN))
	IS_MAC=1
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
default: configfiles wayland_config macapps zshrc bashrc editors localbin code_settings alacritty sway
	@echo "sync complete"
endif

windows: zshrc bashrc editors localbin code_settings alacritty
	@echo "windows sync complete"

bashrc:
	@ln -sf $(DOTFILES_HOME)/.bashrc-custom ~/.bashrc-custom

configfiles:
	@mkdir -p ~/.config

wayland_config:
	@ln -sf $(DOTFILES_HOME)/config/electron25-flags.conf ~/.config/

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
ifeq ($(IS_MAC),1)
	echo "configuring mac apps"
	@ln -sf $(DOTFILES_HOME)/config/yabai ~/.config
	@ln -sf $(DOTFILES_HOME)/config/.aerospace.toml ~/
	@ln -sf $(DOTFILES_HOME)/config/skhd ~/.config
	@ln -sf $(DOTFILES_HOME)/config/sketchybar/sketchybarrc ~/.config/sketchybar
	# @$(DOTFILES_HOME)/scripts/mac-defaults.sh
endif

fonts: $(MENSLO_LGS_FONTS) ~/.local/share/fonts/ttf/FiraCode-Regular.ttf
ifeq ($(IS_MAC),1)
	@mkdir -p ~/Library/Fonts
	@cp -f ~/.local/share/fonts/* ~/Library/Fonts/
else ifneq (,$(findstring Linux,$(UNAME)))
	@fc-cache -r
	@echo "installed fonts"
endif

$(MENSLO_LGS_FONTS):
	@wget -nv -nc -P ~/.local/share/fonts "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS NF $(@).ttf"

~/.local/share/fonts/ttf/FiraCode-Regular.ttf:
	@./scripts/install-firacode.sh

code_settings:
	@ln -sf $(DOTFILES_HOME)/config/.editorconfig ~/code/.editorconfig

node_modules:
	yarn install

alacritty:
ifeq ($(IS_WINDOWS),1)
	@mkdir -p $(APPDATA)/alacritty
	@cp $(DOTFILES_HOME)/config/alacritty/alacritty.windows.toml $(APPDATA)/alacritty/alacritty.toml
else
	@ln -sf $(DOTFILES_HOME)/config/alacritty/alacritty.toml ~/.alacritty.toml
endif

tmux:
	@DOTFILES_HOME=$(DOTFILES_HOME) $(DOTFILES_HOME)/scripts/configure-tmux.sh

sway: waybar
	@ln -sf $(DOTFILES_HOME)/config/sway ~/.config/

waybar:
	@ln -sf $(DOTFILES_HOME)/config/waybar ~/.config/

zshrc:
	@ln -sf $(DOTFILES_HOME)/.zshrc ~/

zsh-themes: ~/.oh-my-zsh ~/.oh-my-zsh/custom/themes/powerlevel10k

~/.oh-my-zsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

~/.oh-my-zsh/custom/themes/powerlevel10k:
	@git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
	@ln -sf $(DOTFILES_HOME)/config/.p10k.zsh ~/

# WINDOWS THINGS

mintty:
	@cp $(DOTFILES_HOME)/config/.minttyrc ~/.minttyrc

