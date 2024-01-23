{ lib, config, pkgs, ... }: {
  home.stateVersion = "23.11";
  home.enableNixpkgsReleaseCheck = false;

  home.packages = [
    # Dev
    pkgs.ripgrep
    pkgs.tmux
    pkgs.wget
    pkgs.curl
    pkgs.gcc
    pkgs.git
    pkgs.rustup
    pkgs.ocaml
    pkgs.opam
    pkgs.gnumake
    pkgs.gnutar
    pkgs.gnupatch
    pkgs.gzip

    # zsh 
    pkgs.fzf
    pkgs.zinit

    # ocaml system dependencies
    pkgs.gmp5
  ];

  programs.git = {
    enable = true;
    userName = "jawline";
    userEmail = "blake@parsed.uk";
  };

  home.file.".zshrc".source = ./etc/zshrc;
  home.file.".vimrc".source = ./etc/vimrc;
  home.file.".tmux.conf".source = ./etc/tmux.conf;
  home.file.".config/i3/config".source = ./etc/i3/config;
  home.file.".config/polybar/launch.sh".source = ./etc/polybar/launch.sh;
  home.file.".config/polybar/config.ini".source = ./etc/polybar/config.ini;

  home.activation = {

    initializeOcaml = lib.hm.dag.entryAfter [ "installPackages" ] ''
      export PATH="${config.home.path}/bin:$PATH"
      opam init -y
      eval $(opam env)
      opam update -y
    '';

    initializeRust = lib.hm.dag.entryAfter [ "installPackages" ] ''
      	export PATH="${config.home.path}/bin:$PATH"
              rustup default nightly
              rustup update
    '';
  };
}
