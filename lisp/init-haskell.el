(require 'init-elpa)
(require-package 'haskell-mode)
(require-package 'company)
(require-package 'company-ghci)
(require-package 'dante)

;; (require-package 'intero)
;; (add-hook 'haskell-mode-hook 'intero-mode)
;; (intero-global-mode 1)

;; dante
(add-hook 'haskell-mode-hook 'dante-mode)
(add-hook 'dante-mode-hook
          '(lambda ()
             (flycheck-add-next-checker 'haskell-dante
                                        '(warning . haskell-hlint))))

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
;; '(haskell-process-type 'stack-ghci))

;; load file - M-x haskell-process-load-file, haskell-process-reload
(eval-after-load "haskell-mode"
  '(progn
     '(define-key interactive-haskell-mode-map (kbd "M-.") 'haskell-mode-goto-loc)
     '(define-key interactive-haskell-mode-map (kbd "C-c C-t") 'haskel-mode-show-type-at)))

;; stack or cabal-install? stack for now
;;(setq haskell-compile-cabal-build-command "stack build")

(eval-after-load "haskell-mode"
  '(progn
     '(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
     '(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
     '(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
     '(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
     '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     '(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
     '(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)))

;; company-ghci
(push 'company-ghci company-backends)
(add-hook 'haskell-mode-hook 'company-mode)

(add-hook 'haskell-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (append '((company-capf company-dabbrev-code))
                         company-backends))))

;;; To get completions in the REPL
;;(add-hook 'haskell-interactive-mode-hook 'company-mode)

(provide 'init-haskell)
