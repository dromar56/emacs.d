(require-package 'company)
(require 'company)

(setq company-idle-delay 0)

(defun company-auto-completion-toggle ()
  (interactive)
  (if (eq company-idle-delay 0)
      (setq company-idle-delay nil)
    (setq company-idle-delay 0))
)
(global-set-key (kbd "M-c") 'company-auto-completion-toggle)

(setq company-minimum-prefix-length 1)
(setq company-show-numbers 1)
(setq company-tooltip-limit 10)

(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case nil)

(set-face-attribute 'company-tooltip nil :background "black" :foreground "gray40")
(set-face-attribute 'company-tooltip-selection nil :inherit 'company-tooltip :background "gray15")
(set-face-attribute 'company-preview nil :background "black")
(set-face-attribute 'company-preview-common nil :inherit 'company-preview :foreground "gray40")
(set-face-attribute 'company-scrollbar-bg nil :inherit 'company-tooltip :background "gray20")
(set-face-attribute 'company-scrollbar-fg nil :background "gray40")

(when (executable-find "tern")
  (after "company-tern-autoloads"
    (add-to-list 'company-backends 'company-tern)))
(add-to-list 'company-backends 'company-tern)

(setq company-global-modes
      '(not
        eshell-mode comint-mode org-mode))


(global-set-key (kbd "C-o") 'company-manual-begin)
(global-set-key (kbd "M-o") 'company-tern)
(global-set-key (kbd "M-?") 'company-dabbrev)

(defadvice company-complete-common (around advice-for-company-complete-common activate)
  (when (null (yas-expand))
    ad-do-it))

(add-hook 'after-init-hook 'global-company-mode)

(provide 'init-company)
