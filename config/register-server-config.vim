"======================================================================
"
" language-server-config.vim - 
"
" Created by liaosw97 on 2021/01/16
" Last Modified: 2021/01/16 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :
"

"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:serve_base')
    let g:serve_base = ['Common']
    let g:serve_base += ['C']
    let g:serve_base += ['JavaScript']
    let g:serve_base += ['HTML']
	let g:serve_base += ['CSS']
	let g:serve_base += ['Python']
	let g:serve_base += ['UltiSnips']
	let g:serve_base += ['Tmux']
	let g:serve_base += ['Git']
	let g:serve_base += ['Lisp']
"	let g:serve_base += ['Vim']  " Windows 下冲突, 该模块无法使用
	let g:serve_base += ['Bash']
	let g:serve_base += ['ale']
   endif
"
"

"----------------------------------------------------------------------
" Common
"----------------------------------------------------------------------
 
if index(g:serve_base, 'Common') >=0 
    " Onifunc
    call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
        \ 'name': 'omni',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['c', 'cpp', 'java', 'sql'],
        \ 'completor': function('asyncomplete#sources#omni#completor')
        \  }))

    " Buffer 
    call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['go'],
        \ 'priority': 3,
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ }))

    " Tags
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
        \ 'name': 'tags',
        \ 'whitelist': ['*'],
        \ 'priority': 3,
        \ 'completor': function('asyncomplete#sources#tags#completor'),
        \ 'config': {
        \    'max_file_size': 50000000,
        \  },
        \ }))

	    " File
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'whitelist': ['*'],
        \ 'priority': 10,
        \ 'completor': function('asyncomplete#sources#file#completor')
        \ }))


	
 endif

"----------------------------------------------------------------------
" C/C++
"----------------------------------------------------------------------

if index(g:serve_base, 'C') >= 0 && executable('clangd')
	
	au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })

endif

"----------------------------------------------------------------------
" TypeScript && JavaScript
"----------------------------------------------------------------------

if index(g:serve_base, 'JavaScript') >= 0 && executable('typescript-language-server')
	
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })

    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
        \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
        \ })
endif


"----------------------------------------------------------------------
" Python
"----------------------------------------------------------------------

if index(g:serve_base, 'Python') >= 0 && executable('pylsp')
	
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif


"----------------------------------------------------------------------
" UltiSnips
"----------------------------------------------------------------------

if index(g:serve_base, 'UltiSnips') >= 0 && has('python3')
	
    let g:UltiSnipsExpandTrigger="<c-z>"
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif


"----------------------------------------------------------------------
" Tmux
"----------------------------------------------------------------------

if index(g:serve_base, 'Tmux') >= 0 	
    let g:tmuxcomplete#asyncomplete_source_options = {
            \ 'name':      'tmuxcomplete',
            \ 'whitelist': ['*'],
            \ 'priority': 3,
            \ 'config': {
            \     'splitmode':      'words',
            \     'filter_prefix':   1,
            \     'show_incomplete': 1,
            \     'sort_candidates': 0,
            \     'scrollback':      0,
            \     'truncate':        0
            \     }
            \ }
endif

"----------------------------------------------------------------------
" HTML
"----------------------------------------------------------------------

if index(g:serve_base, 'HTML') >= 0 

	" Emmet
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emmet#get_source_options({
		\ 'name': 'emmet',
		\ 'whitelist': ['html', 'js', 'vue'],
		\ 'completor': function('asyncomplete#sources#emmet#completor'),
		\ }))

	if executable('html-languageserver')
		au User lsp_setup call lsp#register_server({
		\ 'name': 'html-languageserver',
		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
		\ 'whitelist': ['html', 'js', 'vue'],
		\ })
endif
endif

"----------------------------------------------------------------------
" CSS 
"----------------------------------------------------------------------

if index(g:serve_base, 'CSS') >= 0 && executable('css-languageserver')
     au User lsp_setup call lsp#register_server({
        \ 'name': 'css-languageserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'css-languageserver --stdio']},
        \ 'whitelist': ['css', 'less', 'sass', 'html', 'vue'],
        \ })
endif

"----------------------------------------------------------------------
" Git 
"----------------------------------------------------------------------

if index(g:serve_base, 'Git') >= 0 
    au User asyncomplete_setup call asyncomplete#register_source({
		\ 'name': 'gitcommit',
		\ 'whitelist': ['gitcommit'],
		\ 'priority': 10,
		\ 'completor': function('asyncomplete#sources#gitcommit#completor')
		\ })
endif

"----------------------------------------------------------------------
" Lisp 
"----------------------------------------------------------------------

if index(g:serve_base, 'Lisp') >= 0 
	autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#vlime#get_source_options({ 'priority': 10 }))
endif

"----------------------------------------------------------------------
" Vim 
"----------------------------------------------------------------------

if index(g:serve_base, 'Vim') >= 0 && executable('vim-language-server')

	augroup LspVim
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'vim-language-server',
        \ 'cmd': {server_info->['vim-language-server', '--stdio']},
        \ 'whitelist': ['vim'],
        \ 'initialization_options': {
        \   'vimruntime': $VIMRUNTIME,
        \   'runtimepath': &rtp,
        \ }})
    augroup END
endif

"----------------------------------------------------------------------
" Bash 
"----------------------------------------------------------------------

if index(g:serve_base, 'Bash') >= 0 && executable('bash-language-server')
 
	augroup LspBash
	autocmd!
	 autocmd User lsp_setup call lsp#register_server({
		\ 'name': 'bash-language-server',
		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
		\ 'allowlist': ['sh'],
		\ })
	augroup END
endif

"----------------------------------------------------------------------
" Ale
"----------------------------------------------------------------------

if index(g:serve_base, 'ale') >= 0

  " Use ALE's function for asyncomplete defaults
  au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
      \ 'priority': 10, 
	  \ }))
endif

