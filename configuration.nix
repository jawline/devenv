{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [ (import "${home-manager}/nixos") ./hardware-configuration.nix ];

  # Meta
  nixpkgs.config.allowUnfree = true;

  # Boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # General System
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_HK.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.greenclip.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [ zsh vim light ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.variables = { EDITOR = "vim"; };

  # Display

  services.xserver.enable = true;
  services.xserver.dpi = 180;
  services.xserver = {
    desktopManager.xterm.enable = false;

    displayManager = { defaultSession = "none+i3"; };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3status i3lock rofi alacritty ];
    };

    layout = "us";
    xkbVariant = "";
  };

  users.users.blake = {
    isNormalUser = true;
    description = "Blake";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ firefox ];
  };

  home-manager.users.blake = { lib, config, ... }: {
    home.stateVersion = "23.11";

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

    home.activation = {

      initializeOcaml = lib.hm.dag.entryAfter [ "installPackages" ] ''
        export PATH="${config.home.path}/bin:$PATH"
        opam init -y
        opam update -y
        opam install dune core async hardcaml -y
      '';

      initializeRust = lib.hm.dag.entryAfter [ "installPackages" ] ''
        	export PATH="${config.home.path}/bin:$PATH"
                rustup default nightly
                rustup update
      '';
    };
  };

  system.stateVersion = "23.11";
}
