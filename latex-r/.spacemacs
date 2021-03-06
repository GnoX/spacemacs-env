;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs-docker
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-return-key-behavior nil
                      auto-completion-enable-sort-by-usage t
                      auto-completion-complete-with-key-sequence "jk"
                      auto-completion-enable-help-tooltip 'manual  :disabled-for org)
     better-defaults
     docker
     git
     helm
     org
     markdown
     (ranger :variables ranger-override-dired t)
     (spell-checking :variables spell-checking-enable-by-default nil)
     (syntax-checking :variables syntax-checking-enable-by-default nil)
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom )
     vimscript
     yaml
     gutils
     bibtex
     latex
     (pandoc :variables pandoc-spacemacs-docker-disable-deps-install t)
     (pdf :variables pandoc-spacemacs-docker-disable-deps-install t)
     (ess :variables ess-enable-smart-equals t)
    )
   dotspacemacs-additional-packages
   '(
     all-the-icons
     all-the-icons-dired
     cdlatex
    )
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-install-packages 'used-only))


(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-mode-line-theme 'spacemacs
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner nil
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ nil
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers nil
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
   (add-to-list 'load-path "~/.emacs.d/private/local/ESS/")
  )


(defun dotspacemacs/user-config ()
   (global-auto-revert-mode t)
   (add-hook 'ranger-mode-hook 'all-the-icons-dired-mode)

   (add-hook 'text-mode-hook 'auto-fill-mode)
   (add-hook 'doc-view-mode-hook 'auto-revert-mode)

   (define-key evil-normal-state-map "+" 'evil-numbers/inc-at-pt)
   (define-key evil-normal-state-map "-" 'evil-numbers/dec-at-pt)

   (global-git-commit-mode t)
   (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
   (add-to-list 'org-latex-packages-alist '("" "minted"))

   (with-eval-after-load 'org
     (setq org-latex-listings 'minted)
     (setq org-latex-pdf-process '("latexmk -pdflatex='%latex -shell-escape -interaction nonstopmode' -pdf -output-directory=%o -f %f"))

     (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (R . t)
       (python . t)))

     (setq org-latex-create-formula-image-program 'imagemagick)
     (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.8))

     (setq org-hide-macro-markers t)
     (setq org-src-fontify-natively t)
     )
   (add-hook 'ess-mode-hook (lambda () (ess-toggle-underscore nil)))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
