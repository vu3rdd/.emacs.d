;;; emacs-lisp --- ram:
;; no longer needed on emacs27
;;(package-initialize)
(require 'package)

;;; ui bits
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      column-number-mode t
      ns-command-modifier 'meta
      initial-frame-alist '((fullscreen . maximized)))

(global-linum-mode t)
(blink-cursor-mode 0)
(setq-default cursor-type '(bar . 2))
(set-cursor-color "#ff0000")
(setq ring-bell-function 'ignore)

;; set title
;; (setq frame-title-format
;;   (concat "%b - emacs@" (system-name)))
;; (setq-default frame-title-format '("%f [%m]"))
(setq frame-title-format "emacs")

;;; font
;; (set-default-font "DejaVu Sans Mono-13")
;; (set-face-attribute 'default t :font "DejaVu Sans Mono-16")
(set-face-attribute 'default nil
		    :family "DejaVu Sans Mono"
		    :height 105
		    :weight 'normal
		    :width  'normal)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; .el files not obtainable from pkg manager
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

(load "~/.emacs.d/early-init.el")

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
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

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

;; python mode
(defun my-python-hook ()
  (define-key python-mode-map (kbd "RET") 'newline-and-indent))

; XXX add "fill-paragragh" (M-q) hook
(add-hook 'python-mode-hook 'my-python-hook)
(add-hook 'python-mode-hook 'electric-indent-mode)


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

;; (use-package company
;;   :init
;;   (add-hook 'after-init-hook 'global-company-mode)
;;   :config
;;   (setq company-minimum-prefix-length 1
;;         company-idle-delay 0.0) ;; default is 0.2
;;   )

(use-package which-key
  :config
  (which-key-mode))

(use-package dumb-jump
  :config
  (dumb-jump-mode))

(use-package nov
  :init
  (add-to-list 'auto-mode-alist '("\\.epub$" . nov-mode))
  :config
  ;; (setq nov-text-width 80)
  (defun my-nov-font-setup ()
    (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                             :height 1.0))
  (add-hook 'nov-mode-hook 'my-nov-font-setup))

;; global key binding for align-regexp
(global-set-key (kbd "C-x a r") 'align-regexp)

;; disable tabs for indentation
(setq-default indent-tabs-mode nil)
(setq tab-width 2)

;; alias man to w.o.man
(defalias 'man 'woman)

(when (string-equal system-type "darwin")
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
    (setq exec-path-from-shell-check-startup-files nil)))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))
(use-package yasnippet
  :ensure t)

;;; rust mode
(use-package cargo)
(use-package rust-mode
  :init
  (add-hook 'rust-mode-hook  #'company-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (add-hook 'rust-mode-hook
            '(lambda ()
               (local-set-key (kbd "TAB") #'company-indent-or-complete-common)
               (electric-pair-mode 1))))

;;;  magit
(use-package magit
  :init
  (global-set-key (kbd "C-x g") 'magit-status)
  :config
  (setq magit-diff-refine-hunk 'all))


;; ;;; haskell
;; (use-package flycheck-haskell
;;   :init
;;   (add-hook 'haskell-mode-hook #'flycheck-haskell-setup))

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((haskell-mode . (lsp lsp-deferred))
         (go-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :hook ((lsp-mode . lsp-ui-mode)
         (lsp-mode . flycheck-mode))
  :config
  (setq lsp-prefer-flymake nil)
  :commands lsp-ui-mode)

(use-package haskell-mode
  :ensure t
  :init
  (progn
    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
    (setq haskell-process-args-cabal-new-repl
	  '("--ghc-options=-ferror-spans -fshow-loaded-modules"))
    (setq haskell-process-type 'cabal-new-repl)
    ;; (setq haskell-stylish-on-save 't)
    (setq haskell-mode-stylish-haskell-path "ormolu")
    (setq haskell-tags-on-save 't)
    ))

;;; use flycheck instead of flymake (to avoid process flood)
(use-package flycheck)
;; https://gist.github.com/purcell/ca33abbea9a98bb0f8a04d790a0cadcd

(require 'lsp)
(use-package lsp-haskell
 :ensure t
 :config
 (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
 (setq lsp-log-io t)
 )

(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

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
;; (use-package tls)
(use-package erc
  :init
  (load "~/secrets/ercpass.el")
  (require 'erc-services)
  (erc-services-mode 1)
  :config
  (erc-autojoin-mode)
  (setq erc-prompt-for-nickserv-password nil)
  (setq erc-nickserv-passwords
        `((libera     ((,libera-username1 . ,libera-user1-pass)))))
  (setq erc-autojoin-channels-alist
        '((".*\\.libera.chat" "#haskell" "#tahoe-lafs" "#magic-wormhole")
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
      (erc-tls :server "irc.libera.chat" :port 6697 :nick "rkrishnan" :full-name "Ramakrishnan Muthukrishnan")))
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

(use-package restclient)

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
(use-package helm
  :requires eshell
  :init
  (add-hook 'eshell-mode-hook
            (lambda ()
              (eshell-cmpl-initialize)
              (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
              (define-key eshell-mode-map (kbd "M-s f") 'helm-eshell-prompts-all)))
  :config
  (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history))

;; nix mode
(use-package nix-mode
  :mode "\\.nix\\'")

;; c# mode
;; (use-package csharp-mode)

;; python docstring
(use-package python-docstring)

;; agda-mode
(setq auto-mode-alist
   (append
     '(("\\.agda\\'" . agda2-mode)
       ("\\.lagda.md\\'" . agda2-mode))
     auto-mode-alist))

;; mononoki font
;; default to mononoki
;; (set-face-attribute 'default nil
;; 		    :family "mononoki"
;; 		    :height 120
;; 		    :weight 'normal
;; 		    :width  'normal)

(use-package mastodon
  :ensure t
  :config
  (setq mastodon-instance-url "https://mastodon.radio")
  (setq mastodon-auth-source "~/authinfo")
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" default))
 '(org-agenda-files '("~/src/org/todo.org"))
 '(package-selected-packages
   '(elpher tls mastodon python-docstring-mode python-docstring color-theme-sanityinc-tomorrow csharp-mode agda-mode restclient rest-client attrap deferred nix-mode org-tree-slide tuareg idris-mode org-journal go-mode dante haskell-mode magit cargo flycheck-rust flycheck racer nov dumb-jump which-key company exec-path-from-shell projectile use-package))
 '(verilog-auto-indent-on-newline t)
 '(verilog-auto-newline nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

;; UTF-8 support
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; align expressions at '='
(defun align-on-equals ()
  (interactive)
  (save-excursion
    (mark-paragraph)
    (align-regexp (point) (mark) "\\(\\s-*\\)=")))

(global-set-key (kbd "C-=") 'align-on-equals)

;; agda
;; auto-load agda-mode for .agda and .lagda.md
(setq auto-mode-alist
      (append
       '(("\\.agda\\'" . agda2-mode)
         ("\\.lagda.md\\'" . agda2-mode))
       auto-mode-alist))

;; agda2-mode hook
(defun my-agda-hook ()
  (set-input-method 'Agda))

(add-hook 'agda2-mode-hook 'my-agda-hook)

(when (daemonp)
  (exec-path-from-shell-initialize))
