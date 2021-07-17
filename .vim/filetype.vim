augroup filetypedetect
    au! BufRead,BufNewFile *.rhtml   setfiletype eruby
    au BufNewFile,BufRead *.tt2 setf tt2html
"    au! BufRead,BufNewFile *.html    setfiletype smarty
augroup END
