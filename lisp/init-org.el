;; org-mode
(setq org-todo-keywords
      '((sequence "TODO(t)" "INPROGRESS(p)" "WAITING(w)" "|" "DONE" "CANCELLED")))

(setq org-directory "~/src/org")

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; key shortcut for org-agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;; setup org-capture with templates
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

;; force UTF-8
(setq org-export-coding-system 'utf-8)

;; quick default note file
(global-set-key (kbd "C-c o")
                (lambda () (interactive) (find-file "~/src/org/index.org")))

;; configure org-capture templates
(setq org-capture-templates
      '(
        ;; journal
        ("j"                 ;; hotkey
         "Journal Entry"     ;; name
         entry               ;; type
         ;; heading type and title
         (file+datetree (concat org-directory "/journal.org"))
         "* %T %?" :empty-lines 1) ;; template
        ;; todo
	("t"               
         "Todo list item"
         entry
         (file+headline org-default-notes-file "Tasks")
         "* TODO %?\n %i\n %a") ;; template
        ("l"
         "Links to interesting posts"
         entry
         (file+datetree (concat org-directory "/links.org"))
         "* %T %?")
	))

(provide 'init-org)
