(require-package 'workgroups2)
(require 'workgroups2)

;; if you start Emacs as "emacs --daemon" - turn off autoloading of workgroups:
;; (setq wg-use-default-session-file nil)


;; Change workgroups session file
(setq wg-default-session-file "~/.emacs.d/.emacs_workgroups")

;; winner-mode to undo/redo windows changes
(when (fboundp 'winner-mode)
  (winner-mode 1))

;;Winner-mode per workgroup hack
(defvar wg-winner-vars nil)
(defvar wg-winner-hash nil)

(setq wg-winner-vars '(winner-ring-alist
               winner-currents
               winner-point-alist
               winner-undone-data
               winner-undo-counter
               winner-pending-undo-ring))

(setq wg-winner-hash (make-hash-table :test 'equal))

(defun wg-winner-put (winner-name)
  (let ((wg (ignore-errors (wg-workgroup-name (wg-current-workgroup)))))
    (if wg
    (puthash (list wg winner-name) (eval winner-name) wg-winner-hash))))

(defun wg-winner-get (winner-name)
  (let ((wg (ignore-errors (wg-workgroup-name (wg-current-workgroup)))))
    (if wg
    (eval `(setq ,winner-name (gethash '(,wg ,winner-name) wg-winner-hash))))))

(defun wg-winner-save ()
  (if winner-mode
      (progn
    (winner-mode -1)
    (defun wg-winner-mode-restore ()
      (winner-mode 1)))
    (defun wg-winner-mode-restore ()))
  (mapcar 'wg-winner-put wg-winner-vars))

(defun wg-winner-load ()
  (mapcar 'wg-winner-get wg-winner-vars)
  (wg-winner-mode-restore))

(defadvice wg-switch-to-workgroup (before wg-winner-before activate)
  (wg-winner-save))

(defadvice wg-switch-to-workgroup (after wg-winner-after activate)
  (wg-winner-load))

;; (workgroups-mode 1)   ; put this one at the bottom of .emacs

(provide 'init-workspace2)

