;;;;;;;;;;;;;;;;;;;;;
;; Auto-Complete Mode
;;;;;;;;;;;;;;;;;;;;;


(require 'cl)
(require 'dabbrev)
(require 'auto-complete)

(global-auto-complete-mode t)

(defun ac-source-dabbrev (abbrev)
  (interactive)
  (dabbrev--reset-global-variables)
  (let ((dabbrev-check-all-buffers t))
    (sort (dabbrev--find-all-expansions abbrev t) #'string<)))

(defvar ac-source-dabbrev-words
  '((candidates
     . (lambda () (all-completions ac-target
                                   (ac-source-dabbrev ac-target)))))
  "Get all the completions using dabbrev")

(setq-default ac-sources '(ac-source-dabbrev-words))

(setq ac-auto-start nil)
(define-key ac-mode-map (kbd "C-o") 'auto-complete)
;; (define-key ac-mode-map (kbd "C-/") 'auto-complete)

(define-key ac-complete-mode-map (kbd "C-g") 'ac-stop)
(define-key ac-complete-mode-map (kbd "<down>") 'ac-next)
(define-key ac-complete-mode-map (kbd "<up>") 'ac-previous)
(define-key ac-complete-mode-map (kbd "RET") 'ac-expand)

;; (define-key ac-complete-mode-map "\t" 'ac-complete)
;; (define-key ac-complete-mode-map "\r" 'ac-complete)

(defun ac-self-insert ()
  (interactive)
  (self-insert-command 1)
  (ac-start))

(defun ac-fix-keymap ()
  (let ((i 32))
    (while (<= i ?z)
      (define-key ac-complete-mode-map
        (make-string 1 i) 'ac-self-insert)
      (incf i))))

(ac-fix-keymap)

;; (define-key ac-complete-mode-map (kbd "DEL")
;;   (lambda ()
;;     (interactive)
;;     (backward-delete-char-untabify 1)
;;     (ac-start)))

