{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  imports = [ (import "${home-manager}/nixos") ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  boot = import ./boot.nix { };

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

  # Power management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;
    };
  };

  environment.systemPackages = with pkgs; [
    zsh
    vim
    light
    autoconf
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.variables = { EDITOR = "vim"; };

  # Video Games
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Display
  services.xserver = {

    enable = true;
    dpi = 130;
    xautolock.enable = true;

    desktopManager.xterm.enable = false;

    displayManager = { lightdm.enable = true ; defaultSession = "none+i3"; };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ acpi dmenu polybar i3lock rofi alacritty ];
    };

    layout = "us";
    xkbVariant = "";
  };

  security.sudo = {
    enable = true;
    extraRules = [{
      runAs="root";
      groups = [ "wheel" ];
      commands = [ "${pkgs.light}/bin/light" ];
    }];
  };

  programs.xss-lock.enable = true;

  # User

  users.users.blake = {
    isNormalUser = true;
    description = "Blake";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ firefox pavucontrol ];
  };

  home-manager.users.blake = import ./home.nix;
  system.stateVersion = "23.11";
}
