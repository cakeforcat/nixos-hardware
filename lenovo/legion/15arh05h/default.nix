{
  lib,
  config,
  ...
}: {
  imports = [
    ../../../common/cpu/amd
    # ../../../common/gpu/nvidia/prime-sync.nix
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

  hardware.graphics.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  specialisation.hybrid-gfx.configuration = {
    system.nixos.tags = [ "hybrid-gfx" ];
    hardware.nvidia.prime = {
      reverseSync.enable = lib.mkOverride 990 true; # Enable reverse PRIME sync
      sync.enable = lib.mkForce false;    
    };
  };

  # legion kernel module
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      lenovo-legion-module
    ];
  };

  # Cooling management
  services.thermald.enable = lib.mkDefault true;
}
