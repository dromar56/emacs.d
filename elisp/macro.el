(fset 'my-create-header
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([1 67108896 5 134217787 1 11 25 return 25 return 25 up 1 S-right 134217847 up 1 67108896 5 134217848 101 backspace 114 101 103 101 120 114 101 112 108 backspace backspace backspace backspace backspace backspace backspace backspace backspace 114 101 112 108 97 99 101 114 101 return 46 return 25 return 1 11 25 down down 1 11 25 134217849 up 1 C-right C-left] 0 "%d")) arg)))


(fset 'my-projectile-multi-occur
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([8388710 right 134217825 19] 0 "%d")) arg)))

(provide 'macro)
