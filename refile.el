(defun rename-symbol-in-defun ()
  (interactive)
  (let ((transient-mark-mode nil)
	(symbol (thing-at-point 'symbol)))
    (save-excursion
      (mark-defun)
      (query-replace symbol
                     (completing-read
                      (concat "Rename symbol " symbol " with: ") '())
                     t (region-beginning) (region-end)))))
(bind-key "C-c r" 'rename-symbol-in-defun)
