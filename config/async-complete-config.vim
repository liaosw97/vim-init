"======================================================================
"
" async_complete_config.vim - 
"
" Created by liaosw97 on 2021/01/16
" Last Modified: 2021/01/16 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :
"

"----------------------------------------------------------------------
" 词典补全
"----------------------------------------------------------------------

" enable this plugin for filetypes, '*' for all files.
let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1}

" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b

"----------------------------------------------------------------------
" Async 
"----------------------------------------------------------------------

" enable this plugin for filetypes, '*' for all files.
let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1}

" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b

" don't select the first item.
set completeopt=menu,menuone,noselect

" suppress annoy messages.
set shortmess+=c

" 删除重复项
let g:asyncomplete_remove_duplicates = 1

" 模糊智能完成
let g:asyncomplete_smart_completion = 1  
let g:asyncomplete_auto_popup = 1
	
" 窗口预览
set completeopt+=preview

" 完成后自动关闭窗口
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif    

let $GTAGSLABEL = 'native-pygments'

if has('win32') || has('win64')
    let $GTAGSCONF = 'D:\ProSoftWare\Dependence\Globe\share\gtags\gtags.conf'
else
    let $GTAGSCONF = '/usr/share/gtags/gtags.conf'
endif
