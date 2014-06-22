(require-package 'smartparens)
;; (require 'smartparens-config)

(setq sp-show-pair-delay 0)
(setq sp-show-pair-from-inside 1) ;; Shows two pair of parenthesis when used with show-paren-mode

(setq sp-autoescape-string-quote nil)
(setq sp-autoinsert-if-followed-by-same 1)
(setq sp-highlight-pair-overlay nil)

(sp-use-smartparens-bindings)
(smartparens-global-mode t)
(smartparens-global-strict-mode t)

(show-smartparens-global-mode t)
(show-paren-mode 1)


(sp-pair "`" nil :actions :rem)

(sp-with-modes sp--lisp-modes
  (sp-local-pair "'" nil :actions nil)
  )


(define-key sp-keymap (kbd "M-<right>") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "M-<left>") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "C-<right>") 'nil)
(define-key sp-keymap (kbd "C-<left>") 'nil)
;; (define-key sp-keymap "`" 'nil)
;; (define-key sp-keymap 96 'nil)

;; (define-key smartparens-strict-mode-map [remap kill-line] 'nil)
;; (define-key smartparens-strict-mode-map (kbd "M-k") 'sp-kill-hybrid-sexp)
(define-key smartparens-strict-mode-map [remap kill-line] 'sp-kill-hybrid-sexp)


;; fix conflict where smartparens clobbers yas' key bindings
(after 'yasnippet
  (defadvice yas-expand (before advice-for-yas-expand activate)
    (sp-remove-active-pair-overlay)))

(defadvice sp-kill-hybrid-sexp (before kill-line-cleanup-whitespace activate)
  "cleanup whitespace on sp-kill-hybrid-sexp"
  (if (bolp)
      (delete-region (point) (progn (skip-chars-forward " \t") (point)))))

(provide 'init-smartparens)
