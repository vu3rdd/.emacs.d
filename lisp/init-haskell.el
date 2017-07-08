(require 'init-elpa)
(require-package 'haskell-mode)
;;(require-package 'company-ghc)

(eval-after-load "haskell-mode"
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

;; auto-insert module template
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)

;; bind C-c C-c to haskel-compile (instead of compile)
(eval-after-load "haskell-mode"
  '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))

;; interactive minor mode
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; customizations of interactive mode
(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modes t)
 '(haskell-process-log t))

;; load file - M-x haskell-process-load-file, haskell-process-reload
(eval-after-load "haskell-mode"
  '(progn
     '(define-key interactive-haskell-mode-map (kbd "M-.") 'haskell-mode-goto-loc)
     '(define-key interactive-haskell-mode-map (kbd "C-c C-t") 'haskel-mode-show-type-at)))

(eval-after-load "haskell-mode"
  '(progn
     '(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
     '(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
     '(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
     '(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
     '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     '(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
     '(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)))


;; (let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
;;   (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
;;   (add-to-list 'exec-path my-cabal-path))
;; (custom-set-variables '(haskell-tags-on-save t))

;; (custom-set-variables
;;   '(haskell-process-suggest-remove-import-lines t)
;;   '(haskell-process-auto-import-loaded-modules t)
;;   '(haskell-process-log t))
;; (eval-after-load 'haskell-mode '(progn
;;   (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;;   (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;;   (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
;;   (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
;;   (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
;;   (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
;; (eval-after-load 'haskell-cabal '(progn
;;   (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;;   (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;;   (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;;   (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

;; (custom-set-variables '(haskell-process-type 'cabal-repl))

;; (eval-after-load 'haskell-mode
;;   '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
;; (eval-after-load 'haskell-cabal
;;   '(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))

;; (require 'company)
;; (add-hook 'haskell-mode-hook  #'company-mode)
;; (add-to-list 'company-backends #'company-ghc)
;; (custom-set-variables '(company-ghc-show-info t))
