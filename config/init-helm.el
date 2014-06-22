;; (setq helm-command-prefix-key "C-c h")
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)

(require-package 'helm)
(require-package 'helm-swoop)

(after 'projectile
  (require-package 'helm-projectile))

(require 'helm-config)
(helm-mode 1)

(require-package 'wgrep-helm)
;; (require 'wgrep-helm)



(require-package 'helm-ag)
(setq helm-ag-thing-at-point 'symbol)
(defun helm-ag-projectile ()
  (interactive)
  (helm-ag (projectile-project-root)))

(provide 'init-helm)
