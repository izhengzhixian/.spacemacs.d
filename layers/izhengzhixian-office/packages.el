(defconst izhengzhixian-office-packages
  '(
    gnus
    org
    prodigy
    ))

(defun izhengzhixian-office/post-init-gnus ()
  (custom-set-variables
   `(gnus-home-directory
     ,(concat dotspacemacs-directory "layers/izhengzhixian-office/gnus/"))
   )
  )

(defun izhengzhixian-office/post-init-org()
 (use-package org
    :config
    (progn
      ;; 转码字符直接显示结果
      (setq org-pretty-entities t)
      ;; 讨厌的中文输入法
      (define-key org-mode-map (kbd "×") (kbd "*"))
      (define-key org-mode-map (kbd "－") (kbd "-"))
      ;; 用来解决org-mode中 #+ * 开头的行总加逗号的问题
      (defun org-escape-code-in-region (beg end)
  "Escape lines between BEG and END.
Escaping happens when a line starts with \"*\", \"#+\", \",*\" or
\",#+\" by appending a comma to it."
  (interactive "r")
  (save-excursion
    (goto-char end)
    (while (re-search-backward "^[ \t]*\\(,*\\(?:\\*\\|#\\+\\)\\)" beg t)
      (save-excursion (replace-match "\\1" nil nil nil 1)))))


(defun org-escape-code-in-string (s)
  "Escape lines in string S.
Escaping happens when a line starts with \"*\", \"#+\", \",*\" or
\",#+\" by appending a comma to it."
  (replace-regexp-in-string "^[ \t]*\\(,*\\(?:\\*\\|#\\+\\)\\)" "\\1"
			    s nil nil 1))

(defun org-unescape-code-in-region (beg end)
  "Un-escape lines between BEG and END.
Un-escaping happens by removing the first comma on lines starting
with \",*\", \",#+\", \",,*\" and \",,#+\"."
  (interactive "r")
  (save-excursion
    (goto-char end)
    (while (re-search-backward "^[ \t]*,*\\(,\\)\\(?:\\*\\|#\\+\\)" beg t)
      (save-excursion (replace-match "" nil nil nil 1)))))

(defun org-unescape-code-in-string (s)
  "Un-escape lines in string S.
Un-escaping happens by removing the first comma on lines starting
with \",*\", \",#+\", \",,*\" and \",,#+\"."
  (replace-regexp-in-string
   "^[ \t]*,*\\(,\\)\\(?:\\*\\|#\\+\\)" "" s nil nil 1))
    )
))

(defun izhengzhixian-office/post-init-prodigy()
  ;; python2 http服务器
  (prodigy-define-service
    :name "Python2 server"
    :command "python2"
    :args '("-m" "SimpleHTTPServer" "8080")
    :cwd "~/Documents"
    :tags '(python2-http)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  ;; python3 http服务器
  (prodigy-define-service
    :name "Python3 server"
    :command "python3"
    :args '("-m" "http.server" "8080")
    :cwd "~/Documents"
    :tags '(python3-http)
    :stop-signal 'sigkill
    :kill-process-buffer-on-stop t)

  (prodigy-define-service
    :name "Hexo Server"
    :command "hexo"
    :args '("server")
    :cwd izhengzhixian-office/blog-root-dir
    :tags '(hexo server)
    :kill-signal 'sigkill
    :kill-process-buffer-on-stop t)

  (prodigy-define-service
    :name "Hexo Deploy"
    :command "hexo"
    :args '("deploy" "--generate")
    :cwd izhengzhixian-office/blog-root-dir
    :tags '(hexo deploy)
    :kill-signal 'sigkill
    :kill-process-buffer-on-stop t)
  )
