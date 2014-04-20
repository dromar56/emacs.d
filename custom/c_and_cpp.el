;;;;;;;;;;;;;;;;;;;;;;;;;
;; C count-lines-function
;;;;;;;;;;;;;;;;;;;;;;;;;

(defun count-lines-function ()
  "count number of lines and characters beetwen matched parenthesis"
  (interactive)
  (forward-char 1)
  (save-excursion
    (set-mark-command nil)
    (let
        ((start (progn (c-beginning-of-defun) (point)))
         (end (progn (c-end-of-defun) (previous-line 3)
                     (forward-char 1) (forward-char -1)
                     (point))))
      (count-lines-region start end)))
  (forward-char -1))
;;  Ligne ubercool
 (save-excursion (let ((start (point)) (end (progn (forward-list) (point)))) (count-lines-region start end)))

(defun my-c-mode-hook ()
  (local-set-key (kbd "C-c C-w") 'count-lines-function)
  )
(add-hook 'c-mode-hook 'my-c-mode-hook)
;; (add-hook 'c-mode-common-hook   (lambda () (highlight-80+-mode t) ) )
