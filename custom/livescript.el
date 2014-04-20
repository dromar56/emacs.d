(load "~/.emacs.d/vendor/livescript-mode.el")

;; Javascript improved mode js2-mode
(add-to-list 'auto-mode-alist '("\\.ls\\'" . livescript-mode))

(defun livescript-eval ()
  (local-set-key (kbd "C-x C-e") 'livescript-compile-region))
(add-hook 'livescript-mode-hook 'livescript-eval)
