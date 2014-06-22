(add-hook
 'after-init-hook
 (lambda ()
   (after 'auto-complete
     (ac-set-trigger-key nil))
   ))


(define-key  emacs-lisp-mode-map (kbd "C-M-x") nil)

;; (require-package 'guru-mode)
;; (require 'guru-mode)
;; (guru-global-mode 1)
;; (global-set-key (kbd "C-f") 'forward-char)
;; (global-set-key (kbd "C-b") 'backward-char)
;; (global-set-key (kbd "C-j") 'newline-and-indent)

(provide 'init-overrides)
