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
                                   ("marmalade" . 0)))

(setq package-enable-at-startup nil)
(package-initialize)

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
             :mode ("\\.v\\'" . coq-mode))

(use-package company-coq
             :ensure t
             :commands (company-coq-mode)
             :init (add-hook 'coq-mode-hook 'company-coq-mode t))

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
(load-theme 'misterioso t)
(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

