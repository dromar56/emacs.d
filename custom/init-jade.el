(require 'sws-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))

(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))


(add-hook 'jade-mode-hook 'enable-indent-guide)
(defun enable-indent-guide ()
  "Enable indent guide mode"
  (indent-guide-mode t))

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



(provide 'init-jade)
