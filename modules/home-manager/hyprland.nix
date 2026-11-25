{ config, pkgs, ... }:
{
  # 配置 XDG 桌面门户 (截图、文件选择、屏幕共享)
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # 启用并配置 Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true; # 兼容 X11 应用

    settings = {
      # 键位绑定
      bind = [
        "CTRL ALT, R, exec, wofi --show drun"
        "CTRL, Q, killactive,"
        "CTRL ALT, Q, exit,"
        "CTRL ALT, V, togglefloating,"
        "ALT, 1, workspace, 1"
        "ALT, 2, workspace, 2"
        "ALT, 3, workspace, 3"
        "ALT, 4, workspace, 4"
        "ALT, 5, workspace, 5"
        "ALT, 6, workspace, 6"
        "ALT, 7, workspace, 7"
        "ALT, 8, workspace, 8"
        "ALT, 9, workspace, 9"
        "ALT, 0, workspace, 10"
        "CTRL, 1, movetoworkspace, 1"
        "CTRL, 2, movetoworkspace, 2"
        "CTRL, 3, movetoworkspace, 3"
        "CTRL, 4, movetoworkspace, 4"
        "CTRL, 5, movetoworkspace, 5"
        "CTRL, 6, movetoworkspace, 6"
        "CTRL, 7, movetoworkspace, 7"
        "CTRL, 8, movetoworkspace, 8"
        "CTRL, 9, movetoworkspace, 9"
        "CTRL, 0, movetoworkspace, 10"
      ];

      bindm = [
        "CTRL ALT, mouse:272, movewindow"
        "CTRL ALT, mouse:273, resizewindow"
      ];
      
      monitor = [
        ",preffered,auto,1"
        "HDMI-A-1,1920x1080@60,auto,1"
      ];

      # 启动项
      exec-once = [
	"ghostty"
        "waybar"
        "dunst"
        "swww-daemon"
        "fcitx5 -d"
      ];

      # 环境变量
      env = [
        "XDG_SESSION_TYPE,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
      ];

      # 通用设置
      general = {
          gaps_in = 1;         # 窗口之间的间隙大小
          gaps_out = 0;       # 窗口与显示器边缘的间隙大小
          border_size = 2;     # 窗口边框的宽度
          "col.active_border" = "rgba(cceeffbb)";      # 活动窗口的边框颜色 
          "col.inactive_border" = "rgba(595959aa)";    # 非活动窗口的边框颜色
      
          "layout" = "dwindle";    # 窗口布局
      };

      # 窗口装饰
      decoration = {
        rounding = 5;       # 圆角大小
      };
    };
  };

  # 安装 Hyprland 配套软件
  home.packages = with pkgs; [
    ghostty	      # 终端
    waybar            # 状态栏
    wofi              # 启动器
    dunst             # 通知
    swww              # 壁纸
    grim              # 截图
    slurp             # 区域选择
    wl-clipboard      # 剪贴板
  ];
}
