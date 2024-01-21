{ ... }: {
  loader = {
    systemd-boot.enable = true; 
    efi.canTouchEfiVariables = true;
  };

  kernelParams = [
    "acpi_osi=\"Windows 2020\""
  ];
}
