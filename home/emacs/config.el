;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name  "hss-mateuss"
      user-mail-address "hss-mateus@proton.me"
      doom-theme 'catppuccin
      org-directory "~/dev/org/"
      display-line-numbers-type 'relative
      confirm-kill-emacs nil
      lsp-disabled-clients '(rubocop-ls typeprof-ls ruby-syntax-tree-ls rubocop-ls-tramp typeprof-ls-tramp ruby-syntax-tree-ls-tramp)
      lsp-sorbet-use-bundler t
      lsp-ruby-lsp-use-bundler t
      lsp-ui-sideline-enable nil
      shell-file-name (executable-find "bash")
      vterm-shell (executable-find "fish")
      projectile-rails-vanilla-command "bin/rails"
      projectile-rails-spring-command "bin/spring"
      projectile-rails-custom-console-command "bin/rails c"
      projectile-rails-custom-server-command "bin/dev"
      enable-remote-dir-locals t)

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

(after! projectile-rails
  (defun sorbet-typecheck ()
    "Typecheck project using sorbet and spoom."
    (interactive)
    (let ((default-directory (projectile-project-root)))
      (compile "bundle exec spoom srb tc -f '%F:%L: %C - %M'")))

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
  (bind-key "u" 'projectile-rails-find-use-case 'projectile-rails-command-map)

  (defun projectile-rails-console (arg)
    "Start a rails console, asking for which if ARG is not nil."
    (interactive "P")
    (projectile-rails-with-root
     (let ((rails-console-command (projectile-rails--command
                                   :custom projectile-rails-custom-console-command
                                   :spring (concat projectile-rails-spring-command " rails console")
                                   :zeus "zeus console"
                                   :vanilla (concat projectile-rails-vanilla-command " console"))))

       (with-demoted-errors "Error: %S"
         (inf-ruby-console-run
          (if (>= (or (car arg) 0) 4)
              (read-string "rails console: " rails-console-command)
            rails-console-command)
          "rails"))
       (projectile-rails-mode +1)))))

(after! tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))

(require 'lsp)
(require 'lsp-sorbet)

(lsp-register-client
 (make-lsp-client
  :add-on? t
  :new-connection (lsp-stdio-connection '("bundle" "exec" "srb" "typecheck" "--lsp" "--enable-all-beta-lsp-features"))
  :initialization-options '(:highlightUntyped "everywhere"
                            :supportsSorbetURIs t
                            :enableTypedFalseCompletionNudges :json-false)
  :priority -2
  :activation-fn (lsp-activate-on "ruby")
  :server-id 'sorbet-ls))

(after! lsp-mode
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)
  (advice-add (if (progn (require 'json)
                         (fboundp 'json-parse-buffer))
                  'json-parse-buffer
                'json-read)
              :around
              #'lsp-booster--advice-json-parse))

(after! crystal-mode
  (add-hook 'crystal-mode-hook #'lsp! 'append))

(add-to-list 'auto-mode-alist '("\\.rbi\\'" . ruby-mode))
