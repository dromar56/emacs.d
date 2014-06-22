;;Elscreen

;; (elscreen-set-prefix-key "\M-e")
;; (define-key elscreen-map (kbd  "t"		)  'elscreen-toggle-display-tab)
;; (define-key elscreen-map (kbd  "<right>"	)  'elscreen-next)
;; (define-key elscreen-map (kbd  "<left>"		)  'elscreen-previous)
;; (define-key elscreen-map (kbd  "C-<right>"	)  'elscreen-next)
;; (define-key elscreen-map (kbd  "C-<left>"	)  'elscreen-previous)
;; (define-key elscreen-map (kbd  "r"		)  'elscreen-screen-nickname)
;; (define-key elscreen-map (kbd  "c"		)  'elscreen-create)
;; (define-key elscreen-map (kbd  "k"		)  'elscreen-kill)
;; (define-key elscreen-map (kbd  "s"		)  'elscreen-swap)
;; (define-key elscreen-map (kbd  "t"		)  'elscreen-toggle-display-tab)
;; (define-key elscreen-map (kbd  "<right>"	)  'elscreen-next)
;; (define-key elscreen-map (kbd  "<left>"		)  'elscreen-previous)
;; (define-key elscreen-map (kbd  "C-<right>"	)  'elscreen-next)
;; (define-key elscreen-map (kbd  "C-<left>"	)  'elscreen-previous)


;; Anzu
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; Font size
(global-set-key (kbd "C-0") '(lambda ()  (interactive) (text-scale-set 0)))
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-<kb-0>") '(lambda ()  (interactive) (text-scale-set 0)))
(global-set-key (kbd "C-<kp-add>") 'text-scale-increase)
(global-set-key (kbd "C-<kp-subtract>") 'text-scale-decrease)

;; Occur
(global-set-key (kbd "M-o") 'helm-occur)
(global-set-key (kbd "C-M-o") 'helm-multi-occur)

;; A la carte Menu
(global-set-key (kbd "C-x c") 'lacarte-execute-menu-command)

;; helm-imenuu
(global-set-key (kbd "C-t") 'transpose-chars)
(global-set-key (kbd "M-t") 'transpose-words)
;; (global-set-key (kbd "C-t") 'idomenu)
;; (global-set-key (kbd "M-t") 'imenu-anywhere)

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

(global-set-key (kbd "C-<prior>") 'beginning-of-buffer)
(global-set-key (kbd "C-<next>") 'end-of-buffer)
(global-set-key (kbd "<prior>") 'scroll-down-command)
(global-set-key (kbd "<next>") 'scroll-up-command)
(global-set-key (kbd "M-<down>") (lambda () (interactive) (scroll-down -4)))
(global-set-key (kbd "M-<up>") (lambda () (interactive) (scroll-down 4)))

;; Magit Mode
(global-set-key (kbd "C-x g") 'magit-status)

;; Undo Tree mode
;; (global-set-key (kbd "C-+") 'undo-tree-redo)

;; iy-go-to-char
(global-set-key (kbd "C-M-.") 'iy-go-to-char)
(global-set-key (kbd "C-M-,") 'iy-go-to-char-backward)

;; multiple-cursors bindings
(global-set-key (kbd "s-M") 'mc/edit-lines)
(global-set-key (kbd "s-.") 'mc/mark-next-like-this)
(global-set-key (kbd "s-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "s->") 'mc/unmark-next-like-this)
(global-set-key (kbd "s-<") 'mc/unmark-previous-like-this)
(global-set-key (kbd "s-m") 'mc/mark-all-like-this)

(global-set-key (kbd "<C-down-mouse-1>") 'mc/add-cursor-on-click)


;; Expand region by semantics units
(global-set-key (kbd "s-\/") 'er/expand-region)
(global-set-key (kbd "s-?") 'er/contract-region)

;; Register Windows
(global-set-key (kbd "<f9>") '(lambda () (interactive) (jump-to-register 9)
				(message "Windows disposition loaded")))
(global-set-key (kbd "<f10>") '(lambda () (interactive) (window-configuration-to-register 9)
				 (message "Windows disposition saved")))

;; Projectile
(global-set-key (kbd "C-p") 'helm-projectile)
;; (global-set-key (kbd "s-d") 'projectile-find-dir)
(global-set-key (kbd "s-d") 'dired-jump)
;; (global-set-key (kbd "s-f") 'projectile-find-file)
(global-set-key (kbd "s-f") 'helm-projectile)
;; (global-set-key (kbd "s-g") 'projectile-grep)
;; (global-set-key (kbd "s-g") 'projectile-ag)
(global-set-key (kbd "s-g") 'helm-ag-projectile)
;; (global-set-key (kbd "s-g") 'projectile-ack)
(global-set-key (kbd "s-p") 'projectile-switch-project)
 
;; Resize Windows
(global-set-key (kbd "C-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<down>") 'shrink-window)
(global-set-key (kbd "C-M-<up>") 'enlarge-window)

;; (global-set-key (kbd "<f1>") 'helm-show-kill-ring)
(global-set-key (kbd "<f1>") 'keyboard-quit)
(global-set-key (kbd "<f2>") 'helm-all-mark-rings)
(global-set-key (kbd "s-y") 'helm-show-kill-ring)
(global-set-key (kbd "<f11>") 'menu-bar-mode)
(global-set-key (kbd "<f12>") 'indent-whole-buffer)

;; BOOKMARKS
(global-set-key (kbd "s-b") 'helm-bookmarks)

;; Ace Jump Mode
(define-key global-map (kbd "C-f") 'ace-jump-mode)

;;Helm
;; (global-set-key (kbd "C-x b") 'helm-mini)
;; (global-set-key (kbd "<f1>") 'helm-mini)
;; (global-set-key (kbd "S-<f1>") 'helm-projectile)

;;Project Explorer
;; (global-set-key (kbd "<f1>") 'project-explorer-open)


;;Query Replace Regex
(global-set-key (kbd "C-x C-r") 'query-replace-regexp)
(global-set-key (kbd "s-o") 'helm-swoop)
(global-set-key (kbd "s-O") 'my-projectile-multi-occur)
;; (global-set-key (kbd "s-O") 'helm-multi-swoop)
;; (global-set-key (kbd "s-o") 'helm-occur)
;; (global-set-key (kbd "s-O") 'helm-regexp)

;; (global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-M-x") 'helm-M-x)
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
;; (global-set-key (kbd "M-b") 'helm-projectile)

(global-set-key (kbd "C-x C-b") 'projectile-switch-to-buffer)

;; (global-set-key (kbd "C-x b") 'ibuffer)
;; (global-set-key (kbd "<M-up>") 'up-and-locate)
;; (global-set-key (kbd "<M-down>") 'down-and-locate)
(global-set-key [mouse-5] 'mouse-down-and-locate)
(global-set-key [mouse-4] 'mouse-up-and-locate)

(provide 'init-bindings)
