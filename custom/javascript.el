;;SWANK-JS MODE IS FUCKING AWESOME
(global-set-key [f5] 'slime-js-reload)

;; Javascript improved mode js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


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

;; ;; SKEWER
;; (add-hook 'js2-mode-hook 'skewer-mode)
;; (add-hook 'css-mode-hook 'skewer-css-mode)
;; (add-hook 'html-mode-hook 'skewer-html-mode)