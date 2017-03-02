(require 'package)
(require 'cl)

;; GNU TLS fix
;; -----------

(if (fboundp 'gnutls-available-p)
    (fmakunbound 'gnutls-available-p))

(setq tls-program '("gnutls-cli --tofu -p %p %h")
      imap-ssl-program '("gnutls-cli --tofu -p %p %s")
      smtpmail-stream-type 'starttls
      starttls-extra-arguments '("--tofu")
      )

;; More details: https://github.com/nicferrier/elmarmalade/issues/55#issuecomment-166271364

;; archive repositories
;; --------------------

(setq package-archives
      '(("melpa-stable" . "http://stable.melpa.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")))

(setq package-archive-priorities
      '(
        ("gnu" . 4)
        ("melpa-stable" . 3)
        ("melpa" . 2)
        ("marmalade" . 1)
        ))

(setq package-enable-at-startup nil)
(package-initialize)

;; Utils
;; -----

(defun setup-coq-keys ()
  (evil-define-key 'normal coq-mode-map
    (kbd "M-l") 'proof-goto-point
    (kbd "M-k") 'proof-undo-last-successful-command
    (kbd "M-j") 'proof-assert-next-command-interactive
    )
  (evil-define-key 'insert coq-mode-map
    (kbd "M-l") 'proof-goto-point
    (kbd "M-k") 'proof-undo-last-successful-command
    (kbd "M-j") 'proof-assert-next-command-interactive
    )
  )

(defun ignore-error-wrapper (fn)
  "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
  (lexical-let ((fn fn))
    (lambda ()
      (interactive)
      (ignore-errors
        (funcall fn)))))


;; use-package init
;; --------------------

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(require 'diminish)

;; package list and config
;; --------------------

(use-package evil
  :ensure t)                    ;; evil-mode

(use-package key-chord
  :ensure t)                    ;; key-chord - library for mangaging kbd bindings

(use-package magit                    ;; git bindings
  :ensure t
  :commands magit-status
  :config
  (progn
    (magit-auto-revert-mode 1))
  :init
  (add-hook 'magit-mode-hook 'magit-load-config-extensions))

(use-package git-commit
  :ensure t
  :defer t
  :config
  (progn
    (setq git-commit-summary-max-length 72)))

(use-package grandshell-theme
  :ensure t)

(use-package focus
  :ensure t)

(use-package spu
  :ensure t
  :defer 5 ;; defer package loading for 5 second
  :config (spu-package-upgrade-daily))

(use-package smooth-scrolling
  :ensure t)

(use-package projectile               ;; source control
  :ensure t
  :commands (projectile-switch-project-by-name projectile-find-file)
  :init
  (projectile-global-mode t))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode))

;; The package is "python" but the mode is "python-mode":
(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode))

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("M-<f5>" . helm-find-files)
         ([f10] . helm-buffers-list)
         ([S-f10] . helm-recentf)))

(use-package markdown-mode
  :ensure t
  :mode "\\.md\\'")

;; Init Agda
(let* (
       (agda-mode-locate (shell-command-to-string "agda-mode locate"))
       (load-path (file-name-directory agda-mode-locate)))
  (defconst agda2-load-path load-path))

(use-package agda2
  :load-path agda2-load-path
  :mode ("\\.agda\\'" . agda2-mode)
  :config
  (add-hook 'agda2-mode-hook (lambda () (add-hook 'evil-insert-state-entry-hook (lambda () (set-input-method "Agda"))))))

(use-package proof-site
  :load-path ("~/.emacs.d/lisp/PG/generic")
  :mode ("\\.v\\'" . coq-mode)
  :config
  (setup-coq-keys)

  ;; Hybrid mode by default
  (setq-default proof-three-window-mode-policy 'hybrid)

  ;; no splash screen
  (setq proof-splash-seen t)
  )

(use-package json-mode
  :mode "\\.json\\'"
  :ensure t)

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'"
         "\\.js\\'"
         "\\.css\\'"
         "\\.jsx\\'"
         "\\.php\\'")
  :config
  (setq-default web-mode-markup-indent-offset 2))

(use-package yaml-mode
  :mode "\\.yaml\\'"
  :ensure t)

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :ensure t
  :init (add-hook 'pdf-view-mode-hook 'pdf-view-fit-page-to-window))

(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package hindent
  :ensure t
  :commands hindent-mode)

(use-package ghc
  :ensure t
  :commands ghc-init ghc-debug)

(use-package haskell-mode
  :ensure t
  :mode "\\.hs\\'"
  :commands haskell-mode
  :config
  (custom-set-variables
   '(haskell-ask-also-kill-buffers nil)
   '(haskell-process-type (quote stack-ghci))
   '(haskell-interactive-popup-errors nil))

  (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'hindent-mode)
  (add-hook 'haskell-mode-hook (lambda ()
                                 (add-hook 'before-save-hook 'haskell-mode-format-imports nil t)
                                 (add-hook 'before-save-hook 'hindent-reformat-buffer)))
  )

(use-package nlinum
  :ensure t)

(use-package nlinum-relative
  :ensure t
  :config
  (nlinum-relative-setup-evil)
  (setq nlinum-relative-redisplay-delay 0.01)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode))

