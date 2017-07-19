;; erc
(require 'erc)
(require 'tls)
;; (setq tls-program '("openssl s_client -connect %h:%p -no_ssl2 -ign_eof"))

(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '((".*\\.freenode.net" "#haskell-beginners" "#tahoe-lafs")
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
    ;; (erc-tls :server "irc.mozilla.org" :port 6697 :nick "rkrishnan" :full-name "Ramakrishnan Muthukrishnan")
    (erc-tls :server "irc.freenode.net" :port 6697 :nick "rkrishnan" :full-name "Ramakrishnan Muthukrishnan")))
    ;; (erc-tls :server "irc.oftc.net" :port 6697 :nick "rkrishnan" :full-name "Ramakrishnan Muthukrishnan")))

;; switch to ERC with Ctrl+c e
(global-set-key (kbd "C-c e") 'start-erc) ;; ERC

(provide 'init-erc)
