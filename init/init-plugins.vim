"======================================================================
"
" init-plugins.vim - 
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :



"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
    let g:bundle_group = ['basic', 'tags', 'enhanced', 'filetypes', 'textobj']
    let g:bundle_group += ['tags', 'nerdtree', 'ale', 'echodoc']
    let g:bundle_group += ['leaderf']
    let g:bundle_group += ['web']
    let g:bundle_group += ['java']
    let g:bundle_group += ['lisp']
    let g:bundle_group += ['markdown']
    let g:bundle_group += ['asyncRun', 'async']
    let g:bundle_group += ['vista']
    let g:bundle_group += ['incsearch']
    let g:bundle_group += ['leetcode']
	let g:bundle_group += ['python']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', '~/.vim/bundle'))


"----------------------------------------------------------------------
" 默认插件 
"----------------------------------------------------------------------

" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'

" 文件浏览器，代替 netrw
Plug 'justinmk/vim-dirvish'

" 表格对齐，使用命令 Tabularize
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'

" 中文文档
Plug 'yianwillis/vimcdoc'
"----------------------------------------------------------------------
" Dirvish 设置：自动排序并隐藏文件，同时定位到相关文件
" 这个排序函数可以将目录排在前面，文件排在后面，并且按照字母顺序排序
" 比默认的纯按照字母排序更友好点。
"----------------------------------------------------------------------
function! s:setup_dirvish()
	if &buftype != 'nofile' && &filetype != 'dirvish'
		return
	endif
	if has('nvim')
		return
	endif
	" 取得光标所在行的文本（当前选中的文件名）
	let text = getline('.')
	if ! get(g:, 'dirvish_hide_visible', 0)
		exec 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
	endif
	" 排序文件名
	exec 'sort ,^.*[\/],'
	let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
	" 定位到之前光标处的文件
	call search(name, 'wc')
	noremap <silent><buffer> ~ :Dirvish ~<cr>
	noremap <buffer> % :e %
endfunc

augroup MyPluginSetup
	autocmd!
	autocmd FileType dirvish call s:setup_dirvish()
augroup END


"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

    " 状态栏插件
    Plug 'liuchengxu/eleline.vim'

    " 彩虹括号(适合lisp)
    Plug 'luochen1990/rainbow'

	" 展示开始画面，显示最近编辑过的文件
	Plug 'mhinz/vim-startify'

	" 一次性安装一大堆 colorscheme
	"Plug 'flazz/vim-colorschemes'

	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'

	" 用于在侧边符号栏显示 git/svn 的 diff
	Plug 'mhinz/vim-signify'

	" 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
	" 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
	Plug 'mh21/errormarker.vim'

	" 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
	Plug 't9md/vim-choosewin'

	" 提供基于 TAGS 的定义预览，函数参数预览，quickfix 预览
	Plug 'skywind3000/vim-preview'
    Plug 'skywind3000/vim-terminal-help'
    Plug 'skywind3000/vim-rt-format', { 'do': 'pip3 install autopep8' }

	" Git 支持
	Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " 符号键配对
    Plug 'jiangmiao/auto-pairs'

    " 快速更改标点符号
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-unimpaired'

    " 相同缩进的代码关联
    Plug 'Yggdroot/indentLine'

    " 撤销最近一步或多步操作
    Plug 'mbbill/undotree'

    " 多文档编辑
    Plug 'fholgado/minibufexpl.vim'

    " 注释
    Plug 'preservim/nerdcommenter'

	" 翻译
	Plug 'voldikss/vim-translator'

	" 默认打开/关闭 
    "   let g:rainbow_active = 1

    " <Leader><F4> : 彩虹括号开关键
    nmap <Leader><F4> :RainbowToggle<CR>


	" 使用 ALT+E 来选择窗口
	nmap <m-e> <Plug>(choosewin)

	" 默认不显示 startify
	let g:startify_disable_at_vimenter = 1

    let g:startify_session_dir = '~/.vim/session'

	" 使用 <space>ha 清除 errormarker 标注的错误
	noremap <silent><space>ha :RemoveErrorMarkers<cr>

    " vim-rt-format
    " By default, it will be triggered by `ENTER` in insert mode.
    " set this to 1 to use `CTRL+ENTER` instead, and keep the  
    " default `ENTER` behavior unchanged.
    let g:rtf_ctrl_enter = 0

    " Enable formatting when leaving insert mode
    let g:rtf_on_insert_leave = 1

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
        let g:gitgutter_git_executable = 'D:\ProSoftWare\Git\bin\git.exe'
    endif

    " 默认开启/关闭
    let g:indentLine_enabled = 1

    " 改变缩进对齐线
    let g:indentLine_char = '|'

    " 开启保存 undo 历史功能
    set undodir=~/.cache/undodir
    set undofile

    " <Leader>ud : 调用 gundo 树
    nnoremap <Leader>ud :UndotreeToggle<CR>

    " <Leader>mt : 显示/隐藏 MiniBufExplorer 窗口
    map <Leader>mt :MBEToggle<cr>

    " GVim下buffer切换快捷键(ctrl + tab: 跳转后一个窗口; ctrl + shift + tab: 跳转前一个窗口)
    map <C-Tab> :MBEbn<cr>
    map <C-S-Tab> :MBEbp<cr>



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
endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0

	" 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
	Plug 'terryma/vim-expand-region'

	" 快速文件搜索
	"Plug 'junegunn/fzf'

	" 给不同语言提供字典补全，插入模式下 c-x c-k 触发
	Plug 'asins/vim-dict'

	" 使用 :FlyGrep 命令进行实时 grep
	Plug 'wsdjeg/FlyGrep.vim'

	" 使用 :CtrlSF 命令进行模仿 sublime 的 grep
	Plug 'dyng/ctrlsf.vim'

	" 配对括号和引号自动补全
	Plug 'Raimondi/delimitMate'

	" 提供 gist 接口
	Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }
	
	" ALT_+/- 用于按分隔符扩大缩小 v 选区
	map <m-=> <Plug>(expand_region_expand)
	map <m--> <Plug>(expand_region_shrink)
