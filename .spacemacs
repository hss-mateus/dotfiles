(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     helm
     auto-completion
     emacs-lisp
     git
     markdown
     org
     shell
     syntax-checking
     version-control
     c-c++
     html
     java
     javascript
     ocaml
     python
     racket
     react
     ruby
     rust
     scheme
     shell-scripts
     sml
     themes-megapack
     typescript
     )
   dotspacemacs-additional-packages '(nord-theme)
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(company-tern)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update t
   dotspacemacs-editing-style 'vim
   dotspacemacs-startup-banner 'random
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-themes '(nord)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Hasklug Nerd Font"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-visual-line-move-text t
   dotspacemacs-fullscreen-at-startup 1
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-line-numbers 'relative
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
  )

(defun dotspacemacs/user-config ()
  (global-aggressive-indent-mode)
  (setq js2-strict-missing-semi-warning nil)
  (setq js2-missing-semi-one-line-override t)
  )
