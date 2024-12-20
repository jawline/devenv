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
    pkgs.gmp5
    pkgs.gmp5.dev
    pkgs.flex
    pkgs.bison
    pkgs.zlib-ng
    pkgs.zlib-ng.dev
    pkgs.pkg-config
    pkgs.gnum4
    pkgs.mpfr
    pkgs.autoconf
    pkgs.automake
    pkgs.python3
    pkgs.texinfo
    pkgs.gperf
    pkgs.libtool
    pkgs.patchutils
    pkgs.bc
    pkgs.ninja
    pkgs.cmake

    # zsh 
    pkgs.fzf
    pkgs.zinit
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
}
