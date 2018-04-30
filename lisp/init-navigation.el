(require 'init-elpa)

(require-package 'ido)
(ido-mode 1)

(require-package 'projectile)

(projectile-global-mode)
(setq projectile-completion-system 'ivy)

;; Enable move point from window to window using Shift and the arrow keys
;; (windmove-default-keybindings)

;; (global-set-key (kbd "C-x C-b") 'ibuffer)

(require-package 'neotree)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(provide 'init-navigation)
