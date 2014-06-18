(require-package 'discover)
(require-package 'discover-my-major)

(require 'discover)
(global-discover-mode 1)




(discover-add-context-menu
 :context-menu '(js2-refactor
		 (description "JS2 Refactor2")
		 (actions
		  ("Functions"
		   ("ef" "extract function" js2r-extract-function)
		   ("em" "extract method" js2r-extract-method)
		   ("ip" "introduce parameter" js2r-introduce-parameter)
		   ("lp" "localize parameter" js2r-localize-parameter)
		   ("ao" "Arguments to object" js2r-arguments-to-object))
		  ("Variables"
		   ("ev" "Extract variable" js2r-extract-var)
		   ("iv" "Inline variable" js2r-inline-var)
		   ("rv" "Rename variable" (lambda () (interactive) (js2r-rename-var)))
		   ("vt" "var to this" js2r-var-to-this)
		   ("sv" "split var declaration" js2r-split-var-declaration))
		  ("Contract/Expand"
		   ("cu" "contract function" js2r-contract-function)
		   ("eu" "expand function" js2r-expand-function)
		   ("ca" "contract array" js2r-contract-array)
		   ("ea" "expand array" js2r-expand-array)
		   ("co" "contract object" js2r-contract-object)
		   ("eo" "expand object" js2r-expand-object))
		  ("Structure"
		   ("3i" "ternary to if" js2r-ternary-to-if)
		   ("uw" "unwrap" js2r-unwrap)
		   ("ig" "inject global in iife" js2r-inject-global-in-iife)
		   ("wi" "wrap buffer in iife" js2r-wrap-buffer-in-iife))
		  ("Misc"
		   ("lt" "log this" js2r-log-this)
		   ("sl" "forward slurp" js2r-forward-slurp)
		   ("ba" "forward barf" js2r-forward-barf))))
 :mode 'js2-mode
 :mode-hook 'js2-mode-hook
 :bind "C-c C-m")

(discover-add-context-menu
 :context-menu '(rectangles
		 (description "Register and rectangles")
		 (actions
		  ("Save to register"
		   ("w" "window configuration to register" window-configuration-to-register)
		   ("x" "copy to register" copy-to-register)
		   ("SPC" "point to register" point-to-register)
		   ("+" "increment register" increment-register)
		   ("f" "frame configuration to register" frame-configuration-to-register)
		   ;; this is technically not bound to a key but it's just too darn
		   ;; useful to leave unbound.
		   ("A" "append to register" append-to-register)
		   )

		  ("Load from register"
		   ("l" "list registers" helm-register)
		   ("i" "insert register" insert-register)
		   ("j" "jump to register" jump-to-register)
		   ("n" "number to register" number-to-register))

		  ("Rectangle"
		   ("M-w" "copy rectangle as kill" copy-rectangle-as-kill)
		   ("N" "rectangle number lines" rectangle-number-lines)
		   ("c" "clear rectangle" clear-rectangle)
		   ("d" "delete rectangle" delete-rectangle)
		   ("k" "kill rectangle" kill-rectangle)
		   ("o" "open rectangle" open-rectangle)
		   ("r" "copy rectangle to register" copy-rectangle-to-register)
		   ("t" "string rectangle" string-rectangle)
		   ("y" "yank rectangle" yank-rectangle))
		  ))

 :bind "C-x r")


(discover-add-context-menu
 :context-menu '(narrow
		 (description "Narrow")
		 (actions
		  ("Narrow"
		   ("n" "Narrow to region" narrow-to-region)
		   ("d" "Narrow to defun" narrow-to-defun)
		   ("p" "Narrow to page" narrow-to-page))
		  ("Org narrow"
		   ("b" "Org narrow to block" org-narrow-to-block)
		   ("e" "Org narrow to element" org-narrow-to-element)
		   ("s" "Org narrow to subtree" org-narrow-to-subtree))
		  ("Widen" ("w" "Widen" widen))))

 :bind "C-x n")


(discover-add-context-menu
 :context-menu '(helpfunctions
		 (description "Help Functions")
		 (actions
		  ("Help functions"

		   ("C-a"	"about-emacs" about-emacs)
		   ("C-c"	"describe-copying" describe-copying)
		   ("C-d"	"view-emacs-debugging" view-emacs-debugging)
		   ("C-e"	"view-external-packages" view-external-packages)
		   ("C-f"	"view-emacs-FAQ" view-emacs-FAQ)
		   ("C-h"	"help-for-help" help-for-help)
		   ("RET"	"view-order-manuals" view-order-manuals)
		   ("C-n"	"view-emacs-news" view-emacs-news)
		   ("C-o"	"describe-distribution" describe-distribution)
		   ("C-p"	"view-emacs-problems" view-emacs-problems)
		   ("C-t"	"view-emacs-todo" view-emacs-todo)
		   ("C-w"	"describe-no-warranty" describe-no-warranty)
		   ("C-\\"	"describe-input-method" describe-input-method)
		   ("."		"display-local-help" display-local-help)
		   ("?"		"help-for-help" help-for-help)
		   ("C"		"describe-coding-system" describe-coding-system)
		   ("F"		"Info-goto-emacs-command-node" Info-goto-emacs-command-node)
		   ("I"		"describe-input-method" describe-input-method)
		   ("K"		"Info-goto-emacs-key-command-node" Info-goto-emacs-key-command-node)
		   ("L"		"describe-language-environment" describe-language-environment)
		   ("P"		"describe-package" describe-package)
		   ("S"		"info-lookup-symbol" info-lookup-symbol)
		   ("a"		"apropos-command" apropos-command)
		   ("b"		"describe-bindings" describe-bindings)
		   ("c"		"describe-key-briefly" describe-key-briefly)
		   ("d"		"apropos-documentation" apropos-documentation)
		   ("e"		"view-echo-area-messages" view-echo-area-messages)
		   ("f"		"describe-function" describe-function)
		   ("g"		"describe-gnu-project" describe-gnu-project)
		   ("h"		"view-hello-file" view-hello-file)
		   ("i"		"info" info)
		   ("k"		"describe-key" describe-key)
		   ("l"		"view-lossage" view-lossage)
		   ("m"		"describe-mode" describe-mode)
		   ("n"		"view-emacs-news" view-emacs-news)
		   ("p"		"finder-by-keyword" finder-by-keyword)
		   ("q"		"help-quit" help-quit)
		   ("r"		"info-emacs-manual" info-emacs-manual)
		   ("s"		"describe-syntax" describe-syntax)
		   ("t"		"help-with-tutorial" help-with-tutorial)
		   ("v"		"describe-variable" describe-variable)
		   ("w"		"where-is" where-is)
		   ("<f1>"	"help-for-help" help-for-help)
		   ("<help>"	"help-for-help" help-for-help)


		   )
		  ))

 :bind "C-h h")

(provide 'init-discover)
