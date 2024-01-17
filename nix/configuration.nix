{ lib, config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports =
    [  (import "${home-manager}/nixos") ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "laptop"; 

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Hong_Kong";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_HK.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  users.users.blake = {
    isNormalUser = true;
    description = "Blake";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ vim zsh ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  home-manager.users.blake = { lib, ... }: {
    home.stateVersion = "23.11";
    home.packages = [
      # Dev
      pkgs.ripgrep pkgs.tmux pkgs.wget pkgs.curl pkgs.gcc pkgs.git pkgs.rustup pkgs.ocaml pkgs.opam

      # zsh 
      pkgs.fzf pkgs.zinit
    ];

    programs.git = {
      enable = true;
      userName  = "jawline";
      userEmail = "blake@parsed.uk";
    };

    programs.vim.enable = true;

    home.file.".zshrc".source = ./etc/zshrc;
    home.file.".vimrc".source = ./etc/vimrc;
    home.file.".tmux.conf".source = ./etc/tmux.conf;

    home.activation = {

      initializeVim = lib.hm.dag.entryAfter ["writeBoundary"] ''
        echo ':q' | vim
      '';

      initializeOcaml = lib.hm.dag.entryAfter ["writeBoundary"] ''
        opam init -y
        opam update -y
        opam install dune core async hardcaml -y
      '';

      initializeRust = lib.hm.dag.entryAfter ["writeBoundary"] ''
        rustup default nightly
        rustup update
      '';
    };
  };

  system.stateVersion = "23.11";
}
