;;; emacs-lisp
(package-initialize)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; .el files not obtainable from pkg manager
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; (require 'init-elpa)
(require 'package)

(defun require-package (package)
  "Install given PACKAGE if it was not installed before."
  (if (package-installed-p package)
      t
    (progn
      (unless (assoc package package-archive-contents)
	(package-refresh-contents))
      (package-install package))))

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;;; use-package
(require-package 'use-package)
(setq use-package-always-ensure t)

;;; backup files
;;; https://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;;; ui bits
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(global-linum-mode t)

(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      column-number-mode t
      ns-command-modifier 'meta
      initial-frame-alist '((fullscreen . maximized)))

(blink-cursor-mode 0)
(setq-default cursor-type '(bar . 2))
(set-cursor-color "#ff0000")
(setq ring-bell-function 'ignore)

;;; font
(set-default-font "DejaVu Sans Mono-11")

;; theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'acme t)

;; encoding
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; show matching parens
(show-paren-mode 1)

;; y-or-n instead of yes-or-no
(defalias 'yes-or-no-p 'y-or-n-p)

;; highlight current line
(global-hl-line-mode 1)

;; turn off colours in terminal mode
(add-to-list 'default-frame-alist '(tty-color-mode . -1))

;;; navigation bits
(use-package ido
  :config
  (ido-mode 1))

(use-package projectile
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))

;;; misc
(use-package exec-path-from-shell)

(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package which-key
  :config
  (which-key-mode))

(use-package dumb-jump
  :config
  (dumb-jump-mode))

(use-package nov
  :init
  (setq nov-text-width 80)
  (setq visual-fill-column-center-text t)
  (defun my-nov-font-setup ()
    (face-remap-add-relative 'variable-pitch :family "Liberation Serif-14"
                             :height 1.0))
  (add-hook 'nov-mode-hook 'my-nov-font-setup)
  (add-to-list 'auto-mode-alist '("\\.epub$" . nov-mode)))

;; global key binding for align-regexp
(global-set-key (kbd "C-x a r") 'align-regexp)

;; disable tabs for indentation
(setq-default indent-tabs-mode nil)

;; alias man to w.o.man
(defalias 'man 'woman)

(when (string-equal system-type "darwin")
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
    (setq exec-path-from-shell-check-startup-files nil)))

;;; rust mode
(use-package racer)
(use-package flycheck)
(use-package flycheck-rust)
(use-package cargo)
(use-package rust-mode
  :init
  (add-hook 'rust-mode-hook  #'company-mode)
  (add-hook 'rust-mode-hook  #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  (add-hook 'rust-mode-hook
            '(lambda ()
               (local-set-key (kbd "TAB") #'company-indent-or-complete-common)
               (electric-pair-mode 1))))

;;;  magit
(use-package magit
  :init
  (global-set-key (kbd "C-x g") 'magit-status))


;;; haskell
(use-package haskell-mode)
(use-package flymake)

;; (use-package dante
;;   :ensure t
;;   :after haskell-mode
;;   :commands 'dante-mode
;;   :init
;;   (add-hook 'haskell-mode-hook 'flycheck-mode)
;;   (add-hook 'haskell-mode-hook 'dante-mode)
;;   (setq dante-repl-command-line '("cabal" "repl" dante-target "--builddir=dist/dante")))

(setq flycheck-check-syntax-automatically '(save mode-enabled))

;; LSP
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package yasnippet
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook (haskell-mode . lsp)
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package lsp-haskell
 :ensure t
 :config
 (setq lsp-haskell-process-path-hie "ghcide")
 (setq lsp-haskell-process-args-hie '())
 ;; Comment/uncomment this line to see interactions between lsp client/server.
 (setq lsp-log-io t)
)

;;; C
(setq c-default-style "linux"
      c-basic-offset 4)

;;; Go
(use-package go-mode
  :config
  (add-to-list 'exec-path "~/go/bin")
  (add-hook 'go-mode-hook
            '(lambda ()
               (go-eldoc-setup)
               (add-hook 'before-save-hook 'gofmt-before-save)))
  (setq gofmt-command "goimports"))

;;; erc
(use-package tls)
(use-package erc
  :init
  (load "~/secrets/ercpass.el")
  (require 'erc-services)
  (erc-services-mode 1)
  :config
  (erc-autojoin-mode)
  (setq erc-prompt-for-nickserv-password nil)
  (setq erc-nickserv-passwords
        `((freenode     (("rkrishnan" . ,freenode-rkrishnan-pass)))))
  (setq erc-autojoin-channels-alist
        '(;; (".*\\.freenode.net" "#haskell" "#tahoe-lafs" "#magic-wormhole")
          ;; (".*\\.oftc.net" "#leastauthority")
          ;; (".*\\.mozilla.org" "#rust-beginners")
          ))
  ;; check channels
  (erc-track-mode t)
  (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                  "324" "329" "332" "333" "353" "477"))
  ;; don't show any of this
  (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
  (defun start-erc ()
    "Connect to IRC."
    (interactive)
    (when (y-or-n-p "Do you want to start IRC? ")
      (erc-tls :server "rkrishnan.org" :port 6697 :nick "rkrishnan" :password znc-pass)))
      ;; (erc-tls :server "irc.mozilla.org" :port 6697 :nick "rkrishnan" :full-name "Ramakrishnan Muthukrishnan")
      ;; (erc-tls :server "irc.freenode.net" :port 6697 :nick "rkrishnan" :full-name "Ramakrishnan Muthukrishnan")))
  ;; (erc-tls :server "irc.oftc.net" :port 6697 :nick "rkrishnan" :full-name "Ramakrishnan Muthukrishnan")))
  :bind
  ("C-c e" . start-erc))

;;; org-mode
(use-package org
  :config
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
          )))

(use-package org-journal
  :requires org
  :config
  (setq org-journal-dir "~/projects/journal/")
  (setq org-journal-file-format "%Y-%m-%d.org")
  (setq org-journal-enable-agenda-integration t))

;; idris
(use-package idris-mode)

;;; ocaml
(use-package tuareg)

;;; org mode based presentations
(use-package org-tree-slide
  :requires org
  :config
  (when (require 'org-tree-slide nil t)
    (global-set-key (kbd "<f8>") 'org-tree-slide-mode)
    (global-set-key (kbd "S-<f8>") 'org-tree-slide-skip-done-toggle)))

;; eshell
(setenv "TERM" "dumb")
(use-package helm-eshell
  :init
  (add-hook 'eshell-mode-hook
            (lambda ()
              (eshell-cmpl-initialize)
              (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
              (define-key eshell-mode-map (kbd "M-s f") 'helm-eshell-prompts-all)))
  :config
  (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-tree-slide tuareg idris-mode org-journal go-mode dante haskell-mode magit cargo flycheck-rust flycheck racer nov dumb-jump which-key company exec-path-from-shell projectile use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
