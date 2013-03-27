(require 'dash)
(require 's)

(defvar pa-folder (expand-file-name "project-archetypes" user-emacs-directory))
(defvar pa-project-folder (expand-file-name "projects" "~"))
(defvar pa-out "*project-archetypes-output*")

(defun pa--join-patterns (patterns)
  "Turn `ffip-paterns' into a string that `find' can use."
  (mapconcat (lambda (pat) (format "-name \"%s\"" pat))
             patterns " -or "))

(defun pa--files-matching (patterns folder &optional type)
  (split-string (shell-command-to-string
                 (format "find %s %s \\( %s \\) | head -n %s"
                         folder
                         (or type "")
                         (pa--join-patterns patterns)
                         1000))))

(defun pa--instantiate-template-file (file replacements)
  (with-temp-file file
    (insert-file-contents-literally file)
    (--each replacements
      (goto-char 0)
      (while (search-forward (car it) nil t)
        (replace-match (cdr it))))))

(defun pa-sh (cmd)
  (shell-command cmd pa-out))

(defun pa-instantiate-template-directory (template folder &rest replacements)
  (let ((tmp-folder (expand-file-name (concat "__pa_tmp_" template) pa-project-folder)))
    (copy-directory (expand-file-name template pa-folder) tmp-folder nil nil t)
    (--each (pa--files-matching (-map 'car replacements) tmp-folder)
      (rename-file it (s-replace-all replacements it)))
    (--each (pa--files-matching ["*"] tmp-folder "-type f")
      (pa--instantiate-template-file it replacements))
    (copy-directory tmp-folder folder)
    (delete-directory tmp-folder t)))

(put 'pa-instantiate-template-directory 'lisp-indent-function 2)

(defmacro pa-with-new-project (project-name archetype replacements &rest body)
  `(let ((folder (expand-file-name ,project-name pa-project-folder)))
     (pa-instantiate-template-directory ,archetype folder ,@replacements)
     (view-buffer-other-window pa-out)
     (let ((default-directory (concat folder "/")))
       (pa-sh "git init")
       ,@body
       (pa-sh "git add -A")
       (pa-sh "git ci -m \"Initial commit\""))))

(put 'pa-with-new-project 'lisp-indent-function 2)

(provide 'project-archetypes)
;;; project-archetypes.el ends here
