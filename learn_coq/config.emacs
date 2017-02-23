(require 'package)

;; archive repositories
;; --------------------
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa", "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable", "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("milkbox-melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

;; For loading proof general
(add-to-list 'load-path "~/.emacs.d/lisp/PG/generic/")

(setq package-archive-priorities '(("org" . 5)
                                   ("melpa-stable" . 4)
                                   ("milkbox-melpa-stable" . 3)
                                   ("melpa" . 2)
                                   ("gnu" . 1)
                                   ("marmalade" . 0)
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

(use-package smooth-scrolling
             :ensure t)

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

(use-package company
             :ensure t
             :diminish company-mode
             :defer 2
             :bind ("C-<tab>" . company-complete)
             :config
             (global-company-mode t)
             (push 'company-rtags company-backends))

(use-package markdown-mode
             :ensure t
             :mode "\\.md\\'")

(use-package proof-site
             :load-path ("~/.emacs.d/lisp/PG/generic")
             :mode ("\\.v\\'" . coq-mode)
             :config
             (setup-coq-keys)

             ;;; Hybrid mode by default
             (setq-default proof-three-window-mode-policy 'hybrid)

             ;; no splash screen
             (setq proof-splash-seen t)

             ;; Change colour scheme
             ;; (custom-set-faces
             ;;   '(proof-eager-annotation-face ((t (:background "medium blue"))))
             ;;   '(proof-error-face ((t (:background "dark red"))))
             ;;   '(proof-warning-face ((t (:background "indianred3"))))
             ;;   )

             )

(use-package company-coq
             :ensure t
             :commands (company-coq-mode)
             :init
             (add-hook 'coq-mode-hook 'company-coq-mode t)

             ;; Turn off symbol prettification
             (setq company-coq-disabled-features '(prettify-symbols))

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

;; Evil mode
;; ----------

;; Turn on evil mode
(require 'evil)
(evil-mode t)

;; Key bindings
(define-key evil-normal-state-map (kbd ";") 'evil-ex)

(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map (kbd "jj") 'evil-normal-state)

(key-chord-mode t)


;; Helm-mode
;; ----------

;; settings
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)

;; Turn helm on
(helm-mode 1)

;; User config
;; ------------
(load-theme 'tango-dark t)
(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; Remove useless whitespaces before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; don't show trailing whitespace, is already fixed on save
(setq-default show-trailing-whitespace nil)

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

;; Turn on column numbering in modeline
(setq column-number-mode t)

(setq
  inhibit-startup-message   t   ; Don't want any startup message
  ;; use-dialog-box nil           ; use no dialog boxes, just use the echo area / mini-buffer
  ;; redisplay-dont-pause t
  ;; ns-pop-up-frames nil         ; don't open a new frame when using Open with... for instance
  search-highlight           t ; Highlight search object
  query-replace-highlight    t ; Highlight query object
  mouse-sel-retain-highlight t ; Keep mouse high-lightening
  read-file-name-completion-ignore-case t
  x-select-enable-clipboard t
  x-select-enable-primary t
  ;;save-interprogram-paste-before-kill t ; has problems with evil-mode in osx!!
  next-line-add-newlines t
  ;; apropos-do-all t
  ;; scroll-error-top-bottom t ; move to farthest point when not able to move up or down enough lines
  read-buffer-completion-ignore-case t
  completion-auto-help 'lazy
  isearch-resume-in-command-history t
  kill-read-only-ok t
  isearch-allow-scroll t
  ;; visible-bell nil
  color-theme-is-global t
  sentence-end-double-space nil
  ;; shift-select-mode nil
  mouse-yank-at-point t
  whitespace-style '(face trailing lines-tail tabs)
  ;; whitespace-line-column 80
  )

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1)) ; turn off the menubar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1)) ; turn off the toolbar

(fset 'yes-or-no-p 'y-or-n-p)
(set-default 'indent-tabs-mode nil) ; use spaces for indenting, not tabs

;; Save clipboard contents into kill-ring before replace them
(setq save-interprogram-paste-before-kill t)

;; Disable warnings except critical
(setq warning-minimum-level :emergency)

