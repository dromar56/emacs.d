(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(setq package-enable-at-startup nil)

;; ZOMG C'ETAIS TELLEMENT FUCKING EASY - RIEN NE MARCHE SANS CE TRUC
(package-initialize)

(defun require-package (package)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

(if (fboundp 'with-eval-after-load)
    (defmacro after (feature &rest body)
      "After FEATURE is loaded, evaluate BODY."
      (declare (indent defun))
      `(with-eval-after-load ,feature ,@body))
  (defmacro after (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
    `(eval-after-load ,feature
       '(progn ,@body))))


(defmacro lazy-major-mode (pattern mode)
  "Defines a new major-mode matched by PATTERN, installs MODE if necessary, and activates it."
  `(add-to-list 'auto-mode-alist
                '(,pattern . (lambda ()
                             (require-package (quote ,mode))
                             (,mode)))))


(defun my-recompile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  (byte-recompile-directory (concat user-emacs-directory "config") 0))


(defun my-window-killer ()
  "closes the window, and deletes the buffer if it's the last window open."
  (interactive)
  (if (> buffer-display-count 1)
      (if (= (length (window-list)) 1)
          (kill-buffer)
        (delete-window))
    (kill-buffer-and-window)))


(defun my-minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))


(defun set-transparency (alpha)
  "Sets the transparency of the current frame."
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha alpha))


(defun my-google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning) (region-end))
                         (read-string "Search Google: "))))))


(defun my-copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))


(defun my-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (let ((value (eval (preceding-sexp))))
    (backware-kill-sexp)
    (insert (format "%s" value))))


(defun my-rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))


(defun my-delete-current-buffer-file ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (when (y-or-n-p (format "Are you sure you want to delete %s? " filename))
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))


(defun my-goto-scratch-buffer ()
  "Create a new scratch buffer."
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (emacs-lisp-mode))


(defun my-insert-last-kbd-macro ()
  (interactive)
  (name-last-kbd-macro 'my-last-macro)
  (insert-kbd-macro 'my-last-macro))

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(require 'macro)

;;;;;;;;;;;;;;;;;;;;;;
;; Save Macro Function
;;;;;;;;;;;;;;;;;;;;;;

(defun save-macro (name)
  "save a macro. Take a name as argument
     and save the last defined macro under
     this name at the end of init-macro.el"
  (interactive "SName of the macro :")  ; ask for the name of the macro
  (kmacro-name-last-macro name)         ; use this name for the macro
  (find-file (concat user-emacs-directory "elisp/macro.el"))            ; open ~/.emacs or other user init file
  (goto-char (point-min))               ; go to the end of the .emacs
  (insert-kbd-macro name)               ; copy the macro
  (newline)                             ; insert a newline
  (newline)                             ; insert a newline
  (newline)                             ; insert a newline
  (switch-to-buffer nil))               ; return to the initial buffer

;; (setq helm-command-prefix-key "C-c h")
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)
(customize-set-variable 'helm-truncate-lines t)

(require-package 'helm)
(require-package 'helm-swoop)

;; (require 'helm-config)
;; (helm-mode 1)

(require-package 'wgrep-helm)
;; (require 'wgrep-helm)

(defadvice helm-mini (before winner-skip-helm activate)
  (winner-mode -1))
(defadvice helm-mini (after winner-skip-helm activate)
  (winner-mode 1))

(defadvice helm-projectile (before winner-skip-helm activate)
  (winner-mode -1))
(defadvice helm-projectile (after winner-skip-helm activate)
  (winner-mode 1))

 (customize-set-variable 'helm-boring-buffer-regexp-list
   (quote
    ("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*Minibuf" "^\\*")))
 (customize-set-variable 'helm-buffer-max-length 30)
 (customize-set-variable 'helm-candidate-number-limit 200)

(require-package 'helm-ag)
(setq helm-ag-thing-at-point 'symbol)
(defun helm-ag-projectile ()
  (interactive)
  (helm-ag (projectile-project-root)))

 (customize-set-variable 'helm-ag-base-command "ag")
 (customize-set-variable 'helm-ag-command-option
   "--nocolor --nogroup --ignore-dir node_modules --ignore-dir elpa")

(setq helm-dash-browser-func 'browse-url)
;; (setq helm-dash-browser-func 'eww)

(projectile-global-mode t)
(customize-set-variable 'projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "node_modules" "elpa")))
(customize-set-variable 'projectile-remember-window-configs nil)
(customize-set-variable 'projectile-switch-project-action (quote projectile-dired))
(customize-set-variable 'projectile-tags-command "ctags -Re %s %s")

(after 'projectile
  (require-package 'helm-projectile))

  (customize-set-variable 'helm-projectile-sources-list '(helm-source-projectile-buffers-list
                                                          helm-source-projectile-files-list
                                                          helm-source-projectile-recentf-list))

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; (global-set-key (kbd "<C-S-right>") 'helm-occur)

(eval-after-load "org"
'(progn
   (define-key org-mode-map (kbd "<C-S-up>") 'outline-up-heading)
;; (define-key org-mode-map (kbd "<C-S-right>") 'nil)
;; (define-key org-mode-map (kbd "<C-left>") nil)
;; (define-key org-mode-map (kbd "<C-right>") nil)
(define-key org-mode-map (kbd "M-<down>") 'nil)
(define-key org-mode-map (kbd "M-<up>") 'nil)))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(customize-set-variable 'org-export-backends (quote (ascii html icalendar latex md)))

(setq org-main-file "~/org/notes.org")
(setq org-directory "~/org")

(setq org-agenda-files '("~/org"))
(load-library "find-lisp")
(setq org-agenda-files (find-lisp-find-files org-directory "\.org$"))

      ;; (setq org-agenda-files (list org-main-file))

(setq org-default-notes-file org-main-file)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-t") 'org-capture)

(defun d4g-get-project-org-name ()
  "Return the name of the projectile project"
  (replace-regexp-in-string "[^[:alnum:]]" "-" 
                            (car (last (split-string projectile--project-root "/" t)))))

(defun d4g-get-project-org-file ()
  "Return the path to the project org file"
  (concat org-directory "/projects/" 
          (d4g-get-project-org-name)
          ".org"))

(defun d4g-find-project-org-file-task ()
  "Find the org file associated with the current projectile project, creating it if needed, and place the point at the end of 'Tasks' subtree."
  (let ((project-file (d4g-get-project-org-file))
        (project-headline-regexp "^\\* Tasks")
        (project-name (d4g-get-project-org-name)))
    (set-buffer (find-file-noselect project-file))
    (goto-char (point-min))
    (if (not (re-search-forward project-headline-regexp nil t))
        (progn
          (goto-char (point-max))
          (if (not (eq (buffer-size) 0))
              (newline 2))
          (insert (concat "* Tasks :project:" project-name ":"))))
    (goto-char (point-min))
    (re-search-forward project-headline-regexp)
    (end-of-line)))

(setq org-capture-templates
      '(("p" "Project" entry (function find-project-org-file-task)
         "* TODO %?\n  %a\n  %i")
        ("t" "Todo" entry (file+headline "~/org/todo.org" "Todo")
         "* TODO %?\n  %a\n  %i")
        ("n" "Note" entry (file+headline "~/org/notes.org" "Notes")
         "* %?\n  %a\n  %i")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %a\n  %i")
        ("J" "Journal - more options")
        ("Jc" "Journal Clipboard" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %x\n  %a")))


(setq org-capture-templates-contexts
      '(("p" ((lambda () "DOCSTRING" (interactive) projectile--project-root)))))

(setq close-frame-after-org-capture-frame nil)
(setq close-frame-after-org-capture-frame (selected-frame))

(defun close-frame-after-org-capture ()
  (remove-hook 'org-capture-after-finalize-hook 'close-frame-after-org-capture)
  (delete-frame))

(global-set-key (kbd "<f1>") 'helm-spaces)
(key-chord-define-global "e3" 'helm-spaces)

(key-chord-mode t)

(require-package 'company)
(require 'company)

(setq company-idle-delay 0)

(defun company-auto-completion-toggle ()
  (interactive)
  (if (eq company-idle-delay 0)
      (setq company-idle-delay nil)
    (setq company-idle-delay 0)))

(global-set-key (kbd "M-c") 'company-auto-completion-toggle)

(setq company-minimum-prefix-length 1)
(setq company-show-numbers 1)
(setq company-tooltip-limit 10)

(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case nil)

(customize-set-variable 'company-dabbrev-char-regexp "[a-zA-Z0-9-_]")
(customize-set-variable 'company-selection-wrap-around t)


(set-face-attribute 'company-tooltip nil :background "black" :foreground "gray40")
(set-face-attribute 'company-tooltip-selection nil :inherit 'company-tooltip :background "gray15")
(set-face-attribute 'company-preview nil :background "black")
(set-face-attribute 'company-preview-common nil :inherit 'company-preview :foreground "gray40")
(set-face-attribute 'company-scrollbar-bg nil :inherit 'company-tooltip :background "gray20")
(set-face-attribute 'company-scrollbar-fg nil :background "gray40")

(when (executable-find "tern")
  (after "company-tern-autoloads"
    (add-to-list 'company-backends 'company-tern)))
(add-to-list 'company-backends 'company-tern)

(setq company-global-modes
      '(not
        eshell-mode comint-mode org-mode))


(global-set-key (kbd "C-o") 'company-manual-begin)
(global-set-key (kbd "M-o") 'company-tern)
(global-set-key (kbd "M-?") 'company-dabbrev)

(defadvice company-complete-common (around advice-for-company-complete-common activate)
  (when (null (yas-expand))
    ad-do-it))

(add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;
;; yasnippet
;;;;;;;;;;;;

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))

(require-package 'yasnippet)
(require 'yasnippet)

(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)
(define-key yas-minor-mode-map (kbd "C-c TAB") 'yas-insert-snippet)

(yas-global-mode 1)

(require-package 'smartparens)
;; (require 'smartparens-config)

(setq sp-show-pair-delay 0)
(setq sp-show-pair-from-inside 1) ;; Shows two pair of parenthesis when used with show-paren-mode

(setq sp-autoescape-string-quote nil)
(setq sp-autoinsert-if-followed-by-same 1)
(setq sp-highlight-pair-overlay nil)

(sp-use-smartparens-bindings)
(smartparens-global-mode t)
(smartparens-global-strict-mode t)

(show-smartparens-global-mode t)
(show-paren-mode 1)


(sp-pair "`" nil :actions :rem)

(sp-with-modes sp--lisp-modes
  (sp-local-pair "'" nil :actions nil)
  )


(define-key sp-keymap (kbd "M-<right>") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "M-<left>") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "C-<right>") 'nil)
(define-key sp-keymap (kbd "C-<left>") 'nil)
;; (define-key sp-keymap "`" 'nil)
;; (define-key sp-keymap 96 'nil)

;; (define-key smartparens-strict-mode-map [remap kill-line] 'nil)
;; (define-key smartparens-strict-mode-map (kbd "M-k") 'sp-kill-hybrid-sexp)
(define-key smartparens-strict-mode-map [remap kill-line] 'sp-kill-hybrid-sexp)


;; fix conflict where smartparens clobbers yas' key bindings
(after 'yasnippet
  (defadvice yas-expand (before advice-for-yas-expand activate)
    (sp-remove-active-pair-overlay)))

(defadvice sp-kill-hybrid-sexp (before kill-line-cleanup-whitespace activate)
  "cleanup whitespace on sp-kill-hybrid-sexp"
  (if (bolp)
      (delete-region (point) (progn (skip-chars-forward " \t") (point)))))

(require-package 'evil)
(require 'evil)

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

(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'bar
                      'box)))

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

(global-set-key (kbd "<escape>") 'god-mode-all)
(after 'god-mode
  (define-key god-local-mode-map (kbd "i") 'god-mode)
  (define-key god-local-mode-map (kbd "<right>")        'windmove-right)
  (define-key god-local-mode-map (kbd "<left>") 'windmove-left)
  (define-key god-local-mode-map (kbd "<down>") 'windmove-down)
  (define-key god-local-mode-map (kbd "<up>")   'windmove-up))

;;==========
;; Undo tree
;;==========

(require-package 'undo-tree)
(require 'undo-tree)
(global-undo-tree-mode)
;; Unmap 'C-x r' to avoid conflict with discover
(after 'undo-tree
  (define-key undo-tree-map (kbd "C-x r") nil))

(require-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(customize-set-variable 'flycheck-disabled-checkers (quote (emacs-lisp-checkdoc)))
(customize-set-variable 'flycheck-idle-change-delay 0.5)

;; For a cleaner modeline
(require-package 'diminish)
(diminish 'visual-line-mode)
(after 'autopair (diminish 'autopair-mode))
(after 'undo-tree (diminish 'undo-tree-mode))
(after 'auto-complete (diminish 'auto-complete-mode))
(after 'projectile (diminish 'projectile-mode))
(after 'yasnippet (diminish 'yas-minor-mode))
(after 'guide-key (diminish 'guide-key-mode))
(after 'eldoc (diminish 'eldoc-mode))
(after 'smartparens (diminish 'smartparens-mode))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))
(after 'magit (diminish 'magit-auto-revert-mode))
;; (after 'helm (diminish 'helm-mode))
(after 'anzu (diminish 'anzu-mode))
(after 'skewer (diminish 'skewer-mode))
(after 'tern (diminish 'tern-mode))
;; (after 'company (diminish 'company-mode))

(require 'tramp)
(setq tramp-backup-directory-alist `(("." . "~/.saves_tramp")))
;; (add-to-list 'backup-directory-alist
;;              (cons tramp-file-name-regexp nil))

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

(key-chord-define-global "jk" 'ace-jump-word-mode)

(when (executable-find "ag")
      (require-package 'ag)
      (setq ag-highlight-search t)
      (require-package 'wgrep-ag))
(customize-set-variable 'ag-arguments
   (quote
    ("--smart-case" "--nogroup" "--column" "--ignore-dir" "node_modules" "--ignore-dir" "elpa")))
(customize-set-variable 'ag-highlight-search t)

(window-numbering-mode t)

(setq help-window-select t)

    (customize-set-variable 'scroll-bar-mode (quote right))
    (customize-set-variable 'scroll-conservatively 100000)
    (customize-set-variable 'scroll-preserve-screen-position 1)

    (customize-set-variable 'show-paren-delay 0)
    (customize-set-variable 'show-paren-mode t)
    (customize-set-variable 'smex-history-length 1000)
    (customize-set-variable 'recentf-auto-cleanup (quote never))
    (customize-set-variable 'recentf-max-saved-items 200000)



    (setq inhibit-startup-screen t)


        ;;;;;;;
    ;; MISC
        ;;;;;;;

    ;; (add-to-list 'load-path (concat user-emacs-directory "/vendor/neotree"))
    ;; (require 'neotree)

    ;; (require-package 'project-explorer)
    ;; (after 'project-explorer
    ;;   (setq pe/cache-directory (concat (concat user-emacs-directory ".cache/") "project-explorer/"))
    ;;   (setq pe/omit-regex (concat pe/omit-regex "\\|^node_modules$")))
    ;; (add-hook 'project-explorer-mode-hook (lambda () (linum-mode -1)))

    ;; Editing chrome areatext from emacs
    ;; (require-package 'edit-server)
    ;; (require 'edit-server)


    (setq reb-re-syntax 'string) ;; fix backslash madness
    (add-hook 'reb-mode-hook (lambda () (smartparens-strict-mode -1)))

    (global-auto-revert-mode 1)
    (electric-indent-mode -1)
    (transient-mark-mode 1)
    (delete-selection-mode -1)

    ;; Enable access to the clipboard
    (setq x-select-enable-clipboard t)

    (defalias 'yes-or-no-p 'y-or-n-p)

    ;; Try to fix the shell unicode problem
    (defadvice ansi-term (after advise-ansi-term-coding-system)
      (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
    (ad-activate 'ansi-term)

    (put 'narrow-to-region 'disabled nil)

    (require 'recentf)
    ;; (recentf-mode 1)
    (setq recentf-max-menu-items 10)
    ;; (global-set-key "\C-x\ \C-r" 'recentf-open-files)

    (require 'uniquify)
    (customize-set-variable 'uniquify-buffer-name-style 'post-forward-angle-brackets)
    (customize-set-variable 'uniquify-strip-common-suffix t)

    ;; (setq uniquify-buffer-name-style 'reverse)

    ;;todo
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

               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; Add prefix to Dired buffers
               ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    (add-hook 'dired-mode-hook 'ensure-buffer-name-ends-in-slash)
    (defun ensure-buffer-name-ends-in-slash ()
      "change buffer name to end with slash"
      (let ((name (buffer-name)))
        (if (not (string-match "^Dir/" name))
            (rename-buffer (concat "Dir/" name) t))))

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

    ;;todo
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

(defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows intelligently.
Intelligently means: region, subtree, or defun, whichever applies
first.

With prefix P, don't widen, just narrow even if buffer is already
narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode) (org-narrow-to-subtree))
        (t (narrow-to-defun))))

(setq ido-default-buffer-method 'selected-window)

(defun set-frame-font-size (size)
  (interactive "nSize:")
  (set-face-attribute 'default (selected-frame) :height size)
  )

;; Doesn't work ...
;; (add-hook 'after-make-frame-functions (lambda () (interactive) (set-frame-font-size 100)))

(require-package 'anzu)
(global-anzu-mode 1)

;; Multicolor parenthesis
;; (require-package 'rainbow-delimiters)
;; (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)



;; (load-theme 'wombat t)
;; (if (daemonp)
;; (add-hook 'after-make-frame-functions
;;           '(lambda (f)
;;              (progn
;;                (sml/setup)
;;                (with-selected-frame f
;;                  (when (window-system f)
;;                    (set-cursor-color "white")))))))

;; (set-cursor-color "#ffffff")
;; (set-face-attribute 'default nil :height 100)

;; Show indentation
(require-package 'indent-guide)
(require 'indent-guide)

;; Nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(menu-bar-mode 0)
(tool-bar-mode 0)

(which-function-mode t)
(blink-cursor-mode -1)

;; (global-linum-mode t)
(setq linum-format " %2d ")

(if (fboundp 'global-prettify-symbols-mode)
    (progn
      (global-prettify-symbols-mode)
      (add-hook 'js2-mode-hook
                (lambda ()
                  (push '("function" . 955) prettify-symbols-alist)
                  (push '("return" . 8592) prettify-symbols-alist))))
  (progn
    (require-package 'pretty-symbols)
    (require 'pretty-symbols)
    (diminish 'pretty-symbols-mode)
    (add-to-list 'pretty-symbol-categories 'js)
    (add-to-list 'pretty-symbol-patterns '(955 js "\\<function\\>" (js2-mode)))
    (add-to-list 'pretty-symbol-patterns '(8592 js "\\<return\\>" (js2-mode)))
    (add-hook 'find-file-hook 'pretty-symbols-mode)))

(set-face-attribute 'window-numbering-face nil 
                    :background "cyan" 
                    :foreground "black"
                    :weight 'semi-bold )

(require-package 'smart-mode-line)
    (setq sml/show-client t)
    (setq sml/show-eol t)
    (setq sml/show-frame-identification t)

(customize-set-variable 'sml/hidden-modes (quote (" hl-p" " Helm" " skewer")))
(customize-set-variable 'sml/show-file-name t)
(customize-set-variable 'sml/use-projectile-p (quote before-prefixes))

(setq sml/theme 'dark)
    (sml/setup)

(load-theme 'sanityinc-tomorrow-eighties t)
(setq default-frame-alist '((cursor-color . "#f2777a")))

(set-face-attribute 'org-level-1 nil :height 1.3)
(set-face-attribute 'org-level-2 nil :height 1.2)
(set-face-attribute 'org-level-3 nil :height 1.1 :foreground "#69C031")

;;;;;;;;;;;;;;;;;;
;; Font lock speed
;;;;;;;;;;;;;;;;;;

(setq font-lock-support-mode 'jit-lock-mode)
(setq jit-lock-stealth-time
      16
      jit-lock-defer-contextually nil
      jit-lock-stealth-nice 0.5
      jit-lock-defer-time 0.05)

(setq font-lock-maximum-decoration 0)

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

;; Add count-lines-function to c-mode
(defun my-c-mode-hook ()
  (local-set-key (kbd "C-c C-w") 'count-lines-function)
  )
(add-hook 'c-mode-hook 'my-c-mode-hook)
;; (add-hook 'c-mode-common-hook   (lambda () (highlight-80+-mode t) ) )

;; coffeescript
(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent
       (setq coffee-args-compile (quote ("-c" "--bare"))))
     (setq coffee-tab-width 4)))

(require 'sws-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))

(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))


(add-hook 'jade-mode-hook 'enable-indent-guide)
(defun enable-indent-guide ()
  "Enable indent guide mode"
  (indent-guide-mode t))


(add-hook 'jade-mode-hook '(lambda () (interactive) (yas-minor-mode -1)))
(add-hook 'jade-mode-hook '(lambda () (interactive) (smartparens-strict-mode -1)))


;; First create new face which is a copy of hl-line-face
(copy-face 'font-lock-type-face 'font-lock-type-face-jade-mode)

;; Change what you want in this new face
(set-face-attribute 'font-lock-type-face-jade-mode
                    '(:foreground "blue" :weight normal))

;; The function to use the new face
(defun my-jade-type-face ()
  (set (make-local-variable 'font-lock-type-face) ; This is how to make it local
       'font-lock-type-face-jade-mode))

;; Finally, the hook
(add-hook 'jade-mode-hook 'my-jade-type-face)

;; Javascript improved mode js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")
;; eg. extract function with `C-c C-m ef`.

(customize-set-variable 'js2-bounce-indent-p nil)
(customize-set-variable 'js2-global-externs [global require])
(customize-set-variable 'js2-include-node-externs t)

;; SLIME - SWANK-JS
(require 'slime)
;; (autoload 'slime "slime" "Slime" t)

(ignore-errors
  (slime-setup '(slime-js2 slime-repl))
  (add-hook 'js2-mode-hook
            (lambda ()
              (slime-js-minor-mode 1)))
  (add-hook 'css-mode-hook
            (lambda ()
              (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
              (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css))))


;;SWANK-JS MODE IS FUCKING AWESOME
(global-set-key [f5] 'slime-js-reload)

;; ;; SKEWER
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;; TERN
;; (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
;; (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
;; (eval-after-load 'tern
;;   '(progn
;;      (require 'tern-auto-complete)
;;      ;; (tern-ac-setup)
;;      (define-key tern-mode-keymap (kbd "C-o") 'tern-ac-complete)
;;      ))

(require-package 'company-tern)

 (when (executable-find "tern")
    (require-package 'tern)
    (add-hook 'js2-mode-hook 'tern-mode)
    (after 'tern
      ))

(load "~/.emacs.d/vendor/livescript-mode.el")

;; Javascript improved mode js2-mode
(add-to-list 'auto-mode-alist '("\\.ls\\'" . livescript-mode))

(defun livescript-eval ()
  (local-set-key (kbd "C-x C-e") 'livescript-compile-region))
(add-hook 'livescript-mode-hook 'livescript-eval)

(setq auto-mode-alist (cons '("\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

(autoload 'php-mode "php-mode.el" "Php mode." t)
(setq auto-mode-alist (append '(("/*.\.php[345]?$" . php-mode)) auto-mode-alist))

;; (require 'elpy nil t)
(elpy-enable)
(elpy-use-ipython "ipython2")
;; (elpy-clean-modeline)

(defun elpy-use-python3 (args)
  (elpy-use-ipython "ipython2")
  (interactive "P")
  )

(setq elpy-rpc-backend "jedi")

;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)                ; optional

;; Ignoring electric indentation
(defun electric-indent-ignore-python (char)
  "Ignore electric indentation for python-mode"
  (if (equal major-mode 'python-mode)
      `no-indent'
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-python)

;; Fix yasnippet indentation in python-mode
(add-hook 'python-mode-hook
   '(lambda () (set (make-local-variable 'yas-indent-line) 'fixed)
      (company-mode -1)))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))


(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

(global-set-key (kbd "C-h a") 'apropos)

(global-set-key (kbd "M-n")     'forward-paragraph)
(global-set-key (kbd "M-p")     'backward-paragraph)

(global-set-key (kbd "C-c n")   'winner-redo)
(global-set-key (kbd "C-c p")   'winner-undo)

(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-0") 'delete-window)

(global-set-key (kbd "C-;") 'repeat)

(global-set-key (kbd "s-n") 'narrow-or-widen-dwim)

(global-set-key (kbd "C-z") 'helm-mini)
(global-set-key (kbd "M-z") 'helm-projectile)



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
;; (global-set-key (kbd "C-t") 'transpose-chars)
;; (global-set-key (kbd "M-t") 'transpose-words)
;; (global-set-key (kbd "C-t") 'idomenu)
;; (global-set-key (kbd "M-t") 'imenu-anywhere)

;; helm-etags
;; (global-set-key (kbd "M-t") 'helm-etags-select)

;; Locked mode
(global-set-key (kbd "C-c C-l") 'locked-buffer-mode)

;; Windows manipulation
(global-set-key (kbd "C-x |")           'split-window-right)
(global-set-key (kbd "C-x -")           'split-window-below)
(global-set-key (kbd "C-x C-<right>")   'windmove-right)
(global-set-key (kbd "C-x C-<left>")    'windmove-left)
(global-set-key (kbd "C-x C-<down>")    'windmove-down)
(global-set-key (kbd "C-x C-<up>")      'windmove-up)

(global-set-key (kbd "C-x <left>")      'shrink-window-horizontally)
(global-set-key (kbd "C-x <right>")     'enlarge-window-horizontally)
(global-set-key (kbd "C-x <up>")        'enlarge-window)
(global-set-key (kbd "C-x <down>")      'shrink-window)

;; (global-set-key (kbd "M-<right>") 'other-window)
;; (global-set-key (kbd "M-<left>") '(lambda (&optional n)
;;                                           (interactive "P") (other-window -1)))

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
;; (global-set-key (kbd "C-p") 'helm-projectile)
(global-set-key (kbd "s-d") 'projectile-find-dir)
;; (global-set-key (kbd "s-d") 'dired-jump)
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
;; (global-set-key (kbd "<f1>") 'keyboard-quit)
(global-set-key (kbd "<f2>") 'helm-all-mark-rings)
(global-set-key (kbd "s-y") 'helm-show-kill-ring)
(global-set-key (kbd "<f11>") 'menu-bar-mode)
(global-set-key (kbd "<f12>") 'indent-whole-buffer)

;; BOOKMARKS
(global-set-key (kbd "s-b") 'helm-bookmarks)

;; Ace Jump Mode
(define-key global-map (kbd "M-SPC") 'ace-jump-mode)
(define-key global-map (kbd "C-/") 'ace-jump-mode)

(define-key undo-tree-map (kbd "C-/") 'nil)
(define-key global-map (kbd "C-,") 'undo-tree-undo)

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
;; (global-set-key (kbd "C-b") 'helm-mini)
;; (global-set-key (kbd "M-b") 'projectile-switch-to-buffer)
;; (global-set-key (kbd "M-b") 'helm-projectile)

(global-set-key (kbd "C-x C-b") 'projectile-switch-to-buffer)

;; (global-set-key (kbd "C-x b") 'ibuffer)
;; (global-set-key (kbd "<M-up>") 'up-and-locate)
;; (global-set-key (kbd "<M-down>") 'down-and-locate)
(global-set-key [mouse-5] 'mouse-down-and-locate)
(global-set-key [mouse-4] 'mouse-up-and-locate)

(add-hook
 'after-init-hook
 (lambda ()
   (after 'auto-complete
     (ac-set-trigger-key nil))
   ))


(define-key  emacs-lisp-mode-map (kbd "C-M-x") nil)

;; (global-set-key (kbd "C-f") 'forward-char)
;; (global-set-key (kbd "C-b") 'backward-char)
;; (global-set-key (kbd "C-j") 'newline-and-indent)

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")

  (require 'mu4e)

  ;; default
  (setq mu4e-maildir "~/.mail")

(setq mu4e-headers-skip-duplicates t)
(setq mu4e-headers-include-related t)
(setq mu4e-use-fancy-chars nil)
(setq mu4e-view-show-images t)
(setq mu4e-attachment-dir "~/Downloads")

(setq mu4e-view-prefer-html t)

  ;; (setq mu4e-drafts-folder "/[Gmail].Drafts")
  ;; (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
  ;; (setq mu4e-trash-folder  "/[Gmail].Trash")


  ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
  (setq mu4e-sent-messages-behavior 'delete)

  ;; (See the documentation for `mu4e-sent-messages-behavior' if you have
  ;; additional non-Gmail addresses and want assign them different
  ;; behavior.)

  ;; setup some handy shortcuts
  ;; you can quickly switch to your Inbox -- press ``ji''
  ;; then, when you want archive some messages, move them to
  ;; the 'All Mail' folder by pressing ``ma''.

  ;; (setq mu4e-maildir-shortcuts
  ;;     '( ("/INBOX"               . ?i)
  ;;        ("/[Gmail].Sent Mail"   . ?s)
  ;;        ("/[Gmail].Trash"       . ?t)
  ;;        ("/[Gmail].All Mail"    . ?a)))

  ;; allow for updating mail using 'U' in the main view:
  (setq mu4e-get-mail-command "mbsync -a")

  ;; something about ourselves
  (setq
   user-mail-address "dromar566@gmail.com"
   user-full-name  "David Barrutia"
   mu4e-compose-signature
   (concat
    "David Barrutia"
    ""))

  ;; sending mail -- replace USERNAME with your gmail username
  ;; also, make sure the gnutls command line utils are installed
  ;; package 'gnutls-bin' in Debian/Ubuntu

  (require 'smtpmail)
  (setq message-send-mail-function 'smtpmail-send-it
     starttls-use-gnutls t
     smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
     smtpmail-auth-credentials
     '(("smtp.gmail.com" 587 "dromar56@gmail.com" nil))
     smtpmail-default-smtp-server "smtp.gmail.com"
     smtpmail-smtp-server "smtp.gmail.com"
     smtpmail-smtp-service 587)

  ;; alternatively, for emacs-24 you can use:
  ;;(setq message-send-mail-function 'smtpmail-send-it
  ;;     smtpmail-stream-type 'starttls
  ;;     smtpmail-default-smtp-server "smtp.gmail.com"
  ;;     smtpmail-smtp-server "smtp.gmail.com"
  ;;     smtpmail-smtp-service 587)

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t)

(defun mu4e-open-mail-in-browser (args)
  (interactive "P")
  (let ((mail-content (buffer-string)))
      (save-excursion
        (with-temp-file "/tmp/mu4e-tmp-file.html" 
          (progn 
            (insert mail-content)
            (eww-open-file "/tmp/mu4e-tmp-file.html"))))))

(global-set-key (kbd "C-x m") 'mu4e)
