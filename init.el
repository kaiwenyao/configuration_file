;; -*- mode: emacs-lisp; coding: utf-8; lexical-binding: t -*-
;; macOS 专属配置
(when (eq system-type 'darwin)
  ;; 键位映射：Command 作为 Control，Control 作为 Super
  (setq mac-command-modifier 'control)
  (setq mac-control-modifier 'super)
  (setq mac-option-modifier 'meta)
  (setq mac-function-modifier 'hyper))

;; 禁用启动屏幕（永远不显示欢迎界面）
(setq inhibit-startup-screen t)

;; 启用行号显示（绝对行号）
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'absolute) ; 设置为绝对行号

;; 设置默认字体大小
(set-face-attribute 'default nil :height 160) ; 16磅字体 (10pt=100, 16pt=160)

;; 启用代码语法高亮
(global-font-lock-mode t)

;; 包管理器初始化
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; 自动安装 use-package 如果不存在
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; 配置并启用 Gruvbox Light Soft 主题
(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-light-soft t)
  
  ;; 优化 Gruvbox 主题下的行号显示
  (set-face-attribute 'line-number nil
                      :foreground "#7c6f64"   ; 较暗的灰色
                      :background "#f2e5bc") ; 主题背景色
  (set-face-attribute 'line-number-current-line nil
                      :foreground "#427b58"   ; 柔和的绿色
                      :background "#ebdbb2"   ; 当前行背景
                      :weight 'bold))

;; 配置自动补全括号功能
(use-package elec-pair
  :ensure nil ; elec-pair 是内置包
  :hook (after-init . electric-pair-mode)
  :config
  (setq electric-pair-pairs '(
        (?\" . ?\")
        (?\{ . ?\})
        (?\( . ?\))
        (?\[ . ?\])
        (?\< . ?\>)
        (?' . ?')
        (?\` . ?\`)))
  (setq electric-pair-preserve-balance t) ; 保持括号平衡
  (setq electric-pair-delete-adjacent-pairs t) ; 删除相邻括号
  (setq electric-pair-open-newline-between-pairs t) ; 在括号间换行时自动缩进
  (setq electric-pair-skip-whitespace t) ; 跳过空格

  ;; 自定义括号颜色以匹配 Gruvbox 主题
  (set-face-attribute 'show-paren-match nil
                      :background "#8ec07c" ; 柔和的绿色
                      :foreground "#3c3836") ; 深灰色
  (set-face-attribute 'show-paren-mismatch nil
                      :background "#fb4934" ; 红色
                      :foreground "#3c3836")) ; 深灰色

;; 启用括号匹配高亮
(show-paren-mode t)
(setq show-paren-delay 0) ; 立即显示匹配

;; 配置 Ivy 插件
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        enable-recursive-minibuffers t))

(use-package counsel
  :ensure t
  :after ivy
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x b" . counsel-switch-buffer)))

;; 配置 Company 自动补全
(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉

(use-package company-box
  :ensure t
  :if window-system
  :hook (company-mode . company-box-mode))
  

;; 可选：增强编程体验
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode)
  :config
  ;; 自定义彩虹括号颜色以匹配 Gruvbox 主题
  (setq rainbow-delimiters-colors
        '("#b57614" "#427b58" "#076678" "#8f3f71" 
          "#af3a03" "#79740e" "#d65d0e" "#b16286")))

(use-package which-key
  :ensure t
  :config (which-key-mode))

;; 保存历史记录
(savehist-mode 1)

;; 优化垃圾回收提高启动速度
(setq gc-cons-threshold (* 50 1000 1000))
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold (* 2 1000 1000))))

;; 其他视觉优化
(setq frame-title-format "%b - Emacs") ; 设置窗口标题
(setq visible-bell t) ; 使用视觉提示代替声音提示
(menu-bar-mode -1)    ; 禁用菜单栏
(tool-bar-mode -1)    ; 禁用工具栏
(scroll-bar-mode -1)  ; 禁用滚动条

(provide 'init)
;; 配置文件结束
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