(use-package powerline
  :ensure t
  :config (powerline-vim-theme))

(use-package smex
  :ensure t
  :config (smex-initialize)
  :bind (
         ("M-x" . smex)
         ("M-X" . smex-major-mode-commands)
         ("C-c M-x" . execute-extended-command)
         )
  )

;; Evil mode
;; ----------

;; Turn on evil mode
(require 'evil)
(evil-mode t)

;; Key bindings
(define-key evil-normal-state-map (kbd ";") 'evil-ex)

(setq key-chord-two-keys-delay 1.0)
(key-chord-define evil-insert-state-map (kbd "jj") 'evil-normal-state)

(key-chord-mode t)

;; Company mode
;; -------------

(use-package company
  :ensure t
  :diminish company-mode
  :defer 2
  :bind ("C-<tab>" . company-complete)
  :config
  (global-company-mode t)
  (push 'company-rtags company-backends))

(use-package company-coq
  :ensure t
  :commands (company-coq-mode)

  :init
  (add-hook 'coq-mode-hook 'company-coq-mode t)
  (setq company-coq-features/prettify-symbols-in-terminals t)

  :config
  ;; Fix parse faillure on Coq 8.6
  ;; https://github.com/cpitclaudel/company-coq/issues/126
  (defconst company-coq-tg--preprocessor-substitutions
    '(
      ("\n"  . " ")
      ("[ "  . "( OR-GROUP ")
      (" ]"  . " )")
      (" | " . " OR ")
      ("; "  . " AND ")
      ("'" . "’")))
  )

;; Flycheck mode
;; --------------

(use-package flycheck                 ;; syntax check
  :ensure t
  :defer 2
  :diminish flycheck-mode
  :config
  (progn
    (global-flycheck-mode)
    (setq-default flycheck-disabled-checkers '(coq c/c++-clang c/c++-gcc flycheck-rtags))
    (setq flycheck-emacs-lisp-load-path 'inherit)))

(use-package flycheck-package
  :ensure t
  :defer t)

(use-package flycheck-haskell
  :ensure t
  :commands flycheck-haskell-setup)

;; Helm-mode
;; ----------

;; settings
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)

;; Turn helm on
(helm-mode 1)

;; Windmove config
;; ----------------

(windmove-default-keybindings 'meta)

(global-set-key (kbd "C-h") (ignore-error-wrapper 'windmove-left))
(global-set-key (kbd "C-l") (ignore-error-wrapper 'windmove-right))
(global-set-key (kbd "C-k") (ignore-error-wrapper 'windmove-up))
(global-set-key (kbd "C-j") (ignore-error-wrapper 'windmove-down))

(use-package framemove
  :ensure t
  :config (setq framemove-hook-into-windmove t))

;; User config
;; ------------

(load-theme 'grandshell t)

;; Cursor
(blink-cursor-mode t)
(setq blink-cursor-interval 0.8)

(setq cursor-type 'bar)

;; Turn on line numbers
(global-nlinum-mode t)
(setq nlinum-format "%4d \u2502 ")

(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

;; show matching parentheses
(show-paren-mode t)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; Remove useless whitespaces before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; don't show trailing whitespace, is already fixed on save
(setq-default show-trailing-whitespace nil)

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1)) ; turn off the menubar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1)) ; turn off the toolbar

(fset 'yes-or-no-p 'y-or-n-p)
(set-default 'indent-tabs-mode nil) ; use spaces for indenting, not tabs

;; Save clipboard contents into kill-ring before replace them
(setq save-interprogram-paste-before-kill t)

;; disable backup
(setq backup-inhibited t)

;; enables interaction with system clipboard
(setq x-select-enable-clipboard t)

;; Misc
(setq
 inhibit-startup-message   t   ; Don't want any startup message
 redisplay-dont-pause t
 search-highlight           t ; Highlight search object
 query-replace-highlight    t ; Highlight query object
 mouse-sel-retain-highlight t ; Keep mouse high-lightening
 read-file-name-completion-ignore-case t
 x-select-enable-clipboard t
 x-select-enable-primary t
 save-interprogram-paste-before-kill t
 apropos-do-all t
 scroll-error-top-bottom t ; move to farthest point when not able to move up or down enough lines
 read-buffer-completion-ignore-case t
 completion-auto-help 'lazy
 isearch-resume-in-command-history t
 kill-read-only-ok t
 isearch-allow-scroll t
 color-theme-is-global t
 sentence-end-double-space nil
 mouse-yank-at-point t
 whitespace-style '(face trailing lines-tail tabs)
 whitespace-line-column 80
 )

;; default to utf8
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
