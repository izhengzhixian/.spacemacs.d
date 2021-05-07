;; GDB窗口配置，抄的，然后修改了一点，网址如下
;; http://everet.org/customize-emacs-gud-many-windows.html
(defadvice gdb-setup-windows (after my-setup-gdb-windows activate)
  "my gdb UI"
  (gdb-get-buffer-create 'gdb-stack-buffer)
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (let ((win0 (selected-window))
        (win1 (split-window nil nil 'left))      ;code and output
        (win2 (split-window-below (/ (* (window-height) 2) 3)))     ;stack
        )
    (select-window win2)
    (gdb-set-window-buffer (gdb-stack-buffer-name))
    (select-window win1)
    (set-window-buffer
     win1
     (if gud-last-last-frame
         (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
           (gud-find-file gdb-main-file)
         ;; Put buffer list in window if we
         ;; can't find a source file.
         (list-buffers-noselect))))
    (setq gdb-source-window (selected-window))
    (let ((win3 (split-window nil (/ (* (window-height) 3) 4)))) ;io
      (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-inferior-io) nil win3))
    (let ((win4 (split-window nil (/ (* (window-height) 2) 3)))) ;disasm
      (gdb-set-window-buffer (gdb-get-buffer-create 'gdb-disassembly-buffer) nil win4))
    (select-window win0)
    ))


(custom-set-variables
 ;; quickrun does not move focus to output buffer.
 ;;'(quickrun-focus-p nil)
 ;'(markdown-command "/usr/bin/pandoc")
 )

(add-hook 'makefile-mode-hook
          (lambda ()
            (setq-local indent-line-function 'izhengzhixian-programming/makefile-indent-line)))

(izhengzhixian-programming/setup-indent 4)

;; c/c++ mode 中 copr 的yasnippet的配置
(setq copyright-author "your_name")
(setq copyright-email "your_id@qq.com")
(setq copyright-company-name "your_name")
(setq copyright-company-email "your_id@company.com")
;(add-hook 'c-mode-common-hook 'izhengzhixian-programming/my-c-mode)
;; tags文件不要提示过大
(add-to-list 'spacemacs-large-file-modes-list 'tags-table-mode)

;; lsp-mode
;; https://zhuanlan.zhihu.com/p/103591590

(custom-set-variables
 ;; enable log only for debug
 '(lsp-log-io nil)

 ;; use `evil-matchit' instead
 ;'(lsp-enable-folding nil)

 ;; no real time syntax check
 ;'(lsp-prefer-flymake :none)

 ;; handle yasnippet by myself
 ;'(lsp-enable-snippet nil)

 ;; use `company-ctags' only.
 ;; Please note `company-lsp' is automatically enabled if installed
 ;'(lsp-enable-completion-at-point nil)

 ;; turn off for better performance
 ;'(lsp-enable-symbol-highlighting nil)

 ;; 关闭lsp-clangd模式下，cc文件中的头文件为链接形式（下划线，可点击）
 ;; use ffip instead
 '(lsp-enable-links nil)
 )

; (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\|vendor\\)$" lsp-file-watch-ignored)
