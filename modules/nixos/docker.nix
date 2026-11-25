{ config, pkgs, ... }:
{
  # In /etc/nixos/configuration.nix
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      proxies = {
        http-proxy = "http://172.17.0.2:7897";
        https-proxy = "http://172.17.0.2:7897";
        no-proxy = "localhost,127.0.0.1,::1"; # 根据需要排除的地址
      };
    };
  };
  
  # Optional: Add your user to the "docker" group to run docker without sudo
  users.users.hyk.extraGroups = [ "docker" ];
}