endif


"----------------------------------------------------------------------
" 自动生成 ctags/gtags，并提供自动索引功能
" 不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root 文件
" 详细用法见：https://zhuanlan.zhihu.com/p/36279445
"----------------------------------------------------------------------
if index(g:bundle_group, 'tags') >= 0

	" 提供 ctags/gtags 后台数据库自动更新功能
	Plug 'ludovicchabant/vim-gutentags'

	" 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
	" 支持光标移动到符号名上：<leader>cg 查看定义，<leader>cs 查看引用
	Plug 'skywind3000/gutentags_plus'

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
endif


" 安装gtags(global)和universal ctags  (pip install pygments)
" 安装python补全要安装 pip install python-language-server
" 安装c/c++补全要安装clang
" 安装JavaScript补全要安装 npm install -g typescript typescript-language-server 
" 后在根目录下创建 tsconfig.json (TypeScript) 或 package.json (JavaScript)

"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj') >= 0

	" 基础插件：提供让用户方便的自定义文本对象的接口
	Plug 'kana/vim-textobj-user'

	" indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
	Plug 'kana/vim-textobj-indent'

	" 语法文本对象：iy/ay 基于语法的文本对象
	Plug 'kana/vim-textobj-syntax'

	" 函数文本对象：if/af 支持 c/c++/vim/java
	Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }

	" 参数文本对象：i,/a, 包括参数或者列表元素
	Plug 'sgur/vim-textobj-parameter'

	" 提供 python 相关文本对象，if/af 表示函数，ic/ac 表示类
	Plug 'bps/vim-textobj-python', {'for': 'python'}

	" 提供 uri/url 的文本对象，iu/au 表示
	Plug 'jceb/vim-textobj-uri'
endif

"   diw 删除光标所在单词，ciw 改写单词，vip 选中段落等，ci"/ci( 改写引号/括号中的内容
"   它新定义的文本对象主要有：
"       i, 和 a, ：参数对象，写代码一半在修改，现在可以用 di, 或 ci, 一次性删除/改写当前参数
"       ii 和 ai ：缩进对象，同一个缩进层次的代码，可以用 vii 选中，dii / cii 删除或改写
"       if 和 af ：函数对象，可以用 vif / dif / cif 来选中/删除/改写函数的内容
"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

	" powershell 脚本文件的语法高亮
	Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

	" lua 语法高亮增强
	Plug 'tbastos/vim-lua', { 'for': 'lua' }

	" C++ 语法高亮增强，支持 11/14/17 标准
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

	" 额外语法文件
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

	" python 语法文件增强
	Plug 'vim-python/python-syntax', { 'for': ['python'] }

	" rust 语法增强
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }

	" vim org-mode 
	Plug 'jceb/vim-orgmode', { 'for': 'org' }
