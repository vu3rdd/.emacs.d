(require 'init-elpa)

(require-package 'go-mode)

(add-to-list 'exec-path "~/go/bin")

(defun go-mode-setup ()
  (go-eldoc-setup)
  (add-hook 'before-save-hook 'gofmt-before-save))

(add-hook 'go-mode-hook 'go-mode-setup)

(setq gofmt-command "goimports")

(provide 'init-go)
