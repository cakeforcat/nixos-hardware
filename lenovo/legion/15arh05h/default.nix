{
  lib,
  config,
  ...
}: {
  imports = [
    ../../../common/cpu/amd
    ../../../common/gpu/nvidia/prime-sync.nix
    ../../../common/gpu/nvidia/turing
    ../../../common/pc/laptop
    ../../../common/pc/ssd
  ];

  # Specify bus id of Nvidia and AMD graphics.
  hardware.nvidia = {
    prime = {
      amdgpuBusId = "PCI:6:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # legion and nvidia kernel module
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      lenovo-legion-module
    ];
  };

  # Cooling management
  services.thermald.enable = lib.mkDefault true;
}
