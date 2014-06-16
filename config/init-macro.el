(fset 'my-create-header
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([1 67108896 5 134217787 1 11 25 return 25 return 25 up 1 S-right 134217847 up 1 67108896 5 134217848 101 backspace 114 101 103 101 120 114 101 112 108 backspace backspace backspace backspace backspace backspace backspace backspace backspace 114 101 112 108 97 99 101 114 101 return 46 return 25 return 1 11 25 down down 1 11 25 134217849 up 1 C-right C-left] 0 "%d")) arg)))


(fset 'my-projectile-multi-occur
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([8388710 right 134217825 19] 0 "%d")) arg)))


;;;;;;;;;;;;;;;;;;;;;;
;; Save Macro Function
;;;;;;;;;;;;;;;;;;;;;;

(defun save-macro (name)
  "save a macro. Take a name as argument
     and save the last defined macro under
     this name at the end of init-macro.el"
  (interactive "SName of the macro :")  ; ask for the name of the macro
  (kmacro-name-last-macro name)         ; use this name for the macro
  (find-file (concat user-emacs-directory "config/init-macro.el"))            ; open ~/.emacs or other user init file
  (goto-char (point-min))               ; go to the end of the .emacs
  (insert-kbd-macro name)               ; copy the macro
  (newline)                             ; insert a newline
  (newline)                             ; insert a newline
  (newline)                             ; insert a newline
  (switch-to-buffer nil))               ; return to the initial buffer

(provide 'init-macro)
