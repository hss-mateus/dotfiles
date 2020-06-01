;; Decent defaults
(setq inhibit-startup-screen t
      make-backup-files nil
      create-lockfiles nil
      auto-save-default nil
      initial-scratch-message ""
      ring-bell-function 'ignore
      scroll-step 1
      scroll-conservatively 10000
      mouse-wheel-scroll-amount '(1 ((shift) . 1))
      mouse-wheel-progressive-speed nil)
(setq-default tab-width 2
              indent-tabs-mode nil)
(fset 'yes-or-no-p 'y-or-n-p)
(delete-selection-mode t)
(auto-save-mode -1)
(global-auto-revert-mode t)
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(unless package--initialized (package-initialize))

;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Shell environment variables
(use-package exec-path-from-shell :config (exec-path-from-shell-initialize))

;; Clear ui
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Basic ui elements
(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)
(show-paren-mode 1)
(setq-default frame-title-format '("%b"))

;; Default font
(set-frame-font "JetBrainsMono Nerd Font Mono 10" nil t)

;; Nord theme
(use-package nord-theme :config (load-theme 'nord t))

;; Fringe colors same as theme colors
(set-face-attribute 'fringe nil
                    :foreground (face-foreground 'default)
                    :background (face-background 'default))

;; Doom mode line
(use-package doom-modeline
  :init
  (doom-modeline-mode 1))

;; Which key mode
(use-package which-key :config (which-key-mode 1))

;; Auto-complete
(use-package company :config (global-company-mode 1))

;; Better company-mode visuals
(use-package company-box
  :hook (company-mode . company-box-mode))

;; Syntax checking
(use-package flycheck :config (global-flycheck-mode 1))

;; Language server client
(use-package eglot
  :hook (elm-mode . eglot-ensure))

;; Auto close characters
(use-package smartparens
  :config
  (sp-use-paredit-bindings)
  (add-hook 'prog-mode-hook #'smartparens-mode)
  (sp-pair "{" nil :post-handlers '(("||\n[i]" "RET"))))

;; Parens and indentation correction
(use-package parinfer
  :init
  (progn
    (setq parinfer-extensions '(defaults evil))
    (add-hook 'racket-mode #'parinfer-mode)))

;; Ivy completion engine
(use-package ivy :config (ivy-mode 1))

;; Projectile for project management
(use-package projectile :config (projectile-mode 1))

;; Integrate Ivy with Projectile
(use-package counsel-projectile :config (counsel-projectile-mode 1))

;; Evil mode
(use-package evil :config (evil-mode 1))

;; Global keybindings
(use-package general
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   ;; Buffers and frames
   "TAB" 'evil-switch-to-windows-last-buffer
   "bd" 'kill-buffer-and-window
   "wv" 'split-window-right
   "ws" 'split-window-below
   "wh" 'windmove-left
   "wj" 'windmove-down
   "wk" 'windmove-up
   "wl" 'windmove-right

   ;; Files
   "ff" 'counsel-find-file
   "pf" 'counsel-git
   "pp" 'counsel-projectile-switch-project
   ))

;; Standard ML support
(use-package sml-mode)

;; Racket support
(use-package racket-mode)

;; Elm support
(use-package elm-mode)
