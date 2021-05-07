(defconst izhengzhixian-programming-packages
  '(
    quickrun
    ;rainbow-fart
    ))

  ;; quickrun使用c++11版本运行c++ 
(defun izhengzhixian-programming/init-quickrun ()
  (use-package quickrun
    :ensure t
    :defer t
    :config
    (progn
      ;; Use this parameter as C++ default
      (quickrun-add-command "c++/c11"
                            '((:command . "g++")
                              (:exec    . ("%c -std=c++11 %o -o %e %s"
                                           "%e %a"))
                              (:remove  . ("%e")))
                            :default "c++")
      )))


(defun izhengzhixian-programming/init-rainbow-fart ()
 (use-package rainbow-fart
  :hook (prog-mode . rainbow-fart-mode)
  :config
  (progn
   ;; 每个关键词每10分钟播报一次
   ; (setq rainbow-fart-keyword-interval (* 60 10))
   ; 每个关键词都播报
   (setq rainbow-fart-keyword-interval nil)
   ;; 禁用每小时提醒
   ;(setq rainbow-fart-time-interval nil)
   )
  )
)
