;;;;;;;;;;;;;;;
;; Tabbar
;;;;;;;;;;;;;;;

(tabbar-mode 1)

(defun tabbar-buffer-groups ()
  ;; cond means conditionnal
  ;; each of those four lines are evaluated, and the result returned ("user", "emacs", "emacs", "user")
  ;; the last one (t "user") is for the default, since t always evaluated true then it will return "user"
  (list (cond ((string-equal "*es" (substring (buffer-name) 0 3)) "user")
	      ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
	      ((eq major-mode 'dired-mode) "emacs")

	      (t "user") )
	))

;; Add a buffer modification state indicator in the tab label, and place a
;; space around the label to make it looks less crowd.

(defadvice tabbar-buffer-tab-label (after fixup_tab_label_space_and_flag activate)
  (setq ad-return-value
	(if (and (buffer-modified-p (tabbar-tab-value tab))
		 (buffer-file-name (tabbar-tab-value tab)))
	    (concat " + " (concat ad-return-value " "))
	  (concat " " (concat ad-return-value " ")))))

;; Called each time the modification state of the buffer changed.
(defun ztl-modification-state-change ()
  (tabbar-set-template tabbar-current-tabset nil)
  (tabbar-display-update))

;; First-change-hook is called BEFORE the change is made.
(defun ztl-on-buffer-modification ()
  (set-buffer-modified-p t)
  (ztl-modification-state-change))
(add-hook 'after-save-hook 'ztl-modification-state-change)

;; This doesn't work for revert, I don't know.
;;(add-hook 'after-revert-hook 'ztl-modification-state-change)
(add-hook 'first-change-hook 'ztl-on-buffer-modification)

;; (tabbar-mode 0)


