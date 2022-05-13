"======================================================================
"
" tools_config.vim - 
"
" Created by liaosw97 on 2021/01/16
" Last Modified: 2021/01/16 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :
"

"----------------------------------------------------------------------
" tags
"----------------------------------------------------------------------

" 设定项目目录标志：除了 .git/.svn 外，还有 .root 文件
let g:gutentags_project_root = ['.root']
let g:gutentags_ctags_tagfile = '.tags'

" 默认生成的数据文件集中到 ~/.cache/tags 避免污染项目目录，好清理
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 默认禁用自动生成
let g:gutentags_modules = [] 

" 如果有 ctags 可执行就允许动态生成 ctags 文件
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif

" 如果有 gtags 可执行就允许动态生成 gtags 数据库
if executable('gtags') && executable('gtags-cscope')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 设置 ctags 的参数
let g:gutentags_ctags_extra_args = []
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 使用 universal-ctags 的话需要下面这行，请反注释
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁止 gutentags 自动链接 gtags 数据库
let g:gutentags_auto_add_gtags_cscope = 0

"----------------------------------------------------------------------
" nerdtree
"----------------------------------------------------------------------

 " 设置NERDTree子窗口宽度
let NERDTreeWinSize = 32

" 设置NERDTree子窗口位置
let NERDTreeWinPos = "left"

" 显示隐藏文件
let NERDTreeShowHidden = 1

" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 0
noremap <space>nn :NERDTree<cr>
noremap <space>no :NERDTreeFocus<cr>
noremap <space>nm :NERDTreeMirror<cr>
noremap <space>nt :NERDTreeToggle<cr>

"----------------------------------------------------------------------
" grammer
"----------------------------------------------------------------------
noremap <space>rg :GrammarousCheck --lang=en-US --no-move-to-first-error --no-preview<cr>
map <space>rr <Plug>(grammarous-open-info-window)
map <space>rv <Plug>(grammarous-move-to-info-window)
map <space>rs <Plug>(grammarous-reset)
map <space>rx <Plug>(grammarous-close-info-window)
map <space>rm <Plug>(grammarous-remove-error)
map <space>rd <Plug>(grammarous-disable-rule)
map <space>rn <Plug>(grammarous-move-to-next-error)
map <space>rp <Plug>(grammarous-move-to-previous-error)

"----------------------------------------------------------------------
" echodoc
"----------------------------------------------------------------------
set noshowmode

" To use echodoc, you must increase 'cmdheight' value.
set cmdheight=2

" Or, you could use vim's popup window feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'popup'

" To use a custom highlight for the popup window,
" change Pmenu to your highlight group
highlight link EchoDocPopup Pmenu

"----------------------------------------------------------------------
" leaderf
"----------------------------------------------------------------------
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1

" CTRL+p 打开文件模糊匹配
let g:Lf_ShortcutF = '<c-p>'

" ALT+n 打开 buffer 模糊匹配
let g:Lf_ShortcutB = '<m-n>'

" CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
noremap <c-n> :LeaderfMru<cr>

" ALT+p 打开函数列表，按 i 进入模糊匹配，ESC 退出
noremap <m-p> :LeaderfFunction!<cr>

" ALT+SHIFT+p 打开 tag 列表，i 进入模糊匹配，ESC退出
noremap <m-P> :LeaderfBufTag!<cr>

" ALT+n 打开 buffer 列表进行模糊匹配
noremap <m-n> :LeaderfBuffer<cr>

" ALT+m 全局 tags 模糊匹配
noremap <m-m> :LeaderfTag<cr>

" 最大历史文件保存 2048 个
let g:Lf_MruMaxFiles = 2048

" ui 定制
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.cache')

" 显示绝对路径
let g:Lf_ShowRelativePath = 0

" 隐藏帮助
let g:Lf_HideHelp = 1

" 模糊匹配忽略扩展名
let g:Lf_WildIgnore = {
	\ 'dir': ['.svn','.git','.hg'],
	\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
	\ }

" MRU 文件忽略扩展名
let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
let g:Lf_StlColorscheme = 'powerline'

" 禁用 function/buftag 的预览功能，可以手动用 p 预览
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" 使用 ESC 键可以直接退出 leaderf 的 normal 模式
let g:Lf_NormalMap = {
		\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
		\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
		\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
		\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
		\ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
		\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
		\ }

let g:Lf_PreviewResult = get(g:, 'Lf_PreviewResult', {})
let g:Lf_PreviewResult.snippet = 1

"----------------------------------------------------------------------
" asyncRun
"----------------------------------------------------------------------
let g:asyncrun_open = 6

"----------------------------------------------------------------------
" vista
"----------------------------------------------------------------------

" <Leader><F3> : 设置显示/隐藏标签列表子窗口的快捷键
nnoremap <Leader><F3> :Vista!!<CR>

function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"----------------------------------------------------------------------
" incsearch
"----------------------------------------------------------------------

let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

function! s:config_easyfuzzymotion(...) abort
return extend(copy({
    \   'converters': [incsearch#config#fuzzy#converter()],
    \   'modules': [incsearch#config#easymotion#module()],
    \   'keymap': {"\<CR>": '<Over>(easymotion)'},
    \   'is_expr': 0,
    \   'is_stay': 1
    \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())


function! s:config_fuzzyall(...) abort
    return extend(copy({
    \   'converters': [
    \     incsearch#config#fuzzy#converter(),
    \     incsearch#config#fuzzyspell#converter()
    \   ],
    \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> z/ incsearch#go(<SID>config_fuzzyall())
noremap <silent><expr> z? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
noremap <silent><expr> zg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1}))

"----------------------------------------------------------------------
" leetcode
"----------------------------------------------------------------------
"中国区leetcode"
let g:leetcode_china=1  
let g:leetcode_username='1414229513@qq.com'
let g:leetcode_password='1997417a.s.l.'

" 默认使用python3
let g:leetcode_solution_filetype='python3'

" 登录leetcode-cn.com的浏览器"
let g:leetcode_browser='edge'

"----------------------------------------------------------------------
" 中文输入法 
"----------------------------------------------------------------------

function! s:myLocalDb()
    let db = ZFVimIM_dbInit({
                \   'name' : 'YourDb',
                \ })

    call ZFVimIM_cloudRegister({
                \   'mode' : 'local',
                \   'dbId' : db['dbId'],
                \   'repoPath' : 'C:\\Users\\Dell\\.vim\\bundle\\ZFVimIM_pinyin_base\\misc',  
                \   'dbFile' : '/pinyin.txt', 
				\   'dbCountFile' : '/pinyin_count.txt', 
                \ })
endfunction
autocmd User ZFVimIM_event_OnDbInit call s:myLocalDb()

let g:ZFVimIM_cachePath=$HOME.'/.cache/ZFVimIM'


"----------------------------------------------------------------------
" fzf 
"----------------------------------------------------------------------
"
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
