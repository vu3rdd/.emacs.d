(setq make-backup-files nil)

(require-package 'exec-path-from-shell)

;; global key binding for align-regexp
(global-set-key (kbd "C-x a r") 'align-regexp)

;; disable tabs for indentation
(setq-default indent-tabs-mode nil)

;; alias man to w.o.man
(defalias 'man 'woman)

(when (string-equal system-type "darwin")
  (when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)))

;; which key - type in partial keybinding to bring up a help text
(require-package 'which-key)

(which-key-mode)

(provide 'init-misc)
