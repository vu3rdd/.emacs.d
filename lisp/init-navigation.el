(require 'init-elpa)

(require-package 'ivy)
(require-package 'counsel)
(require-package 'swiper)
(require-package 'projectile)
(require-package 'counsel-projectile)

(require 'ivy)

;; enable ivy everywhere
(ivy-mode 1)

(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

(projectile-global-mode)
(setq projectile-completion-system 'ivy)
(counsel-projectile-on)

;; Enable move point from window to window using Shift and the arrow keys
;; (windmove-default-keybindings)

(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)

(provide 'init-navigation)
