(require 'init-elpa)
(require-package 'atom-one-dark-theme)
;;(require-package 'golden-ratio)

;;(require 'golden-ratio)

(setq inhibit-startup-message t)
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;;(set-face-attribute 'default nil :height 140)
;;(setq-default line-spacing 0.4)

(global-linum-mode t)

(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      column-number-mode t
      ns-command-modifier 'meta
      initial-frame-alist '((fullscreen . maximized)))

;;(load-theme 'atom-one-dark t)

(blink-cursor-mode 0)
(setq-default cursor-type 'bar)
(set-cursor-color "#cccccc")
(setq ring-bell-function 'ignore)

;;(golden-ratio-mode 1)

;; encoding
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; show matching parens
(show-paren-mode 1)

;; y-or-n instead of yes-or-no
(defalias 'yes-or-no-p 'y-or-n-p)

(provide 'init-ui)
