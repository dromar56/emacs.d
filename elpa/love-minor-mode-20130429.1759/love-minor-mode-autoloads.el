;;; love-minor-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (love/create-project-configuration love/possibly-enable-mode
;;;;;;  love-minor-mode) "love-minor-mode" "love-minor-mode.el" (21033
;;;;;;  26688 22009 605000))
;;; Generated autoloads from love-minor-mode.el

(autoload 'love-minor-mode "love-minor-mode" "\
Toggles LÖVE minor mode.

\\{love-minor-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'love/possibly-enable-mode "love-minor-mode" "\
This function determines whether or not to automatically
enable `love-minor-mode'.  If the current buffer contains any
LÖVE-specific functions then we enable the minor mode.

\(fn)" nil nil)

(add-hook 'lua-mode-hook 'love/possibly-enable-mode)

(autoload 'love/create-project-configuration "love-minor-mode" "\
This function creates a `conf.lua' file in a given directory.
It automatically fills the file with the love.conf() function and
sets the name and identity of the game.

\(fn DIRECTORY NAME IDENTITY)" t nil)

;;;***

;;;### (autoloads nil nil ("love-minor-mode-pkg.el") (21033 26688
;;;;;;  51193 980000))

;;;***

(provide 'love-minor-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; love-minor-mode-autoloads.el ends here
