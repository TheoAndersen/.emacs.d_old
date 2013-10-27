(setq load-path (cons  "usr/local/Cellar/erlang/R16B01/lib/erlang/tools-2.6.6.4/emacs" load-path))
      (setq erlang-root-dir "/usr/local/Cellar/erlang/R16B01/lib/erlang/lib")
      (setq exec-path (cons "/usr/local/Cellar/erlang/R16B01/lib/erlang/bin" exec-path))
      (require 'erlang-start)	  
	  (require 'erlang-flymake)
	  (require 'erlang-eunit)


;;(let ((distel-dir "~/ErlangRigEmacsConfig/distel/elisp"))
;;  (unless (member distel-dir load-path)
;;    ;; Add distel-dir to the end of load-path
;;    (setq load-path (append load-path (list distel-dir)))))
;;(require 'distel)
;;(distel-setup)

(add-hook 'erlang-mode-hook
     (lambda ()
        (setq inferior-erlang-machine-options 
			'(
			"-sname" "emacs" 
			"-pa" "apps/*/ebin" 
			;"-boot" "start_sasl"
			))
	  (imenu-add-to-menubar "imenu")))
	  	  
(provide 'erlang-config)


;; Scraps
;; This would be really nice (it provides dialyzer hints with flymake) 
;; but it doesn't work (for me) on Windows. The escript causes permission denied
;;(require 'flymake)
;;(defun flymake-erlang-init ()
;;	(let* ((temp-file (flymake-init-create-temp-buffer-copy
;;		'flymake-create-temp-inplace))
;;	(local-file (file-relative-name temp-file
;;		(file-name-directory buffer-file-name))))
;;	(list "~/ErlangRigEmacsConfig/check-erlang.erl" (list local-file))))
;;(add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'" flymake-erlang-init))
;;(setq flymake-log-level 3)
