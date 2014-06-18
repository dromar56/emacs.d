(add-hook
 'after-init-hook
 (lambda ()
   (after 'auto-complete
     (ac-set-trigger-key nil))
   ))


(define-key  emacs-lisp-mode-map (kbd "C-M-x") nil)

(provide 'init-overrides)
