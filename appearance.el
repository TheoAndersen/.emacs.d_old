(setq visible-bell t
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

(set-face-background 'region "#464740")

;; Highlight current line
(global-hl-line-mode 1)

;; Customize background color of lighlighted line
(set-face-background 'hl-line "#222222")


;; Subtler highlight in magit
;(set-face-background 'magit-item-highlight "#121212")
;(set-face-foreground 'magit-diff-none "#666666")
;(set-face-foreground 'magit-diff-add "#00cc33")



;; Highlight in yasnippet
;(set-face-background 'yas/field-highlight-face "#333399")

;; Preeeetty font in Emacs 24/Ubuntu
;(if is-mac nil
;  (set-default-font "DejaVu Sans Mono")
;  (set-face-attribute 'default nil :height 105))

(set-face-attribute 'default nil
                    :family "Monaco" :height 140 :weight 'normal)

;; org-mode colors
(setq org-todo-keyword-faces
      '(
        ("INPR" . (:foreground "yellow" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))
        ("IMPEDED" . (:foreground "red" :weight bold))
        ))

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

;; Make zooming affect frame instead of buffers
(require 'zoom-frm)

;; Sweet window-splits
(defadvice split-window-right (after balance activate) (balance-windows))
(defadvice delete-window (after balance activate) (balance-windows))

(provide 'appearance)
