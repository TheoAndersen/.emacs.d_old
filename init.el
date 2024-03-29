(setq inhibit-startup-message t)

;; Turn off mouse interface early in startup to avoid momentary display
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

;; Set path to .emacs.d
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Set path to dependencies
(setq site-lisp-dir (expand-file-name "site-lisp" dotfiles-dir))

;; Set up load path
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path site-lisp-dir)

;; Settings for currently logged in user
(setq user-settings-dir (concat user-emacs-directory "users/" user-login-name))
(add-to-list 'load-path user-settings-dir)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" dotfiles-dir))
(load custom-file)

;; Write backup files to own directory
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))


(message "(emacs) Init File 1")

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" dotfiles-dir))

(message "(emacs) Init File 2")

;; Lets start with a smattering of sanity
(require 'sane-defaults)

(message "(emacs) Init File 3")



;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

(setenv "PATH" (concat "/usr/texbin:" (getenv "PATH")))

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(require 'tex-site)


(setq ispell-program-name "aspell")
(setq ispell-list-command "list")

;; Setup extensions
(require 'setup-ido)             ; interactivily do things
(require 'setup-yasnippet)       ; snippets
(require 'setup-dired)          ; do things with directory
(require 'setup-magit)          ; git mode
(require 'setup-rgrep)
;(require 'setup-hippie)         ; Hippie expand
(require 'setup-ace-jump-mode)  ; faster search
(require 'setup-perspective)   ; tagged workspaces (like en KDE / GNome etc.)
(require 'setup-shell)
(require 'setup-wrap-region)
(require 'setup-ffip)            ; find file in project
(require 'setup-nxhtml)           ; nxhtml (multimode html)


;; Map files to modes
(require 'mode-mappings)

;; Annoying arrows mode
;(require 'annoying-arrows-mode)
;(global-annoying-arrows-mode)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" dotfiles-dir))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))
(require 'expand-region)
(require 'mark-more-like-this)
(require 'inline-string-rectangle)
(require 'multiple-cursors)
(require 'delsel)
(require 'jump-char)
(require 'eproject)
(require 'wgrep)

;; Fill column indicator
(require 'fill-column-indicator)
(setq fci-rule-color "#111122")

;; Browse kill ring
(require 'browse-kill-ring)
(setq browse-kill-ring-quit-action 'save-and-restore)

;; Smart M-x is smart
(require 'smex)
(smex-initialize)

;; Setup key bindings
(require 'key-bindings)

;; Misc
(require 'appearance)
(require 'misc)
(when is-mac (require 'mac))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Diminish modeline clutter
(require 'diminish)
(diminish 'wrap-region-mode)
(diminish 'yas/minor-mode)

;; Conclude init by setting up specifics for the current user
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))
