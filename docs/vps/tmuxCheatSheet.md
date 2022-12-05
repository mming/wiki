# Tmux 快捷键

## 启动新会话：

tmux [new -s 会话名 -n 窗口名]
```
tmux new -s tmuxxx
```
## 恢复会话：

tmux at [-t 会话名]
```
tmux a #attach the 1st session
tmux a -t tmuxxx
```
## 列出所有会话：

tmux ls
## 关闭会话：

tmux kill-session -t 会话名

## 在 Tmux 中，按下 Tmux 前缀 ctrl+b，然后：
### 会话 session
    :new<回车>  启动新会话
    s           列出所有会话
    $           重命名当前会话

### 窗口 (标签页) window

    c  创建新窗口
    w  列出所有窗口
    n  后一个窗口
    p  前一个窗口
    f  查找窗口
    ,  重命名当前窗口
    &  关闭当前窗口

### 窗格（分割窗口） pane
    %  垂直分割
    "  水平分割
    o  交换窗格
    x  关闭窗格
    ⍽  左边这个符号代表空格键 - 切换布局
    q 显示每个窗格是第几个，当数字出现的时候按数字几就选中第几个窗格
    { 与上一个窗格交换位置
    } 与下一个窗格交换位置
    z 切换窗格最大化/最小化

## 杂项：
    d  退出 tmux（tmux 仍在后台运行）
    t  窗口中央显示一个数字时钟
    ?  列出所有快捷键
    :  命令提示符

# 附录
```
bind-key        C-b send-prefix                                                                                                                                                                      [20/20]
bind-key        C-o rotate-window
bind-key        C-z suspend-client
bind-key      Space next-layout
bind-key          ! break-pane
bind-key          " split-window
bind-key          # list-buffers
bind-key          $ command-prompt -I #S "rename-session '%%'"
bind-key          % split-window -h
bind-key          & confirm-before -p "kill-window #W? (y/n)" kill-window
bind-key          ' command-prompt -p index "select-window -t ':%%'"
bind-key          ( switch-client -p
bind-key          ) switch-client -n
bind-key          , command-prompt -I #W "rename-window '%%'"
bind-key          - delete-buffer
bind-key          . command-prompt "move-window -t '%%'"
bind-key          0 select-window -t :0
bind-key          1 select-window -t :1
bind-key          2 select-window -t :2
bind-key          3 select-window -t :3
bind-key          4 select-window -t :4
bind-key          5 select-window -t :5
bind-key          6 select-window -t :6
bind-key          7 select-window -t :7
bind-key          8 select-window -t :8
bind-key          9 select-window -t :9
bind-key          : command-prompt
bind-key          ; last-pane
bind-key          = choose-buffer
bind-key          ? list-keys
bind-key          D choose-client
bind-key          L switch-client -l
bind-key          [ copy-mode
bind-key          ] paste-buffer
bind-key          c new-window
bind-key          d detach-client
bind-key          f command-prompt "find-window '%%'"
bind-key          i display-message
bind-key          l last-window
bind-key          n next-window
bind-key          o select-pane -t :.+
bind-key          p previous-window
bind-key          q display-panes
bind-key          r refresh-client
bind-key          s choose-tree
bind-key          t clock-mode
bind-key          w choose-window
bind-key          x confirm-before -p "kill-pane #P? (y/n)" kill-pane
bind-key          z resize-pane -Z
bind-key          { swap-pane -U
bind-key          } swap-pane -D
bind-key          ~ show-messages
bind-key      PPage copy-mode -u
bind-key -r      Up select-pane -U
bind-key -r    Down select-pane -D
bind-key -r    Left select-pane -L
bind-key -r   Right select-pane -R
bind-key        M-1 select-layout even-horizontal
bind-key        M-2 select-layout even-vertical
bind-key        M-3 select-layout main-horizontal
bind-key        M-4 select-layout main-vertical
bind-key        M-5 select-layout tiled
bind-key        M-n next-window -a
bind-key        M-o rotate-window -D
bind-key        M-p previous-window -a
bind-key -r    M-Up resize-pane -U 5
bind-key -r  M-Down resize-pane -D 5
bind-key -r  M-Left resize-pane -L 5
bind-key -r M-Right resize-pane -R 5
bind-key -r    C-Up resize-pane -U
bind-key -r  C-Down resize-pane -D
bind-key -r  C-Left resize-pane -L
bind-key -r C-Right resize-pane -R

```