endif


"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_powerline_fonts = 0
	let g:airline_exclude_preview = 1
	let g:airline_section_b = '%n'
	let g:airline_theme='deus'
	let g:airline#extensions#branch#enabled = 0
	let g:airline#extensions#syntastic#enabled = 0
	let g:airline#extensions#fugitiveline#enabled = 0
	let g:airline#extensions#csv#enabled = 0
	let g:airline#extensions#vimagit#enabled = 0
endif


"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
	Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'PhilRunninger/nerdtree-visual-selection'
    Plug 'ryanoasis/vim-devicons'

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
endif


"----------------------------------------------------------------------
" LanguageTool 语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'grammer') >= 0
	Plug 'rhysd/vim-grammarous'
	noremap <space>rg :GrammarousCheck --lang=en-US --no-move-to-first-error --no-preview<cr>
	map <space>rr <Plug>(grammarous-open-info-window)
	map <space>rv <Plug>(grammarous-move-to-info-window)
	map <space>rs <Plug>(grammarous-reset)
	map <space>rx <Plug>(grammarous-close-info-window)
	map <space>rm <Plug>(grammarous-remove-error)
	map <space>rd <Plug>(grammarous-disable-rule)
	map <space>rn <Plug>(grammarous-move-to-next-error)
	map <space>rp <Plug>(grammarous-move-to-previous-error)
endif

"---------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
	" 自动下载对应的插件
	function! InstallRequiredForALE(info)
			" python
			if index(g:bundle_group, 'python') >= 0
				!pip install flake8
			endif

			" JavaScript
			if index(g:bundle_group, 'web') >= 0 
				!npm install -g eslint eslint-plugin-vue vls
			endif
	endfunction	



if index(g:bundle_group, 'ale') >= 0
	Plug 'w0rp/ale', { 'do': function('InstallRequiredForALE') }

	" 设定延迟和提示信息
	let g:ale_completion_delay = 500
	let g:ale_echo_delay = 20
	let g:ale_lint_delay = 500
	let g:ale_echo_msg_format = '[%linter%] %code: %%s'

	" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
	" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
	let g:ale_lint_on_text_changed = 'normal'
	let g:ale_lint_on_insert_leave = 1

	" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
	if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
		let g:ale_command_wrapper = 'nice -n5'
	endif

	" 允许 airline 集成
	"let g:airline#extensions#ale#enabled = 1

	" 编辑不同文件类型需要的语法检查器
	let g:ale_linters = {
				\ 'c': ['gcc', 'clang'], 
				\ 'cpp': ['gcc', 'clang'], 
				\ 'python': ['flake8', 'pylint'], 
				\ 'lua': ['luac'], 
				\ 'go': ['go build', 'gofmt'],
				\ 'java': ['javac'],
				\ 'javascript': ['eslint'],
				\ 'vue': ['eslint', 'vls'],
				\ }

	let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}

	" 获取 pylint, flake8 的配置文件，在 vim-init/tools/conf 下面
	function s:lintcfg(name)
		let conf = s:path('tools/conf/')
		let path1 = conf . a:name

	    let path2 = expand('~/.vim/linter/'. a:name)

        if filereadable(path2)
			return path2
		endif
		return shellescape(filereadable(path2)? path2 : path1)
	endfunc

	" 设置 flake8/pylint 的参数
	let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')
	let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
	let g:ale_python_pylint_options .= ' --disable=W'
	let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
	let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
	let g:ale_c_cppcheck_options = ''
	let g:ale_cpp_cppcheck_options = ''

	let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']

	" 如果没有 gcc 只有 clang 时（FreeBSD）
	if executable('gcc') == 0 && executable('clang')
		let g:ale_linters.c += ['clang']
		let g:ale_linters.cpp += ['clang']
	endif


endif



"----------------------------------------------------------------------
" echodoc：搭配 YCM/deoplete 在底部显示函数参数
"----------------------------------------------------------------------
if index(g:bundle_group, 'echodoc') >= 0
	Plug 'Shougo/echodoc.vim'
	set noshowmode

    " To use echodoc, you must increase 'cmdheight' value.
    set cmdheight=2

    " Or, you could use vim's popup window feature.
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'popup'

    " To use a custom highlight for the popup window,
    " change Pmenu to your highlight group
    highlight link EchoDocPopup Pmenu
