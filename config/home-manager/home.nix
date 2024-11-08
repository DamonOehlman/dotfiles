{
  config,
  pkgs,
  lib,
  ...
}:

{

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "vscode"
    ];

  home.username = "damo";
  home.homeDirectory = "/home/damo";
  home.stateVersion = "24.05";
  home.packages = [
    # nixos things
    pkgs.home-manager
    pkgs.nixfmt-rfc-style
    # hyprland things
    pkgs.waybar
    # cli things
    pkgs.gnupg
    pkgs.pinentry.curses
    pkgs.pass
    pkgs.gnumake
    pkgs.graphviz
    # fonts
    pkgs.font-awesome
    pkgs.fira-code
    # python + packages
    (pkgs.python3.withPackages (ppkgs: [
      ppkgs.json5
      ppkgs.requests
    ]))
  ];

  fonts.fontconfig.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  programs.git = {
    enable = true;
    userName = "Damon Oehlman";
    userEmail = "damon.oehlman@gmail.com";
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
    ];
  };

  services.mbsync.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    pinentryPackage = pkgs.pinentry.curses;
    enableScDaemon = false;
    enableSshSupport = true;
  };
}
