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

  services.logind = {
    extraConfig = ''
      IdleAction=hybrid-sleep
      IdleActionSec=15min
    '';
  };

  environment.systemPackages = with pkgs; [ zsh vim light ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.variables = { EDITOR = "vim"; };

  # Display
  services.xserver = {

    enable = true;
    dpi = 180;
    xautolock.enable = true;

    desktopManager.xterm.enable = false;

    displayManager = { defaultSession = "none+i3"; };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3status i3lock rofi alacritty ];
    };

    layout = "us";
    xkbVariant = "";
  };

  programs.xss-lock.enable = true;

  # User

  users.users.blake = {
    isNormalUser = true;
    description = "Blake";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ firefox ];
  };

  home-manager.users.blake = import ./home.nix;
  system.stateVersion = "23.11";
}