endif


"----------------------------------------------------------------------
" LeaderF：CtrlP / FZF 的超级代替者，文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
if index(g:bundle_group, 'leaderf') >= 0
	" 如果 vim 支持 python 则启用  Leaderf
	if has('python') || has('python3')
		Plug 'Yggdroot/LeaderF',{ 'do': ':LeaderfInstallCExtension' }
        Plug 'skywind3000/Leaderf-snippet'

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

	else
		" 不支持 python ，使用 CtrlP 代替
		Plug 'ctrlpvim/ctrlp.vim'

		" 显示函数列表的扩展插件
		Plug 'tacahiroy/ctrlp-funky'

		" 忽略默认键位
		let g:ctrlp_map = ''

		" 模糊匹配忽略
		let g:ctrlp_custom_ignore = {
		  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
		  \ 'file': '\v\.(exe|so|dll|mp3|wav|sdf|suo|mht)$',
		  \ 'link': 'some_bad_symbolic_links',
		  \ }

		" 项目标志
		let g:ctrlp_root_markers = ['.project', '.root', '.svn', '.git']
		let g:ctrlp_working_path = 0

		" CTRL+p 打开文件模糊匹配
		noremap <c-p> :CtrlP<cr>

		" CTRL+n 打开最近访问过的文件的匹配
		noremap <c-n> :CtrlPMRUFiles<cr>

		" ALT+p 显示当前文件的函数列表
		noremap <m-p> :CtrlPFunky<cr>

		" ALT+n 匹配 buffer
		noremap <m-n> :CtrlPBuffer<cr>
	endif
endif

