"======================================================================
"
" language-config.vim - 
"
" Created by liaosw97 on 2021/01/16
" Last Modified: 2021/01/16 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :
"

"----------------------------------------------------------------------
" Lisp 
"----------------------------------------------------------------------

let g:vlime_cl_impl = "sbcl"

if has('win32') || has('win64') 
 function! VlimeBuildServerCommandFor_sbcl(vlime_loader, vlime_eval)
    return ["D:\\ProSoftWare\\Steel Bank Common Lisp\\sbcl.exe",
                \ "--load", "C:\\Users\\Dell\\quicklisp\\setup.lisp",
                \ "--load", a:vlime_loader,
                \ "--eval", a:vlime_eval]
 endfunction
endif

"----------------------------------------------------------------------
" Java 
"----------------------------------------------------------------------

" 使用vim自带补全快捷键补全
autocmd FileType java setlocal omnifunc=javacomplete#Complete
"----------------------------------------------------------------------
" Java 
"----------------------------------------------------------------------

