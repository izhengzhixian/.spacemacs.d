(configuration-layer/declare-layers '(
                                      ;chrome
                                      (dap
                                       :variables 
                                       ;dap-enable-mouse-support nil
                                       ;dap-enable-ui-controls nil
                                       )
                                      import-js
                                      web-beautify
                                      prettier
                                      imenu-list
                                      lsp
                                      java
                                      ;tern
                                      rust
                                      typescript
                                      (javascript 
                                       :variables 
                                       javascript-import-tool 'import-js
                                       ;node-add-modules-path t
                                       ;js2-include-node-externs t
                                       javascript-repl 'nodejs)
                                      html
                                      json
                                      protobuf
                                      yaml
                                      git
                                      emacs-lisp
                                      vimscript
                                      django
                                      (python
                                        :variables
                                        python-sort-imports-on-save t
                                        python-enable-yapf-format-on-save t
                                        lsp-pyls-plugins-pycodestyle-max-line-length 160
                                        )
                                      (go
                                       :variables
                                       go-tab-width 4
                                       go-format-before-save t
                                       go-use-golangci-lint t
                                       )
                                      ruby
                                      (c-c++ :variables 
                                             c-c++-backend 'lsp-clangd
                                             c-c++-default-mode-for-headers 'c++-mode
                                             c-c++-enable-google-style t
                                             c-c++-enable-google-newline t
                                             )
                                      gtags
                                      (auto-completion :variables auto-completion-enable-sort-by-usage t
                                                       ;auto-completion-enable-snippets-in-popup t
                                                       auto-completion-idle-delay 0.05
                                                       company-show-numbers t
                                                       company-statistics-auto-restore nil
                                                       :disabled-for org markdown)
                                      shell
                                      syntax-checking
                                      izhengzhixian-base
                                      ))
