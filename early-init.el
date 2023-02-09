;;; ui bits
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; (global-linum-mode t)
(global-display-line-numbers-mode)

;; font
(cond ((find-font (font-spec :name "Noto Mono"))
       (set-face-attribute 'default nil
                           :family "Noto Mono"
                           :height 120)
       (find-font (font-spec :name "mononoki"))
       (set-face-attribute 'default nil
		           :family "mononoki"
		           :height 120
		           :weight 'normal
		           :width  'normal)
      ))
