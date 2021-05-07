;;; packages.el --- emms layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: love <love@CentOS>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `emms-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `emms/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `emms/pre-init-PACKAGE' and/or
;;   `emms/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst izhengzhixian-life-packages
  '(
     ;; rss阅读器
     elfeed
     ;; 必应词典
     bing-dict
     ;; 中英文对齐
     ;cnfonts
     )
  "The list of Lisp packages required by the emms layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
name of the package to be installed or loaded, and KEYS are
any number of keyword-value-pairs.

The following keys are accepted:

- :excluded (t or nil): Prevent the package from being loaded
if value is non-nil

- :location: Specify a custom installation location.
The following values are legal:


      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


;;; packages.el ends here

(defun izhengzhixian-life/init-bing-dict ()
  (use-package bing-dict
               :ensure t
               :config
               (progn
                 ;; 'synonym, 'antonym or 'both 同义词，反义词，或者两者都有
                 (setq bing-dict-show-thesaurus 'both)
                 ;; 发音，有uk 和 us 两种，默认us
                 (setq bing-dict-pronunciation-style 'us)
                 (setq bing-dict-save-search-result t)
                 (setq bing-dict-org-file (concat user-emacs-directory
                                                  ".cache/bing-dict.org")
                 ))))
  
(defun izhengzhixian-life/pre-init-bing-dict ()
  (use-package bing-dict
               :ensure t
               :config
               (progn
                 (defun izhengzhixian-life/bing-dict-brief+ (word)
                   "Show the explanation of WORD from Bing in the echo area."
                   (interactive
                     (let* ((default (if (use-region-p)
                                       (buffer-substring-no-properties
                                         (region-beginning) (region-end))
                                       (let ((text (thing-at-point 'word)))
                                         (if text (substring-no-properties text)))))
                            (string default))
                       (list string)))
                   (save-match-data
                     (url-retrieve (concat bing-dict--base-url
                                           (url-hexify-string word))
                                   'bing-dict-brief-cb
                                   `(,(decode-coding-string word 'utf-8))
                                   t
                                   t)))
                 (autoload 'izhengzhixian-life/bing-dict-brief+ "bing-dict")
                 )))

(defun izhengzhixian-life/pre-init-elfeed  ()
  (use-package elfeed
               :ensure t
               :config
               (progn
                 ;; 解决elfeed中G与vim中G冲突
                 (define-key elfeed-search-mode-map "G" nil)
                 (setq elfeed-feeds '(("https://emacs-china.org/latest.rss" emacs)
                                      ("http://zzhcoding.coding.me/atom.xml" zhouzihao)
                                      ("https://www.zhihu.com/rss" 知乎)
                                      ("http://songshuhui.net/feed" 松鼠科学会)
                                      ("http://www.geekpark.net/rss" 极客公园)
                                      ("http://feed.cnblogs.com/blog/u/62514/rss" 个体博客)
                                      ))
               )))

(defun izhengzhixian-life/init-cnfonts ()
 (use-package cnfonts
  :ensure t
  :config
  (progn
    ;; 让 cnfonts 随着 Emacs 自动生效。
    (cnfonts-enable)
    ;; 让 spacemacs mode-line 中的 Unicode 图标正确显示。
    (cnfonts-set-spacemacs-fallback-fonts)
   ))
 )
