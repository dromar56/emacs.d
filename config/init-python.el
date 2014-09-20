;; (require 'elpy nil t)
(elpy-enable)
(elpy-use-ipython "ipython2")
;; (elpy-clean-modeline)

(defun elpy-use-python3 (args)
  (elpy-use-ipython "ipython2")
  (interactive "P")
  )

(setq elpy-rpc-backend "jedi")

;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)                ; optional

;; Ignoring electric indentation
(defun electric-indent-ignore-python (char)
  "Ignore electric indentation for python-mode"
  (if (equal major-mode 'python-mode)
      `no-indent'
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-python)

;; Fix yasnippet indentation in python-mode
(add-hook 'python-mode-hook
   '(lambda () (set (make-local-variable 'yas-indent-line) 'fixed)
      (company-mode -1)))

(provide 'init-python)
