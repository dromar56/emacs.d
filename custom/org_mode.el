(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/sync/org/david.org"))

;; (global-set-key (kbd "<C-S-right>") 'helm-occur)

(eval-after-load "org"
  '(progn
     (define-key org-mode-map (kbd "<C-S-up>") 'outline-up-heading)
     ;; (define-key org-mode-map (kbd "<C-S-right>") 'nil)
     ;; (define-key org-mode-map (kbd "<C-left>") nil)
     ;; (define-key org-mode-map (kbd "<C-right>") nil)
     ))
