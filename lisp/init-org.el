;; org-mode
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(p)" "WAITING(w)" "|" "DONE" "CANCELLED")))

(setq org-agenda-files '("~/src/org/"))

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; key shortcut for org-agenda
(global-set-key (kbd "C-c a") 'org-agenda)

(provide 'init-org)
