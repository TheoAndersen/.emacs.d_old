;;-----------------|
;;  Initial Setup  |
;;_________________|

; no splash screen
(setq inhibit-startup-message t)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; right option is'nt emacs.. so that we can make {  and }
(setq mac-right-option-modifier nil)

;; Set up load path
(add-to-list 'load-path user-emacs-directory)

(defun read-system-path ()
  (with-temp-buffer
    (insert-file-contents "/etc/paths")
    (goto-char (point-min))
    (replace-regexp "\n" ":")
    (thing-at-point 'line)))

(setenv "PATH" (read-system-path))
(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))


;;---------------------------------------|
;;  Backup / Autosave and locking files  |
;;_______________________________________|

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

; Don't use lock files (.#<file>) because they annoy build systems
(setq create-lockfiles nil)

;;; backup/autosave
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))


;;---------------------------|
;;  Which system are we on?  |
;;___________________________|

; is mac?
(setq is-mac (equal system-type 'darwin))

;; Create function for mac-fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; mac friendly font
;(set-face-attribute 'default nil :font "Monaco" :height 140)
(set-face-attribute 'default nil :height 140)

;; keybinding to toggle full screen mode
(global-set-key (quote [M-f10]) (quote toggle-fullscreen))


;;---------------------------------------------
;; Load / install and setup the right packages
;;_____________________________________________

(require 'package)
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq-default js2-idle-timer-delay 0.1)
(setq-default js2-auto-indent-flag t)
(setq-default js2-global-externs '("module" "require" "jQuery" "$" "_" "buster" "sinon" "assert" "refute" "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location" "__dirname" "console" "JSON"))
(setq-default js2-indent-on-enter-key t)
(require 'js2-mode)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


(require 'erlang-config)
(require 'tramp)
(require 'perspective)
(setq tramp-default-method "ftp")

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
   (cons 'perspective melpa)
   (cons 'ace-jump-mode melpa)
   (cons 'ace-jump-buffer melpa)
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


(require 'key-bindings)
(require 'expand-region)
(require 'appearance)
