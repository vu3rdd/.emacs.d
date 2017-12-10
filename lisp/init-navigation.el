(require 'init-elpa)

(require-package 'helm)
; (require-package 'counsel)
(require-package 'projectile)

(require 'helm-config)

;; (global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)

(helm-mode 1)

(projectile-global-mode)
(setq projectile-completion-system 'ivy)
;;(counsel-projectile-on)

;; Enable move point from window to window using Shift and the arrow keys
;; (windmove-default-keybindings)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(provide 'init-navigation)