"----------------------------------------------------------------------
" 前端WEB插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'web') >= 0
	" js 在 html页面中缩进
	Plug 'othree/html5.vim'

	Plug 'AndrewRadev/tagalong.vim'

	" HTML书写快捷键
    Plug 'mattn/emmet-vim'

    " css语法高亮
    Plug 'ap/vim-css-color', {'for': ['html', 'css']}

    " JavaScript语法突出显示和改进的缩进
    Plug 'pangloss/vim-javascript', {'for': ['html', 'js']}

	" VUE
	Plug 'posva/vim-vue'

	" post install (yarn install | npm install) then load plugin only for editing supported files
	Plug 'prettier/vim-prettier', {
		\ 'do': 'yarn install --frozen-lockfile --production',
		\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

	let g:tagalong_filetypes = ['html', 'vue']

	" ctrl + z + , 键触发
    let g:user_emmet_leader_key = '<C-Z>'

    " 启用JSDocs的语法高亮
    let g:javascript_plugin_jsdoc = 1

    " 为NGDocs启用一些额外的语法高亮显示,需要启用JSDoc插件
    let g:javascript_plugin_ngdoc = 1

    " 启用Flow的语法突出显示
    let g:javascript_plugin_flow = 1

	" 自动格式化
	let g:prettier#autoformat = 1
	let g:prettier#autoformat_require_pragma = 0

    augroup javascript_folding
        au!
        au FileType javascript setlocal foldmethod=syntax
    augroup END
endif
"----------------------------------------------------------------------
" Java
"----------------------------------------------------------------------
if index(g:bundle_group, 'java') >= 0
    Plug 'artur-shaik/vim-javacomplete2', {'for': ['java', 'jsp']}

    " 使用vim自带补全快捷键补全
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
endif


"----------------------------------------------------------------------
" lisp
"----------------------------------------------------------------------
if index(g:bundle_group, 'lisp') >= 0
    Plug 'vlime/vlime', {'rtp': 'vim/'}
       let g:vlime_cl_impl = "sbcl"

       if has('win32') || has('win64') 
        function! VlimeBuildServerCommandFor_sbcl(vlime_loader, vlime_eval)
           return ["D:\\ProSoftWare\\Steel Bank Common Lisp\\sbcl.exe",
                       \ "--load", "C:\\Users\\Dell\\quicklisp\\setup.lisp",
                       \ "--load", a:vlime_loader,
                       \ "--eval", a:vlime_eval]
        endfunction
       endif
endif

"----------------------------------------------------------------------
" Markdown
"----------------------------------------------------------------------
if index(g:bundle_group, 'markdown') >= 0
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/mathjax-support-for-mkdp'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
    Plug 'mzlogin/vim-markdown-toc'

endif

"----------------------------------------------------------------------
" asyncRun
"----------------------------------------------------------------------
if index(g:bundle_group, 'asyncRun') >= 0
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.extra'
    Plug 'skywind3000/asyncrun.vim'

    let g:asyncrun_open = 6
endif

"----------------------------------------------------------------------
" async
"----------------------------------------------------------------------

	" 自动下载对应的插件
	function! InstallRequirediForAsync(info)
			" python
			if index(g:bundle_group, 'python') >= 0
				!pip install python-language-server
			endif
		
			" JavaScript
			if index(g:bundle_group, 'web') >= 0 
				!npm install -g typescript typescript-language-server
			endif

			if executable('ctags')
				!pip install pygments
			endif

				" vim
			!npm install -g vim-language-server
			
			!npm install -g bash-language-server
    endfunction	


if index(g:bundle_group, 'async') >= 0

    Plug 'skywind3000/vim-dict'
    Plug 'skywind3000/vim-auto-popmenu'

    " 异步补全
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp', { 'do': function('InstallRequirediForAsync') }
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'mattn/vim-lsp-settings'
	Plug 'rhysd/vim-lsp-ale'

    " TypeScript
    " Plug 'ryanolsonx/vim-lsp-typescript'

    " Omnifunc 
    Plug 'yami-beta/asyncomplete-omni.vim'

    " File
    Plug 'prabirshrestha/asyncomplete-file.vim'

     " 缓冲区
    Plug 'prabirshrestha/asyncomplete-buffer.vim'

    " HTML补全
    Plug 'prabirshrestha/asyncomplete-emmet.vim'
    Plug 'laixintao/asyncomplete-gitcommit'

    if has('win32') || has('win64')
        Plug 'keremc/asyncomplete-clang.vim'
    else
        " Plug 'wellle/tmux-complete.vim'
    endif

    " 片段补全
    if has('python3')
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'
        Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
    endif

    " 自动生成tags
    if executable('ctags')
        Plug 'prabirshrestha/asyncomplete-tags.vim'
    endif

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
	let g:lsp_settings_servers_dir = '~/.vim/lsp-setting'

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



endif

" 安装gtags(global)和universal ctags  (pip install pygments)
" 安装python补全要安装 pip install python-language-server
" 安装c/c++补全要安装clang
" 安装JavaScript补全要安装 npm install -g typescript typescript-language-server 
" 后在根目录下创建 tsconfig.json (TypeScript) 或 package.json (JavaScript)

"----------------------------------------------------------------------
" vista
"----------------------------------------------------------------------
if index(g:bundle_group, 'vista') >= 0
    Plug 'liuchengxu/vista.vim'

    " <Leader><F3> : 设置显示/隐藏标签列表子窗口的快捷键
    nnoremap <Leader><F3> :Vista!!<CR>

    function! NearestMethodOrFunction() abort
        return get(b:, 'vista_nearest_method_or_function', '')
    endfunction

    set statusline+=%{NearestMethodOrFunction()}

    " By default vista.vim never run if you don't call it explicitly.

    " If you want to show the nearest function in your statusline automatically,
    " you can add the following line to your vimrc
    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
endif

"----------------------------------------------------------------------
" incsearch
"----------------------------------------------------------------------
if index(g:bundle_group, 'incsearch') >= 0
    Plug 'haya14busa/incsearch.vim'		    	
    Plug 'haya14busa/incsearch-fuzzy.vim'
    Plug 'haya14busa/incsearch-easymotion.vim'

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

endif

"----------------------------------------------------------------------
" leetcode
"----------------------------------------------------------------------
if index(g:bundle_group, 'leetcode') >= 0
    Plug 'ianding1/leetcode.vim'

    "中国区leetcode"
    let g:leetcode_china=1  
    let g:leetcode_username='1414229513@qq.com'
    let g:leetcode_password='1997417a.s.l.'

    " 默认使用python3
    let g:leetcode_solution_filetype='python3'

    " 登录leetcode-cn.com的浏览器"
    let g:leetcode_browser='edge'
endif

"----------------------------------------------------------------------
" python
"----------------------------------------------------------------------
if index(g:bundle_group, 'python') >= 0
    Plug 'sillybun/vim-repl'
endif

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()

