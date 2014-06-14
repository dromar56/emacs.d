;; Occur
(global-set-key (kbd "M-o") 'helm-occur)
(global-set-key (kbd "C-M-o") 'helm-multi-occur)

;; A la carte Menu
(global-set-key (kbd "C-x c") 'lacarte-execute-menu-command)

;; helm-imenuu
(global-set-key (kbd "C-t") 'idomenu)
(global-set-key (kbd "M-t") 'imenu-anywhere)

;; helm-etags
;; (global-set-key (kbd "M-t") 'helm-etags-select)

;; Locked mode
(global-set-key (kbd "C-c C-l") 'locked-buffer-mode)

;; Windows manipulation
(global-set-key (kbd "C-x |")		'split-window-right)
(global-set-key (kbd "C-x -")		'split-window-below)
(global-set-key (kbd "C-x C-<right>")	'windmove-right)
(global-set-key (kbd "C-x C-<left>")	'windmove-left)
(global-set-key (kbd "C-x C-<down>")	'windmove-down)
(global-set-key (kbd "C-x C-<up>")	'windmove-up)

(global-set-key (kbd "C-x <left>")	'shrink-window-horizontally)
(global-set-key (kbd "C-x <right>")	'enlarge-window-horizontally)
(global-set-key (kbd "C-x <up>")	'enlarge-window)
(global-set-key (kbd "C-x <down>")	'shrink-window)

;; (global-set-key (kbd "M-<right>") 'other-window)
;; (global-set-key (kbd "M-<left>") '(lambda (&optional n)
;; 					     (interactive "P") (other-window -1)))

(global-set-key (kbd "<prior>") (lambda () (interactive) (scroll-down 8)))
(global-set-key (kbd "<next>") (lambda () (interactive) (scroll-down -8)))

;; Magit Mode
(global-set-key (kbd "C-x g") 'magit-status)

;; Undo Tree mode
;; (global-set-key (kbd "C-+") 'undo-tree-redo)

;; iy-go-to-char
(global-set-key (kbd "M-.") 'iy-go-up-to-char)
(global-set-key (kbd "M-,") 'iy-go-up-to-char-backward)

;; multiple-cursors bindings
(global-set-key (kbd "s-M") 'mc/edit-lines)
(global-set-key (kbd "s-.") 'mc/mark-next-like-this)
(global-set-key (kbd "s-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "s->") 'mc/unmark-next-like-this)
(global-set-key (kbd "s-<") 'mc/unmark-previous-like-this)
(global-set-key (kbd "s-m") 'mc/mark-all-like-this)

;; Expand region by semantics units
(global-set-key (kbd "s-x") 'er/expand-region)
(global-set-key (kbd "s-\/") 'er/expand-region)

;; Register Windows
(global-set-key (kbd "<f9>") '(lambda () (interactive) (jump-to-register 9)
				(message "Windows disposition loaded")))
(global-set-key (kbd "<f10>") '(lambda () (interactive) (window-configuration-to-register 9)
				 (message "Windows disposition saved")))

;; Projectile
(global-set-key (kbd "C-x p") 'helm-projectile)
(global-set-key (kbd "s-d") 'projectile-find-dir)
;; (global-set-key (kbd "s-f") 'projectile-find-file)
(global-set-key (kbd "s-f") 'helm-projectile)
;; (global-set-key (kbd "s-g") 'projectile-grep)
(global-set-key (kbd "s-g") 'projectile-ag)
;; (global-set-key (kbd "s-g") 'projectile-ack)
(global-set-key (kbd "s-p") 'projectile-switch-project)
 
;; Resize Windows
(global-set-key (kbd "C-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<down>") 'shrink-window)
(global-set-key (kbd "C-M-<up>") 'enlarge-window)

(global-set-key (kbd "<f11>") 'menu-bar-mode)
(global-set-key (kbd "<f12>") 'indent-whole-buffer)

;; BOOKMARKS
(global-set-key (kbd "s-b") 'helm-bookmarks)

;; Ace Jump Mode
(define-key global-map (kbd "C-f") 'ace-jump-mode)

;;Helm
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "<f1>") 'helm-mini)
(global-set-key (kbd "S-<f1>") 'helm-projectile)

;;Project Explorer
(global-set-key (kbd "<f1>") 'project-explorer-open)


;;Query Replace Regex
(global-set-key (kbd "C-x C-r") 'query-replace-regexp)
(global-set-key (kbd "s-o") 'helm-swoop)
(global-set-key (kbd "s-O") 'helm-multi-swoop)
;; (global-set-key (kbd "s-o") 'helm-occur)
;; (global-set-key (kbd "s-O") 'helm-regexp)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update)

;; Macro bindings
;; (global-set-key (kbd "<f2>") 'apply-macro-to-region-lines)

;; Goto
(global-set-key [(meta g)] 'goto-line)

;;Special Buffer (loaded)
;; (global-set-key (kbd "C-b") 'ido-switch-buffer)
(global-set-key (kbd "C-b") 'helm-mini)
;; (global-set-key (kbd "M-b") 'projectile-switch-to-buffer)
(global-set-key (kbd "M-b") 'helm-projectile)

(global-set-key (kbd "C-x C-b") 'projectile-switch-to-buffer)

;; (global-set-key (kbd "C-x b") 'ibuffer)
;; (global-set-key (kbd "<M-up>") 'up-and-locate)
;; (global-set-key (kbd "<M-down>") 'down-and-locate)
(global-set-key [mouse-5] 'mouse-down-and-locate)
(global-set-key [mouse-4] 'mouse-up-and-locate)

(provide 'init-bindings)
