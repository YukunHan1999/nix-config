{ config, pkgs, ... }:
{
    programs.tmux = {
      enable = true;

      # 复制模式使用 vi 按键 (对应 setw -g mode-keys vi)
      keyMode = "vi";

      # 1. 前缀键设置：NixOS 模块会覆盖 extraConfig 中的 prefix 设置
      # 模块默认使用 C-b，且其内部逻辑（unbind/set prefix/bind send-prefix）会生效。
      # 如果你想用 Alt-Space 作为前缀，在 NixOS 模块下没有直接的选项。
      # 一个变通方法是利用 extraConfig 在模块逻辑之后执行，但可能产生冲突。
      # 更稳妥的方式是接受模块的默认 C-b，或通过 shortcut 选项改回 C-a 等。

      # 如果坚持要用 m-Space，可以尝试在 extraConfig 中重新设置，但不保证生效：
      # 光标形状覆盖 (terminal-overrides)
      # 关闭状态栏
      # 自定义复制模式按键绑定
      extraConfig = ''
        set -g prefix m-Space
        bind m-Space send-prefix
        set -as terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[2 q'
        set -g status off
        bind-key y copy-mode
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi V send-keys -X select-line
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
        bind-key p run-shell "pbpaste | tmux load-buffer - && tmux paste-buffer"
      '';
    };
}
