{ config, pkgs, ... }:

{
   home.username = "damo";
   home.homeDirectory = "/home/damo";
   home.stateVersion = "24.05";
   home.packages = [
    pkgs.gnupg
    pkgs.pinentry.curses
    pkgs.pass
    pkgs.home-manager
    pkgs.waybar
    pkgs.gnumake
    (pkgs.python3.withPackages (ppkgs: [
        ppkgs.json5 ppkgs.requests
    ]))
   ];

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
