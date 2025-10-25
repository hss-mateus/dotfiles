;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'catppuccin
      org-directory "~/dev/org/"
      display-line-numbers-type 'relative
      lsp-sorbet-as-add-on t
      lsp-ui-sideline-enable nil
      shell-file-name (executable-find "bash")
      vterm-shell (executable-find "fish")
      custom-file "~/.config/emacs-custom.el")

(load custom-file)

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

(projectile-rails-global-mode)

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

(add-to-list 'auto-mode-alist '("\\.rbi\\'" . ruby-mode))

(add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.devenv\\'")
