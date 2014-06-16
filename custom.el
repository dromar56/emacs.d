(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-arguments (quote ("--smart-case" "--nogroup" "--column" "--ignore-dir" "node_modules" "--ignore-dir" "elpa")))
 '(ag-highlight-search t t)
 '(ansi-color-names-vector ["#5f5f5f" "#ff4b4b" "#a1db00" "#fce94f" "#5fafd7" "#d18aff" "#afd7ff" "#ffffff"])
 '(ansi-term-color-vector [unspecified "#383830" "#f92672" "#a6e22e" "#f4bf75" "#66d9ef" "#ae81ff" "#66d9ef" "#f5f4f1"])
 '(coffee-args-compile (quote ("-c" "--bare")))
 '(coffee-tab-width 4)
 '(custom-enabled-themes (quote (moe-dark)))
 '(custom-safe-themes (quote ("b0ccdbe8d324c6d14240ef8dad9e547c7fc7cd11450eac9e6807dbce0430f3c0" "f0d90d902dbee341e375b3b5b58e3cb4c26a657894feb5eb7ff7535b1a8ce9d4" "f95e7e75148cd0c51b777608140bc3e081c1170d0124efdbc7c1225e35afd4d9" "ea97033435e26d4742c0d88de2238ac8d1cb9e6df5eb9a73324382fcefa7118a" "60f04e478dedc16397353fb9f33f0d895ea3dab4f581307fbf0aa2f07e658a40" "f41fd682a3cd1e16796068a2ca96e82cfd274e58b978156da0acce4d56f2b0d5" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "62566d5660dc33b964e4276cd2ae226805f30fdeea2427c16ab69d40ad3c7003" "e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "405fda54905200f202dd2e6ccbf94c1b7cc1312671894bc8eca7e6ec9e8a41a2" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "41b6698b5f9ab241ad6c30aea8c9f53d539e23ad4e3963abff4b57c0f8bf6730" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" "fd28c910c2883b204f20242340f4f7b5f76db5b9c790ae31d9f3d471f9aff9bc" default)))
 '(elpy-default-minor-modes (quote (eldoc-mode flymake-mode yas-minor-mode auto-complete-mode)))
 '(flycheck-disabled-checkers (quote (emacs-lisp-checkdoc)))
 '(global-linum-mode t)
 '(helm-buffer-max-length 30)
 '(helm-mode t)
 '(helm-projectile-sources-list (quote (helm-source-projectile-buffers-list helm-source-projectile-files-list helm-source-projectile-recentf-list)))
 '(helm-truncate-lines t)
 '(inhibit-startup-screen t)
 '(js2-bounce-indent-p nil)
 '(js2-global-externs [global require])
 '(js2-include-node-externs t)
 '(linum-format " %2d ")
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/sync/org/david.org")))
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(package-enable-at-startup nil)
 '(pe/directory-tree-function (quote pe/get-directory-tree-async))
 '(projectile-globally-ignored-directories (quote (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "node_modules" "elpa")))
 '(projectile-remember-window-configs nil)
 '(projectile-switch-project-action (quote projectile-dired))
 '(projectile-tags-command "ctags -Re %s %s")
 '(recentf-auto-cleanup (quote never))
 '(recentf-max-saved-items 200000)
 '(scss-compile-at-save nil)
 '(show-paren-mode t)
 '(smex-history-length 1000)
 '(sp-hybrid-kill-excessive-whitespace t)
 '(tool-bar-mode nil)
 '(tree-widget-image-enable nil)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-strip-common-suffix t)
 '(vc-follow-symlinks nil)
 '(web-mode-tag-auto-close-style 0)
 '(wgrep-enable-key "")
 '(yas-choose-tables-first nil)
 '(yas-new-snippet-default "# -*- mode: snippet -*-
# name: $1
# key: ${2:${1:$(yas--key-from-desc yas-text)}}${3:
# binding: ${4:direct-keybinding}}${5:
# expand-env: ((${6:some-var} ${7:some-value}))}${8:
# type: snippet}
# --
$0")
 '(yas-prompt-functions (quote (yas-ido-prompt yas-x-prompt yas-dropdown-prompt yas-completing-prompt yas-ido-prompt yas-no-prompt))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
