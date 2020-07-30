(setq user-full-name            "Mateus Henrique"
      user-mail-address         "hss-mateus@tuta.io"
      doom-theme                'doom-one
      org-directory             "~/dev/org"
      display-line-numbers-type t)

(use-package! xclip-mode
  :hook (tty-setup . xclip-mode))

(use-package! evil-terminal-cursor-changer
  :hook (tty-setup . evil-terminal-cursor-changer-activate))
