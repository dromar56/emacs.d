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
    )
  "Set of modules enabled in dotemacs."
  :group 'dotemacs)

(dolist (module dotemacs-modules)
  (require module))

;;;;;;;;;;;;;;;;;;
;; Macro functions
;;;;;;;;;;;;;;;;;;

(fset 'my-create-header
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([1 67108896 5 134217787 1 11 25 return 25 return 25 up 1 S-right 134217847 up 1 67108896 5 134217848 101 backspace 114 101 103 101 120 114 101 112 108 backspace backspace backspace backspace backspace backspace backspace backspace backspace 114 101 112 108 97 99 101 114 101 return 46 return 25 return 1 11 25 down down 1 11 25 134217849 up 1 C-right C-left] 0 "%d")) arg)))
