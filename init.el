;; (add-to-list 'load-path "~/.emacs.d/vendor/org-mode-zip/lisp")
;; (add-to-list 'load-path "~/.emacs.d/vendor/org-mode/lisp")

(add-to-list 'load-path "~/.emacs.d/vendor/benchmark-init-el/")
(require 'benchmark-init-loaddefs)
(benchmark-init/activate)

(package-initialize)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(let ((emacs-binary (if (eq system-type 'darwin)
			"/Applications/Emacs.app/Contents/MacOS/Emacs"
		      "emacs")))
  (if (file-newer-than-file-p "~/.emacs.d/config.org" "~/.emacs.d/config.el")
      (shell-command-to-string (concat emacs-binary " -q --script ~/.emacs.d/tangle_config.el"))))

(require 'org)
(require 'use-package)
(setq use-package-always-ensure t)
(load-file (expand-file-name "~/.emacs.d/config.el"))



(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
