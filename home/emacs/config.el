;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(require 'info)
(defvar Info-directory-list)

(setq user-full-name "hss-mateus"
      user-mail-address "hss-mateus@proton.me"
      doom-theme 'catppuccin
      org-directory "~/dev/org/"
      display-line-numbers-type 'relative
      confirm-kill-emacs nil
      lsp-disabled-clients '(rubocop-ls typeprof-ls ruby-syntax-tree-ls rubocop-ls-tramp typeprof-ls-tramp ruby-syntax-tree-ls-tramp)
      lsp-sorbet-as-add-on t
      projectile-enable-caching t
      projectile-indexing-method 'alien
      lsp-ui-sideline-enable nil
      shell-file-name (executable-find "bash")
      vterm-shell (executable-find "fish")
      projectile-rails-vanilla-command "bin/rails"
      projectile-rails-spring-command "bin/spring"
      projectile-rails-custom-console-command "bin/rails c"
      projectile-rails-custom-server-command "bin/dev"
      enable-remote-dir-locals t
      custom-file "~/.config/emacs-custom.el")

(load custom-file)

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

(after! projectile-rails
  (defun sorbet-typecheck ()
    "Typecheck project using sorbet and spoom."
    (interactive)
    (let ((default-directory (projectile-project-root)))
      (compile "spoom srb tc -f '%F:%L: %C - %M'")))

  (map! :localleader
        :map 'ruby-mode-map
        "c" 'sorbet-typecheck)

  (defun projectile-rails-find-use-case ()
    "Find a use-case."
    (interactive)
    (projectile-rails-find-resource
     "use-case: "
     '(("app/use_cases/" "\\(.+?\\)\\.rb$"))
     "app/use_cases/\$\{filename}.rb"))
  (bind-key "u" 'projectile-rails-find-use-case 'projectile-rails-command-map))

(after! tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

(require 'lsp)
(require 'lsp-sorbet)

(lsp-register-client
 (make-lsp-client
  :add-on? t
  :new-connection (lsp-stdio-connection '("srb" "typecheck" "--lsp" "--enable-all-beta-lsp-features"))
  :initialization-options '(:highlightUntyped "everywhere"
                            :supportsSorbetURIs t
                            :enableTypedFalseCompletionNudges :json-false)
  :priority -2
  :activation-fn (lsp-activate-on "ruby")
  :server-id 'sorbet-ls))

(after! crystal-mode
  (add-hook 'crystal-mode-hook #'lsp! 'append))

(add-to-list 'auto-mode-alist '("\\.rbi\\'" . ruby-mode))

(add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.devenv\\'")
