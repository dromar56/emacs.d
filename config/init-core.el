;;;;;;;;;;;;;;;;;;
;; Font lock speed
;;;;;;;;;;;;;;;;;;

(setq font-lock-support-mode 'jit-lock-mode)
(setq jit-lock-stealth-time
      16
      jit-lock-defer-contextually nil
      jit-lock-stealth-nice 0.5
      jit-lock-defer-time 0.05)

(setq font-lock-maximum-decoration 1)

;;;;;;;
;; MISC
;;;;;;;

(add-to-list 'load-path (concat user-emacs-directory "/vendor/neotree"))
(require 'neotree)

(require-package 'project-explorer)
(after 'project-explorer
  (setq pe/cache-directory (concat dotemacs-cache-directory "project-explorer/"))
  (setq pe/omit-regex (concat pe/omit-regex "\\|^node_modules$")))

(add-hook 'project-explorer-mode-hook (lambda () (linum-mode -1)))

;; Editing chrome areatext from emacs
(require-package 'edit-server)
(require 'edit-server)

(when (executable-find "ag")
  (require-package 'ag)
  (setq ag-highlight-search t)
  (require-package 'wgrep-ag))

;; Multicolor parenthesis
;; (require-package 'rainbow-delimiters)
;; (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(setq reb-re-syntax 'string) ;; fix backslash madness
(add-hook 'reb-mode-hook (lambda () (smartparens-strict-mode -1)))

(global-auto-revert-mode 1)
(electric-indent-mode t)
(transient-mark-mode 1)
(delete-selection-mode -1)

;; Enable access to the clipboard
(setq x-select-enable-clipboard t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; Try to fix the shell unicode problem
(defadvice ansi-term (after advise-ansi-term-coding-system)
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(ad-activate 'ansi-term)

;; winner-mode to undo/redo windows changes
(when (fboundp 'winner-mode)
  (winner-mode 1))

(put 'narrow-to-region 'disabled nil)

(require 'recentf)
;; (recentf-mode 1)
(setq recentf-max-menu-items 10)
;; (global-set-key "\C-x\ \C-r" 'recentf-open-files)

(require 'undo-tree)
(global-undo-tree-mode)

(add-hook 'after-init-hook #'global-flycheck-mode)



(require 'uniquify)
;; (setq uniquify-buffer-name-style 'reverse)

(require-package 'expand-region)
(require 'expand-region)

(require-package 'multiple-cursors)
(require 'multiple-cursors)

(require-package 'iy-go-to-char)
(require 'iy-go-to-char)
(add-to-list 'mc/cursor-specific-vars 'iy-go-to-char-start-pos)

(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (fundamental-mode)))
(add-hook 'find-file-hooks 'my-find-file-check-make-large-file-read-only-hook)

;;;;;;;;;
;; Eshell
;;;;;;;;;

;; eshell prompt color
(setq eshell-prompt-function (lambda nil
			       (concat
				(propertize (eshell/pwd) 'face `(:foreground "cyan"))
				(propertize " $" 'face `(:foreground "cyan"))
				(propertize " " 'face `(:foreground "white"))
				)))
(setq eshell-highlight-prompt nil)

;; Create a new eshell with prompt
(defun create-eshell ()
  "creates a shell with a given name"
  (interactive);; "Prompt\n eshell name:")
  (let ((eshell-name (read-string "eshell name: " nil)))
    (eshell (concat "Eshell/" eshell-name ))))

(defun create-shell ()
  "creates a shell with a given name"
  (interactive);; "Prompt\n shell name:")
  (let ((shell-name (read-string "shell name: " nil)))
    (shell (concat "Shell/" shell-name))))


;;;;;;;;;;;;;
;; Projectile
;;;;;;;;;;;;;

(projectile-global-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add prefix to Dired buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'dired-mode-hook 'ensure-buffer-name-ends-in-slash)
(defun ensure-buffer-name-ends-in-slash ()
  "change buffer name to end with slash"
  (let ((name (buffer-name)))
    (if (not (string-match "^Dir/" name))
        (rename-buffer (concat "Dir/" name) t))))

;;;;;;;;;;;;;;;;
;; Ace Jump Mode
;;;;;;;;;;;;;;;;

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

;;;;;;;;;;;;;;;;;;;
;; Eval and replace
;;;;;;;;;;;;;;;;;;;

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs Backfup Files settings (those damn annoying ~ files !)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq auto-save-file-name-transforms
      `((".*" ,"~/.saves/" t)))

;; remove those pesky lock files
(setq create-lockfiles nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tramp (remote connection)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'tramp)
(setq tramp-backup-directory-alist `(("." . "~/.saves_tramp")))
;; (add-to-list 'backup-directory-alist
;;              (cons tramp-file-name-regexp nil))

;;;;;;;;;;;
;; Ido-mode
;;;;;;;;;;;

(ido-mode t)
(ido-ubiquitous t)
(ido-vertical-mode t)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
(setq ido-auto-merge-work-directories-length -1)


(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-max-prospects 30)

(setq ido-ignore-buffers
      '("\\` " "^\*Mess" "^\*Back" ".*Completion" "^\*Ido" "^\*trace"
	"^\*compilation" "^\*GTAGS" "^session\.*" "^\*Compile-Log\*"
	;; "^\*"
	)
      )

(require 'flx-ido)
(ido-everywhere 1)
(flx-ido-mode 1)

;;;;;;;;;;;;;;;;;;;;;;
;; Mouse/Wheel options
;;;;;;;;;;;;;;;;;;;;;;

(defun up-and-locate()
  (interactive)
  (scroll-down 8)
  )

(defun down-and-locate()
  (interactive)
  (scroll-down -8)
  )

(defun mouse-up-and-locate()
  (interactive)
  (scroll-down 3)
  )

(defun mouse-down-and-locate()
  (interactive)
  (scroll-down -3)
  )


;;;;;;;;;;;;;;;;;;;;;;
;; Indent Whole Buffer
;;;;;;;;;;;;;;;;;;;;;;

(defun indent-whole-buffer ()
  "indent whole buffer and untabify it"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FIX FOR TERMINAL SHIFT+UP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if (equal "xterm" (tty-type))
    (define-key input-decode-map "\e[1;2A" [S-up]))

(defadvice terminal-init-xterm (after select-shift-up activate)
  (define-key input-decode-map "\e[1;2A" [S-up]))

;;;;;;;;;;;;;;;;;;;;;
;; Locked buffer mode
;;;;;;;;;;;;;;;;;;;;;

(define-minor-mode locked-buffer-mode
  "Make the current window always display this buffer."
  nil " locked" nil
  (set-window-dedicated-p (selected-window) locked-buffer-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Save undo history when revert-buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; emacs doesn't actually save undo history with revert-buffer
;; see http://lists.gnu.org/archive/html/bug-gnu-emacs/2011-04/msg00151.html
;; fix that.
(defun revert-buffer-keep-history (&optional IGNORE-AUTO NOCONFIRM PRESERVE-MODES)
  (interactive)

  ;; tell Emacs the modtime is fine, so we can edit the buffer
  (clear-visited-file-modtime)

  ;; insert the current contents of the file on disk
  (widen)
  (delete-region (point-min) (point-max))
  (insert-file-contents (buffer-file-name))

  ;; mark the buffer as not modified
  (not-modified)
  (set-visited-file-modtime))

(setq revert-buffer-function 'revert-buffer-keep-history)
(add-hook 'after-revert-hook  (lambda ()   (font-lock-fontify-buffer)))


;;;;;;;;;;;;;;;;;
;; Search engines
;;;;;;;;;;;;;;;;;

(defun prelude-search (query-url prompt)
  "Open the search url constructed with the QUERY-URL.
PROMPT sets the `read-string prompt."
  (browse-url
   (concat query-url
           (url-hexify-string
            (if mark-active
                (buffer-substring (region-beginning) (region-end))
              (read-string prompt))))))

(defmacro prelude-install-search-engine (search-engine-name search-engine-url search-engine-prompt)
  "Given some information regarding a search engine, install the interactive command to search through them"
  `(defun ,(intern (format "prelude-%s" search-engine-name)) ()
     ,(format "Search %s with a query or region if any." search-engine-name)
     (interactive)
     (prelude-search ,search-engine-url ,search-engine-prompt)))

(prelude-install-search-engine "google"     "http://www.google.com/search?q="              "Google: ")
(prelude-install-search-engine "youtube"    "http://www.youtube.com/results?search_query=" "Search YouTube: ")
(prelude-install-search-engine "github"     "https://github.com/search?q="                 "Search GitHub: ")
(prelude-install-search-engine "duckduckgo" "https://duckduckgo.com/?t=lm&q="              "Search DuckDuckGo: ")
(prelude-install-search-engine "angular"     "https://www.google.com/search?as_sitesearch=angularjs.org&as_q=" "AngularJS: ")


;;;;;;;;;;;;;;;;;;
;; Mode Line color
;;;;;;;;;;;;;;;;;;

(provide 'init-core)
