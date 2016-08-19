;Create repositories cache, if required
(when (not package-archive-contents)
  (package-refresh-contents))

;Declare a list of required packages
(defvar super-emacs--required-packages
  '(use-package
    helm
    multiple-cursors
    ace-jump-mode
    powerline
    switch-window
    buffer-move
    auto-complete
    ztree
    undo-tree
    material-theme
    meta-presenter
    myterminal-controls
    theme-looper))

;Install required packages
(mapc (lambda (p)
        (package-install p))
      super-emacs--required-packages)

;;Load default auto-complete configs
(use-package auto-complete
  :config
  (ac-config-default))


;;Start undo-tree
(use-package undo-tree
  :bind (("M-/" . undo-tree-visualize))
  :config
(global-undo-tree-mode))

(use-package ace-jump-mode
  :commands ace-jump-mode
  :init
  (bind-key "C-." 'ace-jump-mode))

;Enable powerline
(use-package powerline
  :config
  (powerline-center-theme)
  ;(setq powerline-default-separator 'wave)
)


;;Configure theme-looper
(use-package theme-looper
  :bind (("C-\"" . theme-looper-enable-next-theme))
  :config
  (theme-looper-set-theme-set '(deeper-blue
                                wheatgrass
                                wombat
                                material
                                monokai
                                solarized-dark
                                solarized-light))
  (theme-looper-set-customizations 'powerline-reset))

;Configure myterminal-controls
(use-package myterminal-controls
  :commands myterminal-controls-open-controls
  :bind (("C-M-'" . myterminal-controls-open-controls))
  :config
  (myterminal-controls-set-controls-data
   '(("t" "Change color theme" theme-looper-enable-next-theme)
     ("r" "Reload file" super-emacs-reload-current-file))))

;; config helm
(use-package helm
  :init
  :bind (("M-x" . helm-M-x)
    ("C-x b" . helm-mini)
    ("C-x C-b" . helm-buffers-list)
    ("C-x C-f" . helm-find-files)
    ("C-x C-r" . helm-recentf)
    ("M-y" . helm-show-kill-ring)
    ("C-c h" . helm-command-prefix)
  :map helm-map
  ;("<tab>" . helm-execute-persistent-action)
  ("C-j" .  helm-execute-persistent-action)
  ("C-z" . helm-select-action))
  :config
  (helm-mode 1)
  (helm-autoresize-mode t)
  (setq helm-split-window-in-side-p t
        ;helm-move-to-line-cycle-in-source t
        helm-ff-file-name-history-use-recentf t
        helm-ff-search-library-in-sexp t)
  (use-package helm-ag
    :ensure t)
  (use-package helm-config))


; multi term
(use-package multi-term
  :ensure t
  :bind (("C-x t" . multi-term))
  :config
  (require 'multi-term)
  (setq multi-term-program "/usr/bin/zsh")
  ;; set PS1
  (setq system-uses-terminfo nil)
  ;; tab complete
  (add-hook 'term-mode-hook
            (lambda()
              (setq yas-dont-activate t))))

;; dired


(use-package dired+
  :ensure t
  :config
  (require 'dired+))

(use-package dired-x
  :init 
  (add-to-list 'load-path "~/.emacs.d/elpa/direx-20151023.1606")
  :config
  (require 'dired-x))

;; (use-package dired-open
;;   :ensure t
;;   :config
;;   (require 'dired-open)

;; )
 (setq-default dired-listing-switches "-lha")

 (setq dired-clean-up-buffers-too t)

 (setq dired-recursive-copies 'always)

 (setq dired-recursive-deletes 'top)


;; ido
(use-package ido
  :ensure t
  :init  (setq ido-enable-flex-matching t
               ido-ignore-extensions t
               ido-use-virtual-buffers t
               ido-everywhere t)
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (add-to-list 'completion-ignored-extensions ".pyc")
  ;; don't confirm to create new buffers
  (setq ido-create-new-buffer 'always))

(use-package flx-ido
   :ensure t
   :init (setq ido-enable-flex-matching t)
   :config (flx-ido-mode 1))

(use-package ido-vertical-mode
  :ensure t
  :init               ; I like up and down arrow keys:
  (setq ido-vertical-define-keys 'C-n-C-p-up-and-down)
  :config
  (ido-vertical-mode 1))

(use-package ido-ubiquitous
  :ensure t
  :config
  (ido-ubiquitous))



;; Package: smartparens
(use-package smartparens
  :ensure t
  :config
  (use-package dash
    :ensure t)
  (require 'smartparens-config)
  (show-smartparens-global-mode +1)
  (smartparens-global-mode 1)
)
;; when you press RET, the curly braces automatically
;; add another newline
(sp-with-modes '(c-mode c++-mode)
  (sp-local-pair "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair "/*" "*/" :post-handlers '((" | " "SPC")
                                            ("* ||\n[i]" "RET"))))

;; Package: clean-aindent-mode
(use-package clean-aindent-mode
  :ensure t
  :config
  (require 'clean-aindent-mode)
  (add-hook 'prog-mode-hook 'clean-aindent-mode))

;; Package: ws-butler
(use-package ws-butler
  :ensure t
  :config
  (require 'ws-butler)
  (add-hook 'c-mode-common-hook 'ws-butler-mode)
  (add-hook 'prog-mode-hook 'ws-butler-mode))

;; git-gutter+
(use-package git-gutter+
  :ensure t
  :config (global-git-gutter+-mode))

;; projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
)


;; execute in emacs
(setenv "PATH"
        (concat (getenv "PATH")
                ":" "/usr/local/bin"))

;; execute in emacs
(setenv "PATH"
        (concat (getenv "PATH")
                ":" "/home/sxwl1070/anaconda2/bin"))


;; execute in emacs
(setenv "PATH"
        (concat (getenv "PATH")
                ":" "/home/sxwl1070/anaconda3/bin"))


;; elpy

(use-package elpy
  :ensure t
  :config
  ;;  (define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
  (require 'elpy)
  (elpy-enable)
  (setq elpy-rpc-python-command "/home/sxwl1070/anaconda2/bin/python")
  (elpy-use-ipython "/home/sxwl1070/anaconda2/bin/ipython")

  ;;(setq elpy-rpc-backend "jedi")
  (setq elpy-rpc-backend "jedi")

  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
  (defun zl/switch-to-python3 ()
    (interactive)
    (setq elpy-rpc-python-command "/home/sxwl1070/anaconda3/bin/python3")
    (elpy-use-ipython "/home/sxwl1070/anaconda3/bin/ipython3"))
  (defun zl/switch-to-python2 ()
    (interactive)
    (setq elpy-rpc-python-command "/home/sxwl1070/anaconda2/bin/python")
    (elpy-use-ipython "/home/sxwl1070/anaconda2/bin/ipython"))
  (use-package flycheck
    :ensure t
    :config
    (require 'flycheck)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)))

;; ein for ipython-notebook
(use-package ein
  :ensure t
  :config
  (require 'ein)
  (setq ein:use-auto-complete-superpack t)
  (setq ein:use-smartrep t))
