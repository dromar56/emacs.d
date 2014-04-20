;; Occur
(global-set-key (kbd "M-o") 'helm-occur)
(global-set-key (kbd "C-M-o") 'helm-multi-occur)

;;SWANK-JS MODE IS FUCKING AWESOME
(global-set-key [f5] 'slime-js-reload)

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
(global-set-key (kbd "C-x |") 'split-window-right)
(global-set-key (kbd "C-x -") 'split-window-below)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "M-<right>") 'other-window)
(global-set-key (kbd "M-<left>") '(lambda (&optional n)
					     (interactive "P") (other-window -1)))




;; Magit Mode
(global-set-key (kbd "C-x g") 'magit-status)

;; Undo Tree mode
;; (global-set-key (kbd "C-+") 'undo-tree-redo)

;;yasnippet
(global-set-key (kbd "C-?") 'yas-insert-snippet)

;;create shell with name
(global-set-key (kbd "C-c C-s") 'create-shell)
(global-set-key (kbd "C-c C-e") 'create-eshell)

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

;; FUCKING AMAZING KEY CHORDS MODE OH MY GOD
(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  (key-chord-define-global "jk"     'ace-jump-mode)
  (key-chord-define-global "/g"     'magit-status)
  ;; (key-chord-define-global "df"     'goto-line)
  )

;; Expand region by semantics units
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-/") 'er/expand-region)
(global-set-key (kbd "s-/") 'er/expand-region)

;; Eval and replace
;; (global-set-key (kbd "C-x C-e") 'eval-and-replace)


;; Disable mouse
(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
             [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
  (global-unset-key k))

;; Compile
(global-set-key (kbd "C-c C-c") 'compile)

;; Register Windows
(global-set-key (kbd "<f9>") '(lambda () (interactive) (jump-to-register 9)
				(message "Windows disposition loaded")))
(global-set-key (kbd "<f10>") '(lambda () (interactive) (window-configuration-to-register 9)
				 (message "Windows disposition saved")))

;; Navigating Sexp
;; (global-set-key (kbd "M-[") 'backward-sexp)
;; (global-set-key (kbd "M-]") 'forward-sexp)


;; Projectile
(global-set-key (kbd "C-x p") 'helm-projectile)
(global-set-key (kbd "<S-f1>") 'helm-projectile)
(global-set-key (kbd "s-d") 'projectile-find-dir)
(global-set-key (kbd "s-f") 'projectile-find-file)
(global-set-key (kbd "s-g") 'projectile-grep)
;; (global-set-key (kbd "s-g") 'projectile-ag)
(global-set-key (kbd "s-p") 'projectile-switch-project)

;; Switch Windows
;; (global-set-key (kbd "C-q") 'other-window)
;; (global-set-key (kbd "<C-tab>") 'other-window)
;; (global-set-key (kbd "<C-S-iso-lefttab>") '(lambda (&optional n)
;; 					     (interactive "P") (other-window (or n 2))))

;; Resize Windows
(global-set-key (kbd "C-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<down>") 'shrink-window)
(global-set-key (kbd "C-M-<up>") 'enlarge-window)

;; Function keys F5-F12
;; (global-set-key (kbd "<f5>") 'helm-multi-occur)
;; (global-set-key (kbd "<f6>") 'rgrep)
;; (global-set-key (kbd "<f7>") 'eshell)


;; (global-set-key (kbd "<f9>") 'compile)
;; (global-set-key (kbd "C-c C-c") 'compile)
;; (global-set-key (kbd "<f10>") 'gdb)
;;(global-set-key (kbd "<f11>") 'gdb-many-windows)
(global-set-key (kbd "<f11>") 'menu-bar-mode)
(global-set-key (kbd "<f12>") 'indent-whole-buffer)
;; (global-set-key (kbd "<f11>") 'count-lines-function)




;; BOOKMARKS

(global-set-key (kbd "C-x C-b") 'helm-bookmarks)
;; (define-prefix-command 'bookmarks)
;; (global-set-key (kbd "C-b") 'helm-bookmarks)
;; (define-key bookmarks (kbd "m") 'bookmark-set)
;; (define-key bookmarks (kbd "s") 'bookmark-save)
;; (define-key bookmarks (kbd "j") 'bookmark-jump)
;; (define-key bookmarks (kbd "l") 'bookmark-bmenu-list)

;; Auto-Complete
(global-set-key (kbd "<M-tab>") 'auto-complete)

;; Ace Jump Mode
(define-key global-map (kbd "C-f") 'ace-jump-mode)
(define-key global-map (kbd "M-f") 'ace-jump-mode-pop-mark)

;;Helm
(global-set-key (kbd "<f1>") 'helm-mini)
(global-set-key (kbd "C-x h") 'helm-mini)
(global-set-key (kbd "C-x b") 'helm-mini)


;;Query Replace Regex
(global-set-key (kbd "<f8>") 'helm-regexp)
(global-set-key (kbd "C-x C-r") 'query-replace-regexp)
;; (global-set-key (kbd "C-x 5") 'query-replace)

;; (global-set-key (kbd "C-x r") 'keep-lines)
;; (global-set-key (kbd "C-x r") 'flush-lines)
;; (global-set-key (kbd "C-x 5") 'how-many)
(global-set-key (kbd "s-o") 'helm-occur)


;; Switch Buffer
;; (global-set-key (kbd "C-b") 'ido-switch-buffer)

;; Smex Bindings (ido-mode for M-x)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update)
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Macro bindings

(global-set-key (kbd "<f2>") 'apply-macro-to-region-lines)

;; Add count-lines-function to c-mode

(defun my-c-mode-hook ()
  (local-set-key (kbd "C-c C-w") 'count-lines-function)
  )
(add-hook 'c-mode-hook 'my-c-mode-hook)

;; Goto

(global-set-key [(meta g)] 'goto-line)

;;Special Buffer (loaded)

;; (global-set-key (kbd "C-x b") 'bs-show)
;; (global-set-key (kbd "C-x b") 'ido-switch-buffer)
(global-set-key (kbd "C-b") 'ido-switch-buffer)
(global-set-key (kbd "<M-up>") 'up-and-locate)
(global-set-key (kbd "<M-down>") 'down-and-locate)
(global-set-key [mouse-5] 'mouse-down-and-locate)
(global-set-key [mouse-4] 'mouse-up-and-locate)


;; Tabbar

;; (global-set-key (kbd "C-x <right>") 'tabbar-forward-group)
;; (global-set-key (kbd "C-x <left>") 'tabbar-backward-group)
;; (global-set-key (kbd "M-<right>") 'tabbar-forward-tab)
;; (global-set-key (kbd "M-<left>") 'tabbar-backward-tab)


;; "Mode" Shortcuts

;; (global-set-key (kbd "C-c h") 'hexl-mode)
;; (global-set-key (kbd "C-c c") 'c-mode)
;; (global-set-key (kbd "<f1>") 'nxhtml-mode)
;; (global-set-key (kbd "<f1>") 'html-mode)
;; (global-set-key (kbd "<f2>") 'php-mode)
;; (global-set-key (kbd "<f3>") 'css-mode)
;; (global-set-key (kbd "<f4>") 'js-mode)
;; (global-set-key (kbd "<f5>") 'nxhtml-mumamo-mode)
;; (global-set-key (kbd "<f6>") 'c-mode)


;; Cycling Windows

;; (global-set-key (kbd "M-.") '(lambda () (interactive) (other-window 1)))
;; (global-set-key (kbd "<backtab>") '(lambda () (interactive) (other-window 1)))
;; (global-set-key (kbd "M-,") '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x C-<left>") '(lambda () (interactive) (other-window 1)))
(global-set-key (kbd "C-x C-<right>") '(lambda () (interactive) (other-window -1)))
