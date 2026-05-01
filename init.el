;; -*- lexical-binding: t -*-

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(repeat-mode t)

(setq default-input-method 'vietnamese-telex)

(setq comment-multi-line t
      comment-empty-lines t)

(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode nil
              tab-width 4)

(electric-pair-mode 1)

(setq isearch-repeat-on-direction-change t)

(setq use-short-answers t)

(setq make-backup-files nil)
(setq delete-by-moving-to-trash t)

(minibuffer-electric-default-mode 1)
(setq history-delete-duplicates t)
(minibuffer-depth-indicate-mode 1)
(setq resize-mini-windows t
      enable-recursive-minibuffers t
      read-extended-command-predicate #'command-completion-default-include-p)

(savehist-mode 1)

(recentf-mode 1)

(delete-selection-mode 1)
(setq mark-even-if-inactive nil)

(setq-default fill-column 80)
(setq-default truncate-lines t)

(setq eldoc-documentation-strategy 'eldoc-documentation-compose-eagerly)

(setq scroll-conservatively 1)

(save-place-mode 1)

(setq prettify-symbols-unprettify-at-point t)

(column-number-mode 1)

(global-hl-line-mode 1)

(setq tab-bar-show 1)

(setq vc-command-messages 'log)

(setq project-mode-line t
      project-kill-buffers-display-buffer-list t)

(setq custom-safe-themes t)

(set-face-attribute 'default nil :family "Iosevka Fixed" :height 120)
(set-face-attribute 'fixed-pitch nil :family "Iosevka Fixed" :height 1.0)
(set-face-attribute 'variable-pitch nil :family "Charis" :height 1.05)

(require-theme 'modus-themes)
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs t
      modus-themes-prompts '(bold)
      modus-themes-completions '((matches . (bold))
                                 (selection . (bold italic)))
      modus-themes-to-toggle '(modus-operandi-tinted modus-vivendi-tinted))
(keymap-set global-map "<f5> m" #'modus-themes-toggle)


(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-archive-priorities '(("gnu" . 420)
                                   ("nongnu" . 96)
                                   ("melpa" . 69)))

(require 'use-package)
(setq use-package-hook-name-suffix nil
      use-package-compute-statistics t)

(use-package doric-themes
  :ensure t
  :config
  (defun doric-themes-random-dark ()
    "Load a random dark Doric theme."
    (interactive)
    (doric-themes-load-random 'dark))
  (defun doric-themes-random-light ()
    "Load a random light Doric theme."
    (interactive)
    (doric-themes-load-random 'light))
  (keymap-set global-map "<f5> d" #'doric-themes-random-dark)
  (keymap-set global-map "<f5> l" #'doric-themes-random-light)
  (doric-themes-load-random 'dark))

(use-package diminish
  :ensure t
  :config
  (diminish 'eldoc-mode))

(use-package which-key
  :init
  (which-key-mode 1)
  :custom
  (which-key-idle-delay 0.5)
  (which-key-idle-secondary-delay 0.2)
  (which-key-sort-order #'which-key-key-order-alpha)
  (which-key-show-remaining-keys t)
  (which-key-lighter ""))

(use-package vertico
  :ensure t
  :custom
  (vertico-resize t)
  (vertico-cycle t)
  :config
  (vertico-mode 1))

(use-package vertico-directory
  :after vertico
  :bind (:map vertico-map
         ("RET" . vertico-directory-enter)
         ("DEL" . vertico-directory-delete-char)
         ("M-DEL" . vertico-directory-delete-word))
  :hook (rfn-eshadow-update-overlay-hook . vertico-directory-tidy))

(use-package vertico-multiform
  :after vertico
  :config
  (add-to-list 'vertico-multiform-categories '(embark-keybinding grid))
  (vertico-multiform-mode 1))

(use-package orderless
  :ensure t
  :config
  (orderless-define-completion-style +orderless-with-initialism
    (orderless-matching-styles '(orderless-initialism orderless-literal orderless-regexp)))
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles partial-completion))
                                        (command (styles +orderless-with-initialism))
                                        (variable (styles +orderless-with-initialism))
                                        (symbol (styles +orderless-with-initialism)))))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1)
  :config
  (keymap-set minibuffer-local-map "M-A" #'marginalia-cycle))

(use-package consult
  :ensure t
  :bind (("C-h s" . consult-info)
         ("C-c c c" . consult-mode-command)
         ("C-c c m" . consult-minor-mode-menu)
         ("C-c c k" . consult-kmacro)
         ("C-x M-ESC" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x t b" . consult-buffer-other-tab)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)
         ("C-y" . consult-yank-from-kill-ring)
         ("M-y" . consult-yank-pop)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g M" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ("M-s f" . consult-fd)
         ("M-s g" . consult-ripgrep)
         ("M-s G" . consult-git-grep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         :map isearch-mode-map
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))
  :init
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :custom
  (consult-narrow-key "<")
  (consult-preview-key '(:debounce 0.2 any))
  :config
  (consult-customize
   consult-bookmark
   consult-git-grep
   consult-ripgrep
   consult-xref
   consult-source-bookmark
   consult-source-recent-file
   consult-source-project-recent-file
   consult-source-project-recent-file-hidden
   :preview-key "M-."))

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)
   :map minibuffer-mode-map
   ("C-SPC" . embark-select))
  :custom
  (embark-confirm-act-all nil)
  (embark-indicators '(embark-minimal-indicator
                       embark-highlight-indicator
                       embark-isearch-highlight-indicator))
  (embark-quit-after-action nil)
  (embark-help-key "?")
  :config
  (setq prefix-help-command #'embark-prefix-help-command)
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :after (consult embark)
  :config
  (with-eval-after-load 'embark-consult
    (dolist (map (list embark-consult-async-search-map
                       embark-consult-search-map))
      (keymap-unset map "F" t)
      (keymap-unset map "d" t)
      (keymap-unset map "r" t)
      (keymap-set map "f" #'consult-fd)
      (keymap-set map "g" #'consult-ripgrep))))

(use-package helpful
  :ensure t
  :bind
  (("C-h f" . helpful-callable)
   ("C-h F" . helpful-function)
   ("C-h v" . helpful-variable)
   ("C-h k" . helpful-key)
   ("C-h x" . helpful-command)
   ("C-h ." . helpful-at-point)))

(use-package auctex
  :ensure t
  :defer t
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-one-master "<none>")
  (TeX-master "main")
  (TeX-output-dir "out")
  (font-latex-fontify-script nil)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-start-server t)
  (TeX-engine 'luatex)
  (LaTeX-electric-left-right-brace t)
  (TeX-electric-sub-and-superscript t)
  (TeX-fold-auto t)
  (TeX-fold-preserve-comments t)
  (TeX-electric-math (cons "\\(" "\\)"))
  (TeX-error-overview-open-after-TeX-run t)
  :config
  (with-eval-after-load 'tex
    (add-to-list 'TeX-view-program-selection '(output-pdf "PDF Tools"))
    (add-hook 'TeX-after-compilation-finished-functions
              #'TeX-revert-document-buffer)
    (add-hook 'LaTeX-mode-hook (lambda ()
                                 (add-hook 'after-save-hook
                                           (lambda ()
                                             (TeX-command-run-all nil))
                                           nil t)
                                 (turn-on-auto-fill)
                                 (TeX-fold-mode 1)
                                 (add-hook 'find-file-hook #'TeX-fold-buffer nil t)
                                 (run-with-idle-timer 0 nil (lambda ()
                                                              (prettify-symbols-mode 1))))))
  (with-eval-after-load 'preview
    (setq preview-default-option-list (seq-difference preview-default-option-list
                                                      '("sections" "footnotes"))
          preview-auto-cache-preamble t)))

(use-package pdf-tools
  :ensure t
  :mode "\\.pdf\\'"
  :custom
  (pdf-view-resize-factor 1.1)
  :config
  (pdf-loader-install)
  (keymap-set pdf-view-mode-map "c" #'pdf-view-center-in-window))

(use-package flymake
  :hook
  (LaTeX-mode-hook)
  :custom
  (flymake-show-diagnostics-at-end-of-line 'short)
  :config
  (keymap-set flymake-mode-map "M-n" #'flymake-goto-next-error)
  (keymap-set flymake-mode-map "M-p" #'flymake-goto-prev-error)
  (keymap-set flymake-mode-map "C-c d b" #'flymake-show-buffer-diagnostics)
  (keymap-set flymake-mode-map "C-c d p" #'flymake-show-project-diagnostics))

(use-package magit
  :ensure t
  :commands (magit-status magit-dispatch magit-file-dispatch)
  :custom
  (magit-define-global-key-bindings 'recommended)
  :config
  (add-to-list 'magit-no-confirm 'magit-delete-by-moving-to-trash))

(use-package ediff
  :defer t
  :custom
  (ediff-window-setup-function 'ediff-setup-windows-plain))
