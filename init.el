(defvar my-root-dir (file-name-directory load-file-name)
  "Root of emacs configuration.")

(defvar my-custom-dir (expand-file-name "custom" my-root-dir)
  "Where I put my custom files." )

(load (expand-file-name "main.el" my-root-dir))
(load (expand-file-name "bindings.el" my-root-dir))

;; load the personal settings (this includes `custom-file')
(when (file-exists-p my-custom-dir)
  (message "Loading personal configuration files in %s..." my-custom-dir)
  (mapc 'load (directory-files my-custom-dir 't "^[^#].*el$")))


;; (load "~/.emacs.d/custom/javascript.el")
;; (load "~/.emacs.d/custom/livescript.el")
;; (load "~/.emacs.d/custom/coffee-script.el")
;; ;; (load "~/.emacs.d/custom/tabbar.el")
;; (load "~/.emacs.d/custom/lua.el")
;; (load "~/.emacs.d/custom/jade.el")
;; (load "~/.emacs.d/custom/php.el")
;; (load "~/.emacs.d/custom/c_and_cpp.el")

(setq custom-file (expand-file-name "custom.el" my-custom-dir))
(load custom-file)

(setq my-gui-theme 'solarized-dark)
(setq my-terminal-theme 'solarized-dark)

(if (daemonp)
(add-hook 'after-make-frame-functions
          '(lambda (f)
             (with-selected-frame f
               (when (window-system f) 
		 (if (display-graphic-p) 
		     (load-theme my-gui-theme) 
		   (load-theme my-terminal-theme))))))
)

(if (display-graphic-p) 
    (load-theme my-gui-theme) 
  (load-theme my-terminal-theme))


(fset 'my-create-header
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([1 67108896 5 134217787 1 11 25 return 25 return 25 up 1 S-right 134217847 up 1 67108896 5 134217848 101 backspace 114 101 103 101 120 114 101 112 108 backspace backspace backspace backspace backspace backspace backspace backspace backspace 114 101 112 108 97 99 101 114 101 return 46 return 25 return 1 11 25 down down 1 11 25 134217849 up 1 C-right C-left] 0 "%d")) arg)))
