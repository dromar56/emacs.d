(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ; ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(setq package-enable-at-startup nil)

;; ZOMG C'ETAIS TELLEMENT FUCKING EASY - RIEN NE MARCHE SANS CE TRUC
(package-initialize)

(defun set-frame-font-size (size)
  (interactive "nSize:")
  (set-face-attribute 'default (selected-frame) :height size)
  )

(add-to-list 'load-path (concat user-emacs-directory "elisp"))
(require 'macro) ;; elisp/macro.js is a file created by save-macro, where it saves macros (duh)

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

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun unpop-to-mark-command ()
  "Unpop off mark ring. Does nothing if mark ring is empty."
  (interactive)
  (when mark-ring
    (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
    (set-marker (mark-marker) (car (last mark-ring)) (current-buffer))
    (when (null (mark t)) (ding))
    (setq mark-ring (nbutlast mark-ring))
    (goto-char (marker-position (car (last mark-ring))))))

(defun narrow-or-widen-dwim (p)
  "If the buffer is narrowed, it widens. Otherwise, it narrows
   intelligently.  Intelligently means: region, org-src-block,
   org-subtree, or defun, whichever applies first.  Narrowing to
   org-src-block actually calls `org-edit-src-code'.

   With prefix P, don't widen, just narrow even if buffer is already
   narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen))
        ((and (boundp 'org-src-mode) org-src-mode (not p))
         (org-edit-src-exit))
        ((region-active-p)
         (narrow-to-region (region-beginning) (region-end)))
        ((derived-mode-p 'org-mode)
         (cond ((ignore-errors (org-edit-src-code))
                (delete-other-windows))
               ((org-at-block-p)
                (org-narrow-to-block))
               (t (org-narrow-to-subtree))))
        ((derived-mode-p 'prog-mode) (narrow-to-defun))
        (t (error "Please select a region to narrow to"))))

(defun db4go-toggle-productivity ()
  (interactive)
  (with-current-buffer (find-file-noselect "/sudo:root@localhost:/etc/hosts")
    (let (beg)
      (goto-char (point-min))
      (search-forward-regexp "^#PRODUCTIVITY")
      (setq beg (point))
      (search-forward-regexp "^#END_PRODUCTIVITY")
      (beginning-of-line)
      (comment-or-uncomment-region beg (point)))
    (save-buffer))
  (message "Productivity toggled"))

(defun db-read-with-eww ()
  (interactive)
  (let ((temp-file (make-temp-file "epub-to-eww" nil ".html")))
    (write-region nil nil temp-file)
    (eww-open-file temp-file)))

(if (fboundp 'with-eval-after-load)
    (defmacro after (feature &rest body)
      "After FEATUR. i. loaded, evaluate BODY."
      (declare (indent defun))
      `(with-eval-after-load ,feature ,@body))
  (defmacro after (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
    `(eval-after-load ,feature
       '(progn ,@body))))


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

(defun indent-rigidly-block ()
  (interactive "")

  (if (not (use-region-p))

      (let ((cur-indent (current-indentation))
            (start nil)
            (end nil))
        (beginning-of-line)

        (save-excursion
          (while (and (= (current-indentation) cur-indent)
                      (not (= (point-min) (point)))
                      (not (looking-at "[ \t]*$")))
            (setq start (point))
            (set-mark-command nil)
            (forward-line -1)))

        (while (and (= (current-indentation) cur-indent)
                    (not (= (point-max) (line-end-position)))
                    (not (looking-at "[ \t]*$")))
          (setq end (line-end-position))
          (forward-line 1))

        (goto-char end)
        (exchange-point-and-mark)
        (call-interactively 'indent-rigidly)
        )
    )
  (call-interactively 'indent-rigidly)
  )

(bind-key "C-x TAB" 'indent-rigidly-block)

(ido-mode t)
(ido-ubiquitous-mode t)
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
(ido-everywhere t)
(flx-ido-mode 1)

;; (bind-key "M-x" 'smex)
;; (bind-key "M-X" 'smex-major-mode-commands)
;;  (bind-key "C-c M-x" 'smex-update)

(require 'helm-config)
(use-package helm
  :ensure t
  :bind (("C-c x" . helm-M-x)
         ("C-z"   . helm-mini)
         ("C-t"   . helm-imenu)
         ("M-t"   . helm-etags-select)
         ("M-o"   . helm-occur)
         ("C-M-o" . helm-multi-occur)
         ("s-y"   . helm-show-kill-ring)
         ("s-b"   . helm-bookmarks)
         )

  :config
  (customize-set-variable 'helm-boring-buffer-regexp-list
                          (quote
                           ("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*Minibuf" "^\\*")))
  (customize-set-variable 'helm-buffer-max-length 30)
  (customize-set-variable 'helm-candidate-number-limit 100)
  (setq helm-M-x-fuzzy-match t)
  (setq helm-quick-update t)
  (setq helm-bookmark-show-location t)
  (setq helm-buffers-fuzzy-matching t)
  (customize-set-variable 'helm-truncate-lines t)
  )

(use-package helm-swoop
  :ensure t
  :pin melpa
  :bind ("s-o" . helm-swoop)
  )

(use-package wgrep-helm
  :ensure t)

(bind-key "C-M-t" 'projectile-regenerate-tags)

(use-package helm-ag
  :ensure t
  :config
  (setq helm-ag-thing-at-point 'symbol)
  (customize-set-variable 'helm-ag-base-command "ag")
  (customize-set-variable 'helm-ag-command-option
                          "--nocolor --nogroup --ignore-dir node_modules --ignore-dir elpa")

  (defun helm-ag-projectile ()
    (interactive)
    (if (projectile-project-p)
        (helm-ag (projectile-project-root))
      (helm-ag)))
  (bind-key "s-g" 'helm-ag-projectile)

  (defun helm-ag-do-projectile ()
    (interactive)
    (if (projectile-project-p)
        (helm-do-ag (projectile-project-root))
      (helm-do-ag)))
  (bind-key "s-S-g" 'helm-ag-do-projectile))

(use-package helm-projectile :ensure t
  :bind (("M-z" . helm-projectile)
         ("s-p" . helm-projectile-switch-project)
         ("s-d" . helm-projectile-find-dir))
  :config
  (customize-set-variable 'helm-projectile-sources-list '(helm-source-projectile-buffers-list
                                                          helm-source-projectile-files-list
                                                          helm-source-projectile-recentf-list)))

(use-package helm-dash
  :ensure t
  :pin melpa
  :config
  (setq helm-dash-browser-func 'browse-url))


(use-package helm-spaces
  :ensure t
  :pin melpa
  :commands (helm-spaces)
  :bind ("M-s" . helm-spaces)
  )

(use-package helm-descbinds
  :ensure t
  :pin melpa
  :bind ("C-h b" . helm-descbinds)
  )

(use-package helm-c-yasnippet
  :ensure t
  :pin melpa
  :bind (("s-s" . helm-yas-complete-or-create)
         ("s-S" . helm-yas-all-complete-or-create))
  :config

  (defun helm-yas-get-file-by-template (template alist) ;str template
    "Return key"
    (assoc-default template (assoc-default 'template-file-alist alist)))

  (defun helm-yas-get-mode-by-template (template alist) ;str template
    "Return key"
    (let* ((yas-dir "snippets/")
           (yas-length (length yas-dir))
           (path (file-name-directory (assoc-default template (assoc-default 'template-file-alist alist)))))
      (substring path (+ yas-length (s-index-of yas-dir path)) (- (length path) 1))))

  (setq helm-source-yasnippet-create-new-snippet
        '((name . "Create")
          (dummy)
          (action . (("Create" . (lambda (candidate) (helm-yas-create-new-snippet helm-yas-selected-text candidate)))))))

  (defun helm-yas-complete-or-create ()
    "List of yasnippet snippets using `helm' interface."
    (interactive)
    (helm :sources '(helm-source-yasnippet
                     helm-source-yasnippet-create-new-snippet)))

  (defun helm-yas-all-complete-or-create ()
    "List of yasnippet snippets using `helm' interface."
    (interactive)
    (flet ((yas--get-snippet-tables ()
                                    (let ((tables ()))
                                      (maphash
                                       (lambda (kk vv) (push vv tables))
                                       yas--tables)
                                      tables)))
      (helm :sources '(helm-source-yasnippet helm-source-yasnippet-create-new-snippet))))


  (defun helm-yas-get-transformed-list (alist initial-input)
    "Return list of dotlist, (DISPLAY . REAL) DISPLAY is name of snippet, REAL is template of snippet"

    (let ((initial-input "")
          (transformed-list (assoc-default 'transformed alist 'eq)))

      (cond
       ;; display key on candidate ex: [for] for (...) { ... }
       (helm-yas-display-key-on-candidate
        (setq transformed-list (cl-remove-if-not (lambda (lst)
                                                   (string-match (concat "^" (regexp-quote initial-input)) (car lst)))
                                                 transformed-list))
        (setq transformed-list (cl-loop for dotlst in transformed-list
                                        for name = (car dotlst)
                                        for template = (cdr dotlst)
                                        for key = (helm-yas-get-key-by-template template alist)
                                        for mode = (helm-yas-get-mode-by-template template alist)
                                        for name-inc-key = (format
                                                            "%-20s %-40s %s"
                                                            (propertize key 'face 'helm-yas-key)
                                                            name
                                                            (propertize mode 'face 'helm-buffer-size))
                                        collect `(,name-inc-key . ,template))))

       ;; default ex: for (...) { ... }
       (t
        (setq transformed-list (cl-remove-if-not (lambda (lst)
                                                   (string-match (concat "^" (regexp-quote initial-input)) (car lst)))
                                                 transformed-list))))
      (when helm-yas-not-display-dups
        (setq transformed-list (delete-dups transformed-list)))
      ;; sort
      (setq transformed-list (cl-sort transformed-list 'string< :key 'car))
      transformed-list))


  (defun helm-yas-create-new-snippet (selected-text &optional snippet-file)
    "Create snippet from SELECTED-TEXT into SNIPPET-FILE.
If SNIPPET-FILE is nil, asks file name.
If SNIPPET-FILE does not contain directory, it is placed in default snippet directory."
    (let* ((major-mode-dir (regexp-quote (symbol-name major-mode)))
           (yas-dir (expand-file-name (or (car-safe yas-snippet-dirs) yas-snippet-dirs)))
           (snippet-dir
            (or (helm-yas-find-recursively major-mode-dir yas-dir 'snippet-file)
                (let ((target-dir (format "%s/%s/" yas-dir major-mode-dir)))
                  (if (yes-or-no-p (format "%s doesn't exist. Would you like to create this directory?" target-dir))
                      (progn
                        (make-directory target-dir)
                        target-dir)
                    (deactivate-mark)
                    (error "Snippet creation failed"))))))
      (let ((snippet-name snippet-file))
        (setq snippet-file (read-file-name "create snippet : " snippet-dir nil 'confirm (s-dashed-words snippet-file)))
        (when (file-exists-p snippet-file)
          (error "can't create file [%s] already exists" (file-name-nondirectory snippet-file)))
        (helm-yas-create-new-snippet-file selected-text snippet-file snippet-name))))

  (defun helm-yas-create-new-snippet-file (selected-text snippet-file snippet-name)
    "Create snippet file with inserted SELECTED-TEXT into SNIPPET-FILE."
    (with-current-buffer (find-file snippet-file)
      (snippet-mode)
      (funcall helm-yas-create-new-snippet-insert-function selected-text snippet-name)))

  (defun helm-yas-create-new-snippet-insert (selected-text snippet-file)
    "Insert SELECTED-TEXT into SNIPPET-FILE."
    (let* ((name (file-name-sans-extension
                  (file-name-nondirectory
                   (directory-file-name snippet-file))))
           (string-format "# -*- mode: snippet -*-\n#name : %s\n#key : %s\n#contributor : %s\n# --\n"))
      (insert (format string-format name (s-dashed-words name) user-full-name) selected-text)))

  ;; End of helm-c-yasnippet
  )

(use-package swiper
  :ensure t
  :pin melpa
  :bind ("M-s" . swiper)
  :config
  ;; (bind-key "C-S-s" 'isearch-forward)
  (bind-key "C-w" 'ivy-yank-word swiper-map)
  (bind-key "C-r" 'ivy-previous-line-or-history swiper-map)
  )

(use-package auto-yasnippet
  :ensure t
  :pin melpa
  :commands (aya-create
             aya-expand
             aya-open-line
             aya-persist-snippet)
  :config
  )

(use-package counsel
  :ensure t
  :pin melpa
  :bind ("M-x" . counsel-M-x)
  )

(use-package ivy
  :config
  (ivy-mode t)
  (add-to-list 'ivy-initial-inputs-alist '(counsel-M-x . ""))
  ;; (setq ivy-re-builders-alist
  ;;       '((t . ivy--regex-fuzzy)))  
  )

(use-package hydra :ensure t)

(defhydra hydra-yasnippet (:color blue :hint nil)
  "
                ^YASnippets^
  --------------------------------------------
    Modes:    Load/Visit:    Actions:

   _g_lobal  _d_irectory    _i_nsert
   _m_inor   _f_ile         _t_ryout
   _e_xtra   _l_ist         _n_ew
           _a_ll
  "
  ("d" yas-load-directory)
  ("e" yas-activate-extra-mode)
  ("i" yas-insert-snippet)
  ("f" yas-visit-snippet-file :color blue)
  ("n" yas-new-snippet)
  ("t" yas-tryout-snippet)
  ("l" yas-describe-tables)
  ("g" yas/global-mode)
  ("m" yas/minor-mode)
  ("a" yas-reload-all))

(defhydra hydra-winner (global-map "C-c")
  "Winner"
  ("<left>" (progn
              (winner-undo)
              (setq this-command 'winner-undo))
   "back")
  ("<right>" winner-redo "forward"))

(defhydra hydra-mark (global-map "C-c")
  "Mark"
  ("," (lambda () (interactive)
         (setq current-prefix-arg '(4)) ; C-u
         (call-interactively 'set-mark-command))
   "Pop mark")
  ("." unpop-to-mark-command "Unpop mark"))

(use-package avy
  :ensure t
  :bind ("M-c" . avy-goto-char-2)
  :config
  (setq avy-keys (number-sequence ?a ?z)))

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"))
  (yas-global-mode 1)

  (bind-keys :map yas-minor-mode-map
             ;; ("<tab>" . nil)
             ;; ("TAB" . nil)
             ("C-<tab>" . yas-expand)
             ("C-c TAB" . yas-insert-snippet ))
  )

(use-package anzu
  :ensure t
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :config
  (setq anzu-cons-mode-line-p nil)
  (global-anzu-mode 1))

(use-package expand-region :ensure t)

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-last-seen-setup-instructions "1.4.0")

  (bind-key "C-M-1" 'magit-show-level-1-all  magit-diff-mode-map)
  (bind-key "C-M-2" 'magit-show-level-2-all  magit-diff-mode-map)
  (bind-key "C-M-3" 'magit-show-level-3-all  magit-diff-mode-map)
  (bind-key "C-M-4" 'magit-show-level-4-all  magit-diff-mode-map))

(use-package multiple-cursors :ensure t)

(use-package iy-go-to-char :ensure t
  :config (add-to-list 'mc/cursor-specific-vars 'iy-go-to-char-start-pos))

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode t)
  (customize-set-variable 'projectile-globally-ignored-directories
                          '(".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "node_modules" "elpa"))
  (customize-set-variable 'projectile-remember-window-configs nil)
  (customize-set-variable 'projectile-completion-system 'ivy)
  (customize-set-variable 'projectile-switch-project-action (quote projectile-dired))
  (customize-set-variable 'projectile-tags-command
                          "find . -type f -not -iwholename '*TAGS' -not -size +16k | ctags -f %s %s -e -L -"))

(use-package company
  :ensure t
  :pin melpa
  :config
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 1)
  (setq company-show-numbers 1)
  (setq company-tooltip-limit 10)

  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case nil)

  (setq company-global-modes
        '(not eshell-mode comint-mode org-mode))

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

  (defun company-auto-completion-toggle ()
    (interactive)
    (if (eq company-idle-delay 0)
        (setq company-idle-delay 0.3)
      (setq company-idle-delay 0))
    (message (format "company-idle-delay : %s" company-idle-delay)))

  (bind-key "C-M-c" 'company-auto-completion-toggle)

  (bind-key "C-o" 'company-manual-begin)
  (bind-key "M-o" 'company-tern)
  (bind-key "M-?" 'company-dabbrev)

  (defadvice company-complete-common (around advice-for-company-complete-common activate)
    (when (null (yas-expand))
      ad-do-it))

  (add-hook 'after-init-hook 'global-company-mode))

(use-package flycheck :ensure t)
(add-hook 'after-init-hook #'global-flycheck-mode)

(customize-set-variable 'flycheck-disabled-checkers (quote (emacs-lisp-checkdoc)))
(customize-set-variable 'flycheck-idle-change-delay 0.5)

;; For a cleaner modeline
(use-package diminish :ensure t)
(diminish 'visual-line-mode)
(after 'autopair (diminish 'autopair-mode))
(after 'js2 (diminish 'Javascript-IDE))
(after 'js2r (diminish 'js2r-mode))
(after 'skewer (diminish 'skewer-mode))
(after 'undo-tree (diminish 'undo-tree-mode))
(after 'auto-complete (diminish 'auto-complete-mode))
;(after 'projectile (diminish 'projectile-mode))
(after 'yasnippet (diminish 'yas-minor-mode))
(after 'guide-key (diminish 'guide-key-mode))
(after 'eldoc (diminish 'eldoc-mode))
(after 'smartparens (diminish 'smartparens-mode))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))
;; (after 'helm (diminish 'helm-mode))
(after 'anzu (diminish 'anzu-mode))
(after 'skewer (diminish 'skewer-mode))
(after 'tern (diminish 'tern-mode))
;; (after 'company (diminish 'company-mode))

(require 'tramp)
   (setq tramp-backup-directory-alist `(("." . "~/.saves_tramp")))
  (setq tramp-default-method "sshx")

(setq password-cache-expiry 'nil)

   ;; (add-to-list 'backup-directory-alist
   ;;              (cons tramp-file-name-regexp nil))

(use-package neotree
  :bind ("M-`" . neotree-toggle)
  :config
  (setq neo-smart-open nil)
  (setq neo-persist-show t) ;; setting it to nil probably solves a bug with helm C-h m (helm-help)

  ; (setq projectile-switch-project-action 'neotree-projectile-action)
)

(defvar neotree-projectile-root nil)

(defun neotree-projectile (args)
  (interactive "P")
  )

(when (executable-find "ag")
      (use-package ag :ensure t)
      (setq ag-highlight-search t)
      (use-package wgrep-ag) :ensure t)
(customize-set-variable 'ag-arguments
   (quote
    ("--smart-case" "--nogroup" "--column" "--ignore-dir" "node_modules" "--ignore-dir" "elpa")))
(customize-set-variable 'ag-highlight-search t)

(use-package shackle
  :ensure t
  :pin melpa
  :config
  (setq shackle-rules '(("\\`\\*[hH]elm.*?\\*\\'" :regexp t :align t :ratio 0.4)))
  (shackle-mode t)
  )

(use-package smooth-scrolling
  :ensure t
  :init (setq smooth-scroll-margin 5
              scroll-conservatively 101
              scroll-preserve-screen-position t
              auto-window-vscroll nil)
  :config
  (setq scroll-margin 5)
  )

(add-hook 'prog-mode-hook #'hs-minor-mode)

(use-package scala-mode2
  :ensure t
  :interpreter ("scala" . scala-mode)
  )

(use-package ensime
  :ensure t
  :commands ensime ensime-mode
  )

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

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

(use-package org
  :config
  (bind-key "<f2>" 'org-edit-special org-mode-map)
  (bind-key "<f2>" 'org-edit-src-exit org-src-mode-map)
  (bind-key "\C-cl" 'org-store-link)
  (bind-key "\C-ca" 'org-agenda)
)

(setq org-log-done t)

(setq org-tag-alist nil)

;; (bind-key "<C-S-right>" 'helm-occur)

(eval-after-load "org"
  '(progn
     (define-key org-mode-map (kbd "<C-S-up>") 'outline-up-heading)
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

(defun org-insert-elisp-block (name beg end)
  (interactive "sName:\nr")
  (org-insert-heading-after-current)
  (save-excursion
    (insert name "\n")
    (insert "#+begin_src emacs-lisp :tangle yes" "\n")
    (if (region-active-p)
        (progn
          (kill-region beg end)
          (yank)))
    (insert "#+end_src")))

(define-key org-mode-map (kbd "M-<return>") 'org-insert-elisp-block)

(defun org-babel-execute:mongo (body params)
  "org-babel mongo hook."
  (let* ((db (or (cdr (assoc :db params))
                                 "core.early-birds:27017/earlybirds"))
                 (cmd (mapconcat 'identity (list "mongo" "--quiet" db) " ")))
        (org-babel-eval cmd body)))


(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("mongo" . js2)))

(setq org-agenda-files '("~/org"))
(load-library "find-lisp")
(setq org-agenda-files (find-lisp-find-files org-directory "\.org$"))

      ;; (setq org-agenda-files (list org-main-file))

(setq org-default-notes-file org-main-file)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "s-t") 'org-capture)
;;(define-key global-map (kbd "<f1>") 'org-capture)
(define-key global-map (kbd "<S-f1>") (lambda () (interactive)
                                        (let ((current-prefix-arg '(4)))
                                          (call-interactively 'org-capture))))

(defun llc-get-project-org-name ()
  "Return the name of the projectile project"
  (replace-regexp-in-string "[^[:alnum:]]" "-"
                            (car (last (split-string (projectile-project-root) "/" t)))))

(defun llc-get-project-org-file ()
  "Return the path to the project org file"
  (concat org-directory "/projects/"
          (llc-get-project-org-name)
          ".org"))

(defun llc-find-project-org-file-task ()
  "Find the org file associated with the current projectile project, creating it if needed, and place the point at the end of 'Tasks' subtree."
  (let ((project-file (llc-get-project-org-file))
        (project-headline-regexp "^\\* Tasks")
        (project-name (llc-get-project-org-name)))
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

;; (setq org-capture-templates
;;       '(("p" "Project" entry (function llc-find-project-org-file-task)
;;          "* TODO %?\n  %a\n  %i")
;;         ("t" "Todo" entry (file+headline "~/org/notes.org" "Todo")
;;          "* TODO %?\n  %a\n  %i")
;;         ("n" "Note" entry (file+headline "~/org/notes.org" "Notes")
;;          "* %?\n  %a\n  %i")
;;         ("j" "Journal" entry (file+datetree "~/org/journal.org")
;;          "* %?\nEntered on %U\n  %a\n  %i")
;;         ("J" "Journal - more options")
;;         ("Jc" "Journal Clipboard" entry (file+datetree "~/org/journal.org")
;;          "* %?\nEntered on %U\n  %x\n  %a")))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Todo")
         "* TODO %?\n  %a\n  %i")
        ("w" "Todo - Work" entry (file+headline "~/org/todo.org" "Work")
         "* TODO %?\n  %a\n  %i")
        ("c" "Todo - Clipboard" entry (file+headline "~/org/todo.org" "Todo")
         "* TODO %?\n  %c\n  %i")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %a\n  %i")
        ("J" "Journal - more options")
        ("Jc" "Journal Clipboard" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %x\n  %a")))

(setq org-capture-templates-contexts
      '(("p" ((lambda () "DOCSTRING" (interactive) (projectile-project-root))))))

;; Close frame after org-capture only if a certain frame-parameter is set
(defun llc-close-frame-after-org-capture ()
  (if (frame-parameter nil 'llc-close-frame-after-org-capture)
      (delete-frame)))
(add-hook 'org-capture-after-finalize-hook 'llc-close-frame-after-org-capture)

;; Sometimes hideshow doesn't work in js2-mode, so I go back to js-mode
(add-hook 'js-mode-hook #'hs-minor-mode)

(use-package js2-mode
  :mode "\\.js\\'"
  :config
  (customize-set-variable 'js2-bounce-indent-p nil)
  (customize-set-variable 'js2-global-externs [global require])
  (customize-set-variable 'js2-include-node-externs t)
  (customize-set-variable 'js2-basic-offset 2)
  (customize-set-variable 'js2-mode-show-parse-errors nil)
  (customize-set-variable 'js2-mode-show-strict-warnings nil)

  (add-hook 'js2-mode-hook (lambda () (setq indent-tabs-mode 'nil)))
  (add-hook 'js2-mode-hook #'hs-minor-mode)
  (add-hook 'js2-mode-hook #'eldoc-mode)
  (add-hook 'js2-mode-hook #'subword-mode)

  (use-package js2-refactor
    :config
    ;; eg. extract function with `C-c C-m ef`.
    (js2r-add-keybindings-with-prefix "C-c C-m")
    (add-hook 'js2-mode-hook #'js2-refactor-mode)
    )

  (use-package tern
    :ensure t
    :if (executable-find "tern")
    :config
    (add-hook 'js2-mode-hook 'tern-mode)
    (use-package company-tern :ensure t)
    )

  (use-package js-doc
    :ensure t
    )

  (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
  (define-key js2-mode-map "@" 'js-doc-insert-tag)
  )

(use-package tide
  :ensure t
  :config

  ;; sample config
  (add-hook 'typescript-mode-hook
            (lambda ()
              (tide-setup)
              (flycheck-mode +1)
              ;;(setq flycheck-check-syntax-automatically '(save mode-enabled))
              (eldoc-mode +1)
              ;; company is an optional dependency. You have to
              ;; install it separately via package-install
              (company-mode-on)))

  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)

  ;; Tide can be used along with web-mode to edit tsx files
  (require 'web-mode)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (tide-setup)
                (flycheck-mode +1)
                ;;(setq flycheck-check-syntax-automatically '(save mode-enabled))
                (eldoc-mode +1)
                (company-mode-on))))
  )

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
(elpy-use-ipython "ipython3")
;; (elpy-clean-modeline)

(defun elpy-use-python3 (args)
  (elpy-use-ipython "ipython3")
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

(define-key elpy-mode-map (kbd "<C-down>") 'nil)
(define-key elpy-mode-map (kbd "<C-up>") 'nil)
(define-key elpy-mode-map (kbd "<M-up>") 'nil)
(define-key elpy-mode-map (kbd "<M-down>") 'nil)

;; Fix yasnippet indentation in python-mode
(add-hook 'python-mode-hook
   '(lambda () (set (make-local-variable 'yas-indent-line) 'fixed)
      (company-mode -1)))

(use-package web-mode
  :mode (("\\.phtml\\'" . web-mode)
         ("\\.tpl\\.php\\'" . web-mode)
         ("\\.[gj]sp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
         ("\\.html?\\'" . web-mode)
         ("\\.dust?\\'" . web-mode))

  :init
  
  :config
  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 2)
    )
  (add-hook 'web-mode-hook  'my-web-mode-hook)
  )

(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper

;; Override hs-mouse-toggle-hiding so we don't need to click on the open bracket

(use-package hideshow
  :config
  (defun hs-mouse-toggle-hiding (e)
    "Toggle hiding/showing of a block.
This command should be bound to a mouse key.
Argument E is a mouse event used by `mouse-set-point'.
See `hs-hide-block' and `hs-show-block'."
    (interactive "@e")
    (hs-life-goes-on
     (mouse-set-point e)
     ;; Move backward one char so we don't need to click on the open bracket
     (save-excursion
       (unless (hs-looking-at-block-start-p)
         (backward-char 1))
       (hs-toggle-hiding))))



  (bind-key "C--" 'hs-hide-block hs-minor-mode-map)
  (bind-key "C-=" 'hs-show-block hs-minor-mode-map)
  (bind-key "M--" 'hs-hide-all hs-minor-mode-map)
  (bind-key "M-=" 'hs-show-all hs-minor-mode-map)
  (bind-key "s-h" 'hs-toggle-hiding hs-minor-mode-map)
  (bind-key "<S-down-mouse-1>" nil hs-minor-mode-map)
  (bind-key "<S-mouse-1>" 'hs-mouse-toggle-hiding hs-minor-mode-map)
  (bind-key "<down-mouse-1>" nil hs-minor-mode-map)

  (defun hs-hide-global-level (level)
    (interactive)
    (save-excursion
      (goto-char (point-max))
      (hs-hide-level level)))

  (bind-key "M-s-1" (lambda () (interactive) (hs-hide-global-level 1)))
  (bind-key "M-s-2" (lambda () (interactive) (hs-hide-global-level 2)))
  (bind-key "M-s-3" (lambda () (interactive) (hs-hide-global-level 3)))
  (bind-key "M-s-4" (lambda () (interactive) (hs-hide-global-level 4)))
  (bind-key "M-s-5" (lambda () (interactive) (hs-hide-global-level 5)))
  (bind-key "M-s-6" (lambda () (interactive) (hs-hide-global-level 6)))
  )

(set-default 'truncate-lines t)

(setq scroll-margin 5)

;; (bind-key "s-h" 'mark-paragraph)

(setq search-whitespace-regexp ".*?")

(setq eldoc-idle-delay 0)

(setq dired-dwim-target t)

(customize-set-variable 'winner-dont-bind-my-keys t)
(winner-mode 1)

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

                                        ; Show full path in title
(setq-default frame-title-format "%f")
(setq ring-bell-function 'ignore)

(setq indent-tabs-mode 'nil)

(setq save-interprogram-paste-before-kill t)

(setq bookmark-saved-flag 1)

(setq suggest-key-binding 5)

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
;; (bind-key "\C-x\ \C-r" 'recentf-open-files)

(require 'uniquify)
(customize-set-variable 'uniquify-buffer-name-style 'post-forward-angle-brackets)
(customize-set-variable 'uniquify-strip-common-suffix t)

;; (setq uniquify-buffer-name-style 'reverse)

;;todo

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

(setq ido-default-buffer-method 'selected-window)

;; eshell prompt color
    (setq eshell-prompt-function (lambda nil
                                   (concat
                                    (propertize (eshell/pwd) 'face `(:foreground "cyan"))
                                    (propertize " $" 'face `(:foreground "cyan"))
                                    (propertize " " 'face `(:foreground "white"))
                                    )))
    (setq eshell-highlight-prompt nil)

    ;; Create a new eshell with prompt
    (defun db-create-eshell ()
      "creates a shell with a given name"
      (interactive);; "Prompt\n eshell name:")
      (let ((eshell-name (read-string "eshell name: " nil)))
        (eshell (concat "Eshell/" eshell-name ))))

    (defun db-create-shell ()
      "creates a shell with a given name"
      (interactive);; "Prompt\n shell name:")
      (let ((shell-name (read-string "shell name: " nil)))
        (shell (concat "Shell/" shell-name))))

(defun db-execute-last-eshell-command ()
  (interactive)
  (let ((eshell-buffer "*eshell*"))
    (if (get-buffer eshell-buffer)
        (with-current-buffer eshell-buffer
          (eshell-previous-input 1)
          (eshell-send-input))
      (message (concat "Eshell buffer " eshell-buffer " not found")))))
(bind-key "C-c e" 'db-execute-last-eshell-command)

(bind-key "<home>" 'beginning-of-buffer)
(bind-key "<end>" 'end-of-buffer)

(bind-key "<f7>" 'kmacro-start-macro-or-insert-counter)
(bind-key "<f8>" 'kmacro-end-or-call-macro)
(bind-key "S-<f8>" 'apply-macro-to-region-lines)

(bind-key "C-h a" 'apropos)

(bind-key "M-n"     'forward-paragraph)
(bind-key "M-p"     'backward-paragraph)

(bind-key "C-c n"   'winner-redo)
(bind-key "C-c p"   'winner-undo)

(bind-key "C-x C-1" 'delete-other-windows)
(bind-key "C-x C-2" 'split-window-below)
(bind-key "C-x C-3" 'split-window-right)
(bind-key "C-x C-0" 'delete-window)

(bind-key "C-;" 'repeat)

(bind-key "s-n" 'narrow-or-widen-dwim)

;; Font size
(bind-key "s-0" '(lambda ()  (interactive) (text-scale-set 0)))
(bind-key "s-+" 'text-scale-increase)
(bind-key "s-=" 'text-scale-increase)
(bind-key "s--" 'text-scale-decrease)
(bind-key "s-<kb-0>" '(lambda ()  (interactive) (text-scale-set 0)))
(bind-key "s-<kp-add>" 'text-scale-increase)
(bind-key "s-<kp-subtract>" 'text-scale-decrease)

;; A la carte Menu
(bind-key "C-x c" 'lacarte-execute-menu-command)

;; helm-imenuu
;; (bind-key "C-t" 'transpose-chars)
;; (bind-key "M-t" 'transpose-words)
;; (bind-key "C-t" 'idomenu)
;; (bind-key "M-t" 'imenu-anywhere)

;; Locked mode
(bind-key "C-c C-l" 'locked-buffer-mode)

;; Windows manipulation
(bind-key "C-x |"           'split-window-right)
(bind-key "C-x -"           'split-window-below)
(bind-key "C-x C-<right>"   'windmove-right)
(bind-key "C-x C-<left>"    'windmove-left)
(bind-key "C-x C-<down>"    'windmove-down)
(bind-key "C-x C-<up>"      'windmove-up)

; (bind-key "C-x C-l"   'windmove-right)
; (bind-key "C-x C-j"    'windmove-left)
; (bind-key "C-x C-<down>"    'windmove-down)
; (bind-key "C-x C-<up>"      'windmove-up)

(bind-key "C-x <left>"      'shrink-window-horizontally)
(bind-key "C-x <right>"     'enlarge-window-horizontally)
(bind-key "C-x <up>"        'enlarge-window)
(bind-key "C-x <down>"      'shrink-window)

;; (bind-key "M-<right>" 'other-window)
;; (bind-key "M-<left>" '(lambda (&optional n)
;;                                           (interactive "P") (other-window -1)))

(bind-key "C-<prior>" 'beginning-of-buffer)
(bind-key "C-<next>" 'end-of-buffer)
(bind-key "<prior>" 'scroll-down-command)
(bind-key "<next>" 'scroll-up-command)
(bind-key "M-<down>" (lambda () (interactive) (scroll-down -4)))
(bind-key "M-<up>" (lambda () (interactive) (scroll-down 4)))


;; Undo Tree mode
;; (bind-key "C-+" 'undo-tree-redo)

;; iy-go-to-char
(bind-key* "C-M-<right>" 'iy-go-to-char)
(bind-key* "C-M-<left>" 'iy-go-to-char-backward)

;; multiple-cursors bindings
(bind-key "s-M" 'mc/edit-lines)
(bind-key "s-." 'mc/mark-next-like-this)
(bind-key "s-," 'mc/mark-previous-like-this)
(bind-key "s->" 'mc/unmark-next-like-this)
(bind-key "s-<" 'mc/unmark-previous-like-this)
(bind-key "s-m" 'mc/mark-all-like-this)

(bind-key "<C-down-mouse-1>" 'mc/add-cursor-on-click)


;; Expand region by semantics units
(bind-key "s-\/" 'er/expand-region)
(bind-key "s-?" 'er/contract-region)

;; Register Windows
(bind-key "<f9>" '(lambda () (interactive) (jump-to-register 9)
                                (message "Windows disposition loaded")))
(bind-key "<f10>" '(lambda () (interactive) (window-configuration-to-register 9)
                                 (message "Windows disposition saved")))

;; Projectile
(bind-key "C-M-d" 'projectile-find-dir)


;; Resize Windows
(bind-key "C-M-<left>" 'shrink-window-horizontally)
(bind-key "C-M-<right>" 'enlarge-window-horizontally)
(bind-key "C-M-<down>" 'shrink-window)
(bind-key "C-M-<up>" 'enlarge-window)

(bind-key "<f11>" 'menu-bar-mode)
(bind-key "<f12>" 'indent-whole-buffer)


;; Ace Jump Mode
;; (define-key global-map (kbd "M-SPC") 'ace-jump-mode)
;; (define-key global-map (kbd "C-/") 'ace-jump-mode)

;;Project Explorer
;; (bind-key "<f1>" 'project-explorer-open)


;;Query Replace Regex
(bind-key "C-x C-r" 'query-replace-regexp)
(bind-key "s-O" 'my-projectile-multi-occur)

;; Macro bindings
;; (bind-key "<f2>" 'apply-macro-to-region-lines)

;; Goto
(bind-key [(meta g)] 'goto-line)

(bind-key "C-x C-b" 'projectile-switch-to-buffer)

;; (bind-key "C-x b" 'ibuffer)
;; (bind-key "<M-up>" 'up-and-locate)
;; (bind-key "<M-down>" 'down-and-locate)
(bind-key [mouse-5] 'mouse-down-and-locate)
(bind-key [mouse-4] 'mouse-up-and-locate)

;; Show indentation
;; Nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)


(menu-bar-mode t)
(tool-bar-mode 0)

(which-function-mode t)
(blink-cursor-mode -1)

;; (global-linum-mode t)
(setq linum-format " %2d ")

(load-theme 'material)

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

;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'super)
  (setq mac-right-option-modifier 'meta)
  (setq mac-command-modifier 'meta)
  (setq mac-right-command-modifier 'super))

(add-hook
 'after-init-hook
 (lambda ()
   (after 'auto-complete
     (ac-set-trigger-key nil))
   ))

(define-key  emacs-lisp-mode-map (kbd "C-M-x") nil)

(defun eb-magit ()
  (interactive "")

  ;; (let ((folders (list "cdn" "console" "api" "core")))
  ;;   (cl-dolist (name folders)
  ;;     (magit-status-internal (concat "~/projects/vagrant.early-birds/projects/" name ".early-birds"))))

  (magit-status-internal "~/projects/vagrant.early-birds/projects/cdn.early-birds")
  (magit-status-internal "~/projects/vagrant.early-birds/projects/core.early-birds")
  (magit-status-internal "~/projects/vagrant.early-birds/projects/api.early-birds")
  (magit-status-internal "~/projects/vagrant.early-birds/projects/console.early-birds")

  (with-current-buffer "*magit: cdn.early-birds" (magit-fetch-all-no-prune))
  (with-current-buffer "*magit: core.early-birds" (magit-fetch-all-no-prune))
  (with-current-buffer "*magit: api.early-birds" (magit-fetch-all-no-prune))
  (with-current-buffer "*magit: console.early-birds" (magit-fetch-all-no-prune))

  (delete-other-windows-internal)
  (switch-to-buffer "*magit: api.early-birds")
  (split-window-right)
  (split-window-below)
  (windmove-down)
  (switch-to-buffer "*magit: console.early-birds")
  (windmove-right)
  (switch-to-buffer "*magit: core.early-birds")
  (split-window-below)
  (windmove-down)
  (switch-to-buffer "*magit: cdn.early-birds")
)

(bind-key "C-x G" 'eb-magit)
