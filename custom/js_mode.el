;; Javascript improved mode js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")
;; eg. extract function with `C-c C-m ef`.


;; SLIME - SWANK-JS
(require 'slime)
;; (autoload 'slime "slime" "Slime" t)

(ignore-errors
  (slime-setup '(slime-js2 slime-repl))
  (add-hook 'js2-mode-hook
	    (lambda ()
	      (slime-js-minor-mode 1)))
  (add-hook 'css-mode-hook
	    (lambda ()
	      (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
	      (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css))))


;;SWANK-JS MODE IS FUCKING AWESOME
(global-set-key [f5] 'slime-js-reload)

;; ;; SKEWER
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)



;; TERN
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     ;; (tern-ac-setup)
     (define-key tern-mode-keymap (kbd "C-o") 'tern-ac-complete)
     ))
