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
" rainbow
"----------------------------------------------------------------------

" 默认打开/关闭 
"   let g:rainbow_active = 1

" <Leader><F4> : 彩虹括号开关键
nmap <Leader><F4> :RainbowToggle<CR>


" 使用 ALT+E 来选择窗口
nmap <m-e> <Plug>(choosewin)

let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}

"----------------------------------------------------------------------
" vim-startify
"----------------------------------------------------------------------

" 默认不显示 startify
let g:startify_disable_at_vimenter = 1

let g:startify_session_dir = '~/.vim/session'

" 使用 <space>ha 清除 errormarker 标注的错误
noremap <silent><space>ha :RemoveErrorMarkers<cr>

"----------------------------------------------------------------------
" vim-rt-format
"----------------------------------------------------------------------
" default `ENTER` behavior unchanged.
let g:rtf_ctrl_enter = 0

" Enable formatting when leaving insert mode
let g:rtf_on_insert_leave = 1

"----------------------------------------------------------------------
" vim-signify
"----------------------------------------------------------------------
" signify 调优
let g:signify_vcs_list = ['git', 'svn']
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change

" git 仓库使用 histogram 算法进行 diff
let g:signify_vcs_cmds = {
	\ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
	\}

if has('win32') || has('win64')
    let g:gitgutter_git_executable = 'D:\\ProSoftWare\\Git\\bin\\git.exe'
endif

"----------------------------------------------------------------------
" indentLine
"----------------------------------------------------------------------

" 默认开启/关闭
let g:indentLine_enabled = 1

" 改变缩进对齐线
let g:indentLine_char = '|'

"----------------------------------------------------------------------
" undotree
"----------------------------------------------------------------------


" 开启保存 undo 历史功能
set undodir=~/.cache/undodir
set undofile

" <Leader>ud : 调用 gundo 树
nnoremap <Leader>ud :UndotreeToggle<CR>


"----------------------------------------------------------------------
" minibufexpl.vim
"----------------------------------------------------------------------

" <Leader>mt : 显示/隐藏 MiniBufExplorer 窗口
map <Leader>mt :MBEToggle<cr>

" GVim下buffer切换快捷键(ctrl + tab: 跳转后一个窗口; ctrl + shift + tab: 跳转前一个窗口)
map <C-Tab> :MBEbn<cr>
map <C-S-Tab> :MBEbp<cr>

"----------------------------------------------------------------------
" nerdcommenter
"----------------------------------------------------------------------

" 默认注释分隔符后添加空格
let g:NERDSpaceDelims = 1

" 设置语言默认使用其备用分隔符
let g:NERDAltDelims_java = 1

" 用于美化多行注释紧凑语法
let g:NERDCompactSexyComs = 1

" 将对齐行注释分隔符对齐，而不是按照代码缩进
let g:NERDDefaultAlign = 'left'

" 许评论和反转空行（在评论区域时很有用）
let g:NERDCommentEmptyLines = 1

" 消注释时，启用修剪尾随空格
let g:NERDTrimTrailingWhitespace = 1

" 加自己的自定义格式或覆盖默认值
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
