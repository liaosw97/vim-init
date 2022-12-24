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
" vim-lsp 
"----------------------------------------------------------------------

" 记录日志
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/.cache/log/vim-lsp.log')


let g:lsp_semantic_enabled = 1

" 服务器安装位置
let g:lsp_settings_servers_dir = '~/.vim/lsp-setting'

let g:lsp_fold_enabled = 1

let g:lsp_experimental_show_document = 1

" vim-lsp 诊断
let g:lsp_diagnostics_enabled = 1
" 开启 virtual-text
let g:lsp_diagnostics_virtual_text_enabled = 1
" 插入模式开启诊断
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
" 延迟毫秒以更新诊断虚拟文本
let g:lsp_diagnostics_virtual_text_delay = 400
" 启用代码操作的标志
let g:lsp_document_code_action_signs_enabled = 1
let g:lsp_document_code_action_signs_delay = 400


" 启用镶嵌提示
let g:lsp_inlay_hints_enabled = 1
let g:lsp_inlay_hints_delay = 400

"----------------------------------------------------------------------
" vim-lsp 
"----------------------------------------------------------------------


