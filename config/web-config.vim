"======================================================================
"
" web-config.vim - 
"
" Created by liaosw97 on 2021/01/16
" Last Modified: 2021/01/16 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :
"

"----------------------------------------------------------------------
" Element
"----------------------------------------------------------------------

	" ctrl + z + , 键触发
    let g:user_emmet_leader_key = '<C-Z>'

"----------------------------------------------------------------------
" vim-javascript
"----------------------------------------------------------------------

" 启用JSDocs的语法高亮
let g:javascript_plugin_jsdoc = 1

" 为NGDocs启用一些额外的语法高亮显示,需要启用JSDoc插件
let g:javascript_plugin_ngdoc = 1

" 启用Flow的语法突出显示
let g:javascript_plugin_flow = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

"----------------------------------------------------------------------
" vim-prettier
"----------------------------------------------------------------------

" 自动格式化
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

