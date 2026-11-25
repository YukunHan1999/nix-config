{ config, pkgs, ... }:
{
  programs.waybar.enable = true;
  xdg.configFile."waybar/config.jsonc".source = ./waybarconfig.jsonc;
  programs.waybar.style = ./style.css;
}
