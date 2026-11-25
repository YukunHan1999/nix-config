{ config, pkgs, ... }:
{
  # 字体图标
  fonts.packages = with pkgs; [
    font-awesome_4
  ];
  # 禁用鼠标加速，触摸板加速
  services.libinput = {
    enable = true;
    # disabling mouse acceleration
    mouse = {
      accelProfile = "flat";
    };
    # disabling touchpad acceleration
    touchpad = {
      accelProfile = "flat";
    };
  };
  # 移除不需要的包
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # 启用 Hyprland
  programs.hyprland.enable = true;

  # 配置显示管理器 (SDDM)
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";

  # 输入法支持
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    extraLocales = ["zh_CN.UTF-8/UTF-8"];
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        plasma6Support = true;
        waylandFrontend = true;
        ignoreUserConfig = true;    # 吃下面的 settings，不用 user 的
        addons = with pkgs; [
          fcitx5-chinese-addons
        ];
        settings = {
          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "keyboard-us";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "shuangpin";
          };
        };
      };
    };
  };
  # 时区支持
  time.timeZone = "Asia/Shanghai";
}
