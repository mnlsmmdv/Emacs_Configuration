;; Author: Ahmed Affaan
;; Title: init.el
;; Date: 10/09/2021
;; Description: Personal init.el configuration for GNU Emacs.
;;              This file was written in GNU Emacs version "26.3"
;;              on Linux Mint XFCE.          

;; Configuration start.
;; Initializing Emacs packages.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Checks if use-package package organizer is installed. If not installs them.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Checks if doom-themes are installed. If not installs them.
(unless (package-installed-p 'doom-themes)
  (package-refresh-contents)
  (package-install 'doom-themes))

;; Checks if doom-modeline is installed. If not installs them.
(unless (package-installed-p 'doom-modeline)
  (package-refresh-contents)
  (package-install 'doom-modeline))

;; Installs Doom Emacs's mode line package
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

;; Installs Doom Emacs's icon package.
(use-package all-the-icons
  :ensure t)

;; Stops system from creating and saving backup files.
(setq make-backup-file nil)
(setq autosave-default nil)

;; Yes or No alias changed to y or n.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Terminal preference - "ansi-term".
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

;; Scroll behaviour.
(setq scroll-conservatively 100)

;; Installs org-bullets package for GNU Emacs org-mode.
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

;; Highlights current line during a GUI Emacs session.
(when window-system (global-hl-line-mode t))
(when window-system (global-prettify-symbols-mode t))

;; Shows below which keys are used.
(use-package which-key
  :ensure t
  :init
  (which-key-mode))

;; Cursor type changed to I-beam "|".
(setq-default cursor-type 'bar)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Deletes GNU Emacs default startup message.
(setq inhibit-startup-message t)

;; Add Melpa install package configuration down below from "https://melpa.org/#/".
;; Change comment above to whatever suits you and delete this comment.

;; Selects the selected line and replaces with something else.
(delete-selection-mode 1)

;; Displays line numbers only in a programming mode.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Shows matching parenthesis
(show-paren-mode 1)

(setq ido-anywhere t)
(setq ido-enable-flex-matching t)
(ido-mode t)

;; Installs projectile package which helps navigate project files.
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

;; GNU Emacs dashboard configuration.
(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-items '((recents . 1)
                            (projects . 1)))
    (setq dashboard-banner-logo-title "Welcome Ahmed Affaan :)")
    (setq dashboard-set-file-icons t)
    (setq dashboard-set-heading-icons t)
    (setq dashboard-footer-messages '("Fuck the mahujanun! ;)"))
    (setq dashboard-set-init-info t)
    )
  :config
  (dashboard-setup-startup-hook))

;; Treemacs file tree for GNU Emacs.
(use-package treemacs
  :ensure t
  :config
  (setq treemacs-is-never-other-window t))

;; Makes it easy to navigate through project files.
(use-package treemacs-projectile
  :after treemacs evil
  :ensure t)

;; Syntax checker for GNU Emacs.
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

;; Tab windows for GNU Emacs.
(use-package centaur-tabs
  :ensure t
  :config
    (setq centaur-tabs-set-bar 'over
          centaur-tabs-set-icons t
          centaur-tabs-gray-out-icons 'buffer
          centaur-tabs-height 24
          centaur-tabs-set-modified-marker t
          centaur-tabs-modifier-marker ".")
    (centaur-tabs-mode t))

;; Removes compile log if there are no erros.
(add-hook 'compilation-finish-functions
  (lambda (buf str)
    (if (null (string-match ".*exited abnormally.*" str))
        ;;no errors, make the compilation window go away in a few seconds
        (progn
          (run-at-time
           "2 sec" nil 'delete-windows-on
           (get-buffer-create "*compilation*"))
          (message "No Compilation Errors!")))))

;; Configuration end. 
