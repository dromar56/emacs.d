;; Tangle config with org-mode beta version
(add-to-list 'load-path "~/.emacs.d/vendor/org-mode/lisp")
(require 'org)
(org-babel-tangle-file "~/.emacs.d/config.org")
