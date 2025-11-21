((c-mode . ((compile-command . "make -B 6 && ./out")
            (dape-configs . ((gdb-test-unit
                              modes (c-mode)
                              command-cwd default-directory
                              command "/usr/local/bin/gdb"
                              command-args ("--interpreter=dap")
                              compile "make -B 6"
                              :request "launch"
                              :program "out"
                              :stopAtBeginningOfMainSubprogram t))))))
