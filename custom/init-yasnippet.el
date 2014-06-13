;;;;;;;;;;;;
;; yasnippet
;;;;;;;;;;;;

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))

(require-package 'yasnippet)
(require 'yasnippet)
;; (global-set-key (kbd "TAB") 'nil)
;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "C-o") 'yas-expand)
(define-key yas-minor-mode-map (kbd "C-c TAB") 'yas-insert-snippet)
(yas-global-mode 1)

(provide 'init-yasnippet)
