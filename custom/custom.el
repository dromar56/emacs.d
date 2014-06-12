(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-args-compile (quote ("-c" "--bare")))
 '(coffee-tab-width 4)
 '(custom-safe-themes (quote ("e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "405fda54905200f202dd2e6ccbf94c1b7cc1312671894bc8eca7e6ec9e8a41a2" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "41b6698b5f9ab241ad6c30aea8c9f53d539e23ad4e3963abff4b57c0f8bf6730" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" "fd28c910c2883b204f20242340f4f7b5f76db5b9c790ae31d9f3d471f9aff9bc" default)))
 '(elpy-default-minor-modes (quote (eldoc-mode flymake-mode yas-minor-mode auto-complete-mode)))
 '(global-linum-mode t)
 '(helm-truncate-lines t)
 '(inhibit-startup-screen t)
 '(js2-global-externs [global require])
 '(js2-include-node-externs t)
 '(linum-format " %2d ")
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(projectile-remember-window-configs t)
 '(projectile-switch-project-action (quote projectile-dired))
 '(projectile-tags-command "ctags -Re %s %s")
 '(recentf-auto-cleanup (quote never))
 '(recentf-max-saved-items 10000)
 '(scss-compile-at-save nil)
 '(show-paren-mode t)
 '(smex-history-length 1000)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-strip-common-suffix t)
 '(vc-follow-symlinks nil)
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
 '(default ((t (:background nil))))
 '(helm-selection ((t (:background "dark slate gray" :underline t))) t)
 '(org-level-1 ((t (:inherit outline-1 :foreground "coral")))))
