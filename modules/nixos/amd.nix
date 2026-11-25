{ config, pkgs, ... }:
{
  hardware.enableRedistributableFirmware = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # 兼容 Steam/Wine 等 32 位程序
  };
  hardware.amdgpu.initrd.enable = true;
}
