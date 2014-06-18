;;;;;;;;;;;;;;;;;;;;;
;; Auto-Complete Mode
;;;;;;;;;;;;;;;;;;;;;


(require-package 'ac-dabbrev)
(require-package 'auto-complete)

(require 'cl)
(require 'dabbrev)
(require 'auto-complete)

(require 'ac-dabbrev)


(after 'auto-complete
  (add-to-list 'ac-sources 'ac-source-dabbrev))
(after 'linum
  (ac-linum-workaround))

(defun ac-dabbrev-expand ()
  (interactive)
  (auto-complete '(ac-source-dabbrev)))

(global-set-key (kbd "M-/") 'ac-dabbrev-expand)

(global-auto-complete-mode t)

(setq ac-auto-start nil)
(define-key ac-mode-map (kbd "<tab>") nil)
(define-key ac-mode-map (kbd "C-o") 'auto-complete)
(define-key ac-mode-map (kbd "M-?") 'auto-complete)
;; (define-key ac-mode-map (kbd "M-/") 'dabbrev-expand)
(define-key ac-complete-mode-map (kbd "C-g") 'ac-stop)
(define-key ac-complete-mode-map (kbd "<down>") 'ac-next)
(define-key ac-complete-mode-map (kbd "<up>") 'ac-previous)
(define-key ac-complete-mode-map (kbd "RET") 'ac-expand)
(provide 'init-autocomplete)
