;; change command to meta, and ignore option to use weird Norwegian keyboard
;(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
(setq ns-function-modifier 'hyper)

;; right option is'nt emacs.. so that we can make {  and }
(setq mac-right-option-modifier nil)

;; mac friendly font
;(set-face-attribute 'default nil :font "Monaco" :height 140)
(set-face-attribute 'default nil :height 125)

;; make sure path is correct when launched as application
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

;; keybinding to toggle full screen mode
(global-set-key (quote [M-f10]) (quote ns-toggle-fullscreen))

;; Move to trash when deleting stuff
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash/emacs")

;; Ignore .DS_Store files with ido mode
(add-to-list 'ido-ignore-files "\\.DS_Store")

;; Don't open files from the workspace in a new frame
(setq ns-pop-up-frames nil)

;; PeepOpen
;; See https://gist.github.com/1505658 if PeepOpen opens selected files in a new Emacs instance
(require 'eproject-peepopen)

;; Use aspell for spell checking: brew install aspell --lang=en
(setq ispell-program-name "/usr/local/bin/aspell")

(provide 'mac)
