(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-arguments
   (quote
    ("--smart-case" "--nogroup" "--column" "--ignore-dir" "node_modules" "--ignore-dir" "elpa")))
 '(ag-highlight-search t)
 '(avy-background t)
 '(avy-highlight-first t)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(company-dabbrev-char-regexp "[a-zA-Z0-9-_]")
 '(company-selection-wrap-around t)
 '(css-indent-offset 2)
 '(custom-safe-themes
   (quote
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "2a998a3b66a0a6068bcb8b53cd3b519d230dd1527b07232e54c8b9d84061d48d" "0f0022c8091326c9894b707df2ae58dd51527b0cf7abcb0a310fb1e7bda78cd2" "4cbec5d41c8ca9742e7c31cc13d8d4d5a18bd3a0961c18eb56d69972bbcf3071" "43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "d5f17ae86464ef63c46ed4cb322703d91e8ed5e718bf5a7beb69dd63352b26b2" "6daa09c8c2c68de3ff1b83694115231faa7e650fdbb668bc76275f0f2ce2a437" "4feee83c4fbbe8b827650d0f9af4ba7da903a5d117d849a3ccee88262805f40d" "5673c365c8679addfb44f3d91d6b880c3266766b605c99f2d9b00745202e75f6" "8d3c5e9ba9dcd05020ccebb3cc615e40e7623b267b69314bdb70fe473dd9c7a8" "3eb2b5607b41ad8a6da75fe04d5f92a46d1b9a95a202e3f5369e2cdefb7aac5c" "25c242b3c808f38b0389879b9cba325fb1fa81a0a5e61ac7cae8da9a32e2811b" "4605ce6e798971d215b01844ea39e993d683aa2fa118e02e263539298f9f3921" "807a7f4c2d0d331fc1798e6d38b890ce3582096b8d622ba3b491b2aa4345e962" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "e56ee322c8907feab796a1fb808ceadaab5caba5494a50ee83a13091d5b1a10c" "e97dbbb2b1c42b8588e16523824bc0cb3a21b91eefd6502879cf5baa1fa32e10" "49de25b465bc3c2498bcd4c1575fa0090bd56fc79cdb49b919b49eaea17ee1dd" "0aa12caf6127772c1a38f7966de8258e7a0651fb6f7220d0bbb3a0232fba967f" "113ae6902d98261317b5507e55ac6e7758af81fc4660c34130490252640224a2" "870a63a25a2756074e53e5ee28f3f890332ddc21f9e87d583c5387285e882099" "614f8478963ec8caac8809931c9d00f670e4519388c02f71d9d27b66d5741a7f" "e7ec0cc3ce134cc0bd420b98573bbd339a908ac24162b8034c98e1ba5ee1f9f6" "cc495c40747ae22dd2de6e250cbd9a408e3588b59989368af565deeeff334126" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "1c57936ffb459ad3de4f2abbc39ef29bfb109eade28405fa72734df1bc252c13" "3119b66b441eaa36acad473952dfdf901a5924b1fbc995b58477f031e12547c4" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "cda6cb17953b3780294fa6688b3fe0d3d12c1ef019456333e3d5af01d4d6c054" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "cd95da9e526850b3df2d1b58410d586386bfc0182a2aaca3f33d6cd8548c091a" "0646e3c982ea2169704bb8fe12cb372cf4711156b3b69967353ed7d40a1044b9" "13f85dabe9c9abd73426f190aeedb7d0ad32d29e1fef3138ec8a2435a8fb0910" "4ab89cc4c58408bb799084a4d9be77fe0700b2f1b75809eae330129b4b921b6f" "17f35b689dd41e49cb740bfb810ac8a53d13292cbebf68f41f772787d8b3aebf" "ff5acbbf20c7ba4889eb2b14395fcd55eeecbfb57853e47c7d514503ad83d6bb" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "46b1c7f553e0c9dceacc3208b3bf3eee149b8690ecdf2dcd9e90bbfe50488dc2" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "b0ccdbe8d324c6d14240ef8dad9e547c7fc7cd11450eac9e6807dbce0430f3c0" "f0d90d902dbee341e375b3b5b58e3cb4c26a657894feb5eb7ff7535b1a8ce9d4" "f95e7e75148cd0c51b777608140bc3e081c1170d0124efdbc7c1225e35afd4d9" "ea97033435e26d4742c0d88de2238ac8d1cb9e6df5eb9a73324382fcefa7118a" "60f04e478dedc16397353fb9f33f0d895ea3dab4f581307fbf0aa2f07e658a40" "f41fd682a3cd1e16796068a2ca96e82cfd274e58b978156da0acce4d56f2b0d5" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "62566d5660dc33b964e4276cd2ae226805f30fdeea2427c16ab69d40ad3c7003" "e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "405fda54905200f202dd2e6ccbf94c1b7cc1312671894bc8eca7e6ec9e8a41a2" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "41b6698b5f9ab241ad6c30aea8c9f53d539e23ad4e3963abff4b57c0f8bf6730" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" "fd28c910c2883b204f20242340f4f7b5f76db5b9c790ae31d9f3d471f9aff9bc" default)))
 '(default-input-method "french-prefix")
 '(dired-subtree-after-insert-hook (quote (dired-subtree--after-insert)))
 '(dired-subtree-line-prefix "    ")
 '(elpy-default-minor-modes (quote (eldoc-mode yas-minor-mode auto-complete-mode)))
 '(elpy-rpc-python-command "python")
 '(elscreen-display-screen-number t)
 '(elscreen-tab-display-kill-screen nil)
 '(eyebrowse-new-workspace t)
 '(flycheck-checkers
   (quote
    (tsx-tide clojure-cider-eastwood clojure-cider-kibit clojure-cider-typed ada-gnat asciidoc c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint d-dmd emacs-lisp emacs-lisp-checkdoc erlang eruby-erubis fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy jade json-jsonlint json-python-json less luacheck lua perl perl-perlcritic php php-phpmd php-phpcs processing puppet-parser puppet-lint python-flake8 python-pylint python-pycompile r-lintr rpm-rpmlint rst-sphinx rst ruby-rubocop ruby-rubylint ruby ruby-jruby rust-cargo rust sass scala scala-scalastyle scss-lint scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim sql-sqlint tex-chktex tex-lacheck texinfo verilog-verilator xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby typescript-tide typescript-tslint javascript-tide jsx-tide javascript-eslint)))
 '(flycheck-disabled-checkers (quote (emacs-lisp-checkdoc clojure-cider-typed)))
 '(flycheck-display-errors-delay 0)
 '(flycheck-idle-change-delay 0.5)
 '(gc-cons-threshold 50000000)
 '(helm-ag-base-command "ag")
 '(helm-ag-command-option
   "--nocolor --nogroup --ignore-dir node_modules --ignore-dir elpa")
 '(helm-always-two-windows nil)
 '(helm-boring-buffer-regexp-list
   (quote
    ("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*Minibuf")))
 '(helm-buffer-max-length 30)
 '(helm-candidate-number-limit 100)
 '(helm-descbinds-window-style (quote split-window))
 '(helm-projectile-sources-list
   (quote
    (helm-source-projectile-buffers-list helm-source-projectile-files-list helm-source-projectile-recentf-list)))
 '(helm-split-window-in-side-p t)
 '(helm-truncate-lines t t)
 '(helm-yas-display-key-on-candidate t)
 '(helm-yas-not-display-dups t)
 '(hl-paren-colors
   (quote
    ("Springgreen3" "IndianRed1" "IndianRed3" "IndianRed4")))
 '(isearch-allow-scroll nil)
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p nil)
 '(js2-global-externs [global require])
 '(js2-include-node-externs t)
 '(js2-indent-switch-body t)
 '(js2-mode-show-parse-errors nil)
 '(js2-mode-show-strict-warnings nil)
 '(magit-display-buffer-function (quote magit-display-buffer-same-window-except-diff-v1))
 '(magit-use-overlays nil)
 '(mode-require-final-newline nil)
 '(mouse-wheel-scroll-amount (quote (1 ((shift) . 5) ((control)))))
 '(neo-theme (quote nerd))
 '(neo-window-fixed-size nil)
 '(neo-window-width 35)
 '(org-agenda-files nil)
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(org-imenu-depth 4)
 '(package-selected-packages
   (quote
    (indium nodejs-indium nodejs-repl which-key clojure-snippets seq clj-refactor 4clojure aggressive-indent aggressive-indent-mode flycheck-clojure company-restclient pdf-tools ivy-rich spacemacs-theme counsel-projectile noflet yankpad dired-subtree-toggle git-gutter-fringe diff-hl org-present realgud org-download jedi doom-themes all-the-icons gruvbox-theme counsel-dash rjsx-mode swiper counsel hydra ivy-hydra company-anaconda anaconda-company anaconda-mode dockerfile-mode terraform-mode ox-gfm org htmlize flycheck-pos-tip typescript-mode js2-mode jscs sublimity minimap vimish-fold helm-descbinds js-doc tide zenburn-theme yaml-mode workgroups2 window-numbering window-number wgrep-helm wgrep-ag web-mode w3m tern-auto-complete tabbar sws-mode sublime-themes spaceline solarized-theme smooth-scrolling smex smartparens smart-mode-line slime skewer-mode shorten shackle scss-mode sass-mode restclient req-package rainbow-mode rainbow-delimiters python-environment project-explorer pretty-symbols popwin php-mode org-bullets nose neotree multi-term monokai-theme molokai-theme moe-theme mmm-mode material-theme markdown-mode magit lui love-minor-mode leuven-theme lcs lacarte key-chord json-mode js2-refactor jade-mode iy-go-to-char isearch+ indent-guide imenu-anywhere iedit idomenu ido-vertical-mode ido-ubiquitous idle-highlight-mode highlight-parentheses helm-swoop helm-spaces helm-projectile helm-dash helm-c-yasnippet helm-ag guru-mode god-mode go-eldoc git-gutter fuzzy flycheck flx-ido expand-region exec-path-from-shell evil epc ensime emr elscreen elpy edit-server discover-my-major discover direx-grep dired-subtree cyberpunk-theme company-tern company-go color-theme-solarized color-theme-sanityinc-tomorrow color-theme-approximate coffee-mode circe cider busybee-theme base16-theme avy auto-yasnippet anzu ag ack-and-a-half ace-jump-mode ac-dabbrev)))
 '(pe/directory-tree-function (quote pe/get-directory-tree-async))
 '(projectile-completion-system (quote ivy))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "build" "node_modules" "elpa")))
 '(projectile-globally-unignored-directories (quote ("/tmp")))
 '(projectile-ignored-project-function (quote file-remote-p))
 '(projectile-mode-line (quote (:eval (format " P[%s]" (projectile-project-name)))))
 '(projectile-remember-window-configs nil t)
 '(projectile-switch-project-action (quote projectile-dired))
 '(projectile-tags-command
   "find . -type f -not -iwholename '*TAGS' -not -size +16k | ctags -f %s %s -e -L -")
 '(recentf-auto-cleanup (quote never))
 '(recentf-max-saved-items 200000)
 '(rm-blacklist (quote (" hl-p" " Helm" " skewer")))
 '(rm-excluded-modes (quote (" hl-p" " Helm" " skewer")))
 '(scroll-bar-mode (quote right))
 '(scroll-conservatively 100000)
 '(scroll-preserve-screen-position 1)
 '(scss-compile-at-save nil)
 '(show-paren-delay 0)
 '(show-paren-mode t)
 '(smex-history-length 1000)
 '(sml/hidden-modes (quote (" hl-p" " Helm" " skewer")))
 '(sml/show-file-name t)
 '(sml/use-projectile-p (quote before-prefixes))
 '(sp-hybrid-kill-excessive-whitespace nil)
 '(sp-ignore-modes-list (quote (minibuffer-inactive-mode)))
 '(sp-show-pair-from-inside t)
 '(sp-successive-kill-preserve-whitespace 2)
 '(swiper-faces
   (quote
    (swiper-match-face-1 swiper-match-face-2 swiper-match-face-3 swiper-match-face-4)))
 '(tool-bar-mode nil)
 '(tree-widget-image-enable nil)
 '(typescript-indent-level 2)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-strip-common-suffix t)
 '(use-package-verbose t)
 '(vc-follow-symlinks nil)
 '(wg-emacs-exit-save-behavior (quote ##))
 '(wg-mode-line-disable nil)
 '(wgrep-enable-key "")
 '(winner-boring-buffers (quote ("*Completions*" "*helm mini*" "*helm projectile*")))
 '(winner-dont-bind-my-keys t)
 '(yas-choose-tables-first nil)
 '(yas-new-snippet-default
   "# -*- mode: snippet -*-
# name: $1
# key: ${2:${1:$(yas--key-from-desc yas-text)}}${3:
# binding: ${4:direct-keybinding}}${5:
# expand-env: ((${6:some-var} ${7:some-value}))}${8:
# type: snippet}
# --
$0")
 '(yas-prompt-functions
   (quote
    (yas-ido-prompt yas-x-prompt yas-dropdown-prompt yas-completing-prompt yas-ido-prompt yas-no-prompt))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 110 :width normal))))
 '(dired-subtree-depth-1-face ((t (:background "light gray"))))
 '(dired-subtree-depth-2-face ((t (:background "gray"))))
 '(dired-subtree-depth-3-face ((t (:background "dark gray"))))
 '(dired-subtree-depth-4-face ((t (:background "gray"))))
 '(dired-subtree-depth-5-face ((t (:background "dark gray"))))
 '(dired-subtree-depth-6-face ((t (:background "gray"))))
 '(ivy-modified-buffer ((t (:inherit default :foreground "orange red"))))
 '(org-block-end-line ((t (:background "inherit" :foreground "#9380b2")))))
