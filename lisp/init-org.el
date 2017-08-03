;; org-mode
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(p)" "WAITING(w)" "|" "DONE" "CANCELLED")))

(setq org-agenda-files '("~/org/"))

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; key shortcut for org-agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;; capture template for journal
(setq org-capture-templates
      '(
	("j" "Journal Entry"
         entry (file+datetree "~/org/journal.org")
         "* %T %?"
         :empty-lines 1)
	;; ("t" "TODO"
	;;  entry (file+headline "~/org/todo.org" "Tasks")
	;;  "* TODO %?")
	))

(provide 'init-org)
