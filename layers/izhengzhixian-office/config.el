(setq izhengzhixian-office/blog-root-dir "~/blog")
(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
                              "xelatex -interaction nonstopmode %f"))
(add-hook 'LaTeX-mode-hook (lambda()
                             (add-to-list 
                               'TeX-command-list 
                               '("XeLaTeX" "xelatex %(mode) %t" TeX-run-TeX nil (latex-mode) ))
                             (setq TeX-command-default "XeLaTeX")
                             (setq TeX-save-query nil )
                             (setq TeX-show-compilation t)
                             (setq TeX-PDF-mode t) ))
(setq my-org-agenda-files-dir "~/.org_agenda")
(when (not (file-exists-p my-org-agenda-files-dir))
  (mkdir my-org-agenda-files-dir)
  (write-region "" nil
                (expand-file-name "work.org" my-org-agenda-files-dir))
  (write-region "" nil
                (expand-file-name "life.org" my-org-agenda-files-dir)))
(load-library "find-lisp")
(setq org-agenda-files 
      (find-lisp-find-files my-org-agenda-files-dir "\.org$"))
