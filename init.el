(defgroup dotemacs nil
  "Custom configuration for dotemacs."
  :group 'local)

(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(add-to-list 'load-path (concat user-emacs-directory "config"))

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(defcustom dotemacs-modules
  '(init-packages
    init-util
    init-core

    init-eyecandy

    init-autocomplete
    init-yasnippet
    init-org
    init-helm
    init-smartparens
    ;; init-evil

    init-c
    init-coffeescript
    init-jade
    init-js
    init-livescript
    init-lua
    init-php
    init-python
    init-web

    init-bindings
    init-macro
    )
  "Set of modules enabled in dotemacs."
  :group 'dotemacs)

(dolist (module dotemacs-modules)
  (require module))

