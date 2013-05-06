(setq inhibit-startup-message t)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; right option is'nt emacs.. so that we can make {  and }
(setq mac-right-option-modifier nil)

;; Set up load path
(add-to-list 'load-path user-emacs-directory)

(require 'package)
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(require 'js2-mode)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'tramp)
(setq tramp-default-method "ftp")

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Write backup files to own directory
;(setq backup-directory-alist
;      `(("." . ,(expand-file-name
;                 (concat user-emacs-directory "backups")))))

;(setq backup-directory-alist
;          `((".*" . ,temporary-file-directory)))

;(setq auto-save-file-name-transforms
;          `((".*" ,temporary-file-directory t)))

;;; backup/autosave
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

(setq is-mac (equal system-type 'darwin))

(desktop-save-mode 1)


(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   (cons 'magit melpa)
   (cons 'git-commit-mode melpa)
   (cons 'gitconfig-mode melpa)
   (cons 'gitignore-mode melpa)
   (cons 'smooth-scrolling melpa)
   (cons 'undo-tree melpa)
   (cons 'js2-mode melpa)
   (cons 'js2-refactor melpa)
   (cons 'smex melpa)
   (cons 'zoom-frm melpa)
   (cons 'frame-cmds melpa)
   (cons 'frame-fns melpa)
   (cons 'expand-region melpa)
   (cons 'find-file-in-project melpa)))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(require 'sane-defaults)

;; Smart M-x is smart
(require 'smex)
(smex-initialize)

;; mac friendly font
;(set-face-attribute 'default nil :font "Monaco" :height 140)
(set-face-attribute 'default nil :height 140)

;; keybinding to toggle full screen mode
(global-set-key (quote [M-f10]) (quote ns-toggle-fullscreen))

(require 'key-bindings)
(require 'expand-region)
(require 'appearance)
