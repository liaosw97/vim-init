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
" 功能模块, 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
    let g:bundle_group = ['basic', 'enhanced', 'filetypes', 'textobj']
    let g:bundle_group += ['tags', 'nerdtree', 'ale', 'echodoc']
    let g:bundle_group += ['leaderf']
    let g:bundle_group += ['web']
    let g:bundle_group += ['java']
    let g:bundle_group += ['lisp']
    let g:bundle_group += ['markdown']
    let g:bundle_group += ['asyncRun', 'asyncComplete']
    let g:bundle_group += ['vista']
    let g:bundle_group += ['incsearch']
    let g:bundle_group += ['leetcode']
	let g:bundle_group += ['python']
	let g:bundle_group += ['zhInput'] " 中文输入法
	let g:bundle_group += ['debug']
endif

"----------------------------------------------------------------------
" 补全服务器
"----------------------------------------------------------------------

if !exists('g:lang_serve')
    let g:lang_serve = ['vim-lsp']
    let g:lang_serve += ['ale']
endif

"----------------------------------------------------------------------
" 补全框架
"----------------------------------------------------------------------

if !exists('g:lang_complete')
    let g:lang_complete = ['async']

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
" NERDTree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
	Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'PhilRunninger/nerdtree-visual-selection'
    Plug 'ryanoasis/vim-devicons'
endif

"----------------------------------------------------------------------
" LanguageTool 语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'grammer') >= 0
	Plug 'rhysd/vim-grammarous'
endif

"---------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
	" 自动下载对应的插件
	function! InstallRequiredForALE(info)
		if has('win32') || has('win64')
			" python
			if index(g:bundle_group, 'python') >= 0
				!pip install flake8
			endif

			" JavaScript
			if index(g:bundle_group, 'web') >= 0 
				!npm install -g eslint eslint-plugin-vue
			endif
		else
			" python
			if index(g:bundle_group, 'python') >= 0
				!sudo pip install flake8
			endif

			" JavaScript
			if index(g:bundle_group, 'web') >= 0 
				!sudo npm install -g eslint eslint-plugin-vue
			endif
		endif
	endfunction	



if index(g:bundle_group, 'ale') >= 0
	Plug 'w0rp/ale', { 'do': function('InstallRequiredForALE') }

endif



"----------------------------------------------------------------------
" echodoc：搭配 YCM/deoplete 在底部显示函数参数
"----------------------------------------------------------------------
if index(g:bundle_group, 'echodoc') >= 0
	Plug 'Shougo/echodoc.vim'
endif

"----------------------------------------------------------------------
" LeaderF：CtrlP / FZF 的超级代替者，文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
if index(g:bundle_group, 'leaderf') >= 0 && (has('python') || has('python3'))

	" 如果 vim 支持 python 则启用  Leaderf
	Plug 'Yggdroot/LeaderF',{ 'do': ':LeaderfInstallCExtension' }
    Plug 'skywind3000/Leaderf-snippet'
endif

"----------------------------------------------------------------------
" 前端WEB插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'web') >= 0
	" js 在 html页面中缩进
	Plug 'othree/html5.vim'

	" HTML书写快捷键
    Plug 'mattn/emmet-vim'

    " css语法高亮
    Plug 'ap/vim-css-color', {'for': ['html', 'css']}

    " JavaScript语法突出显示和改进的缩进
    Plug 'pangloss/vim-javascript', {'for': ['html', 'js']}

	" jsx语法高亮
	Plug 'yuezk/vim-js'
	Plug 'maxmellon/vim-jsx-pretty'

	" VUE
	Plug 'posva/vim-vue'

	" post install (yarn install | npm install) then load plugin only for editing supported files
	Plug 'prettier/vim-prettier', {
		\ 'do': 'yarn install --frozen-lockfile --production',
		\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

endif
"----------------------------------------------------------------------
" Java
"----------------------------------------------------------------------
if index(g:bundle_group, 'java') >= 0
    Plug 'artur-shaik/vim-javacomplete2', {'for': ['java', 'jsp']}
endif


"----------------------------------------------------------------------
" lisp
"----------------------------------------------------------------------
if index(g:bundle_group, 'lisp') >= 0
    Plug 'vlime/vlime', {'rtp': 'vim/'}
endif

"----------------------------------------------------------------------
" Markdown
"----------------------------------------------------------------------
if index(g:bundle_group, 'markdown') >= 0
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/mathjax-support-for-mkdp'
	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
    Plug 'mzlogin/vim-markdown-toc'
endif

"----------------------------------------------------------------------
" asyncRun
"----------------------------------------------------------------------
if index(g:bundle_group, 'asyncRun') >= 0
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.extra'
    Plug 'skywind3000/asyncrun.vim'
	Plug 'pedsm/sprint'
endif

"----------------------------------------------------------------------
" async
"----------------------------------------------------------------------

	" 自动下载对应的插件
	function! InstallRequirediForAsync(info)
		if has('win32') || has('win64')
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
			
			" bash
			!npm install -g bash-language-server

			" CSS
			!npm install -g vscode-css-languageserver-bin

			" HTML
			!npm install --global vscode-html-languageserver-bin
		else
			" python
			if index(g:bundle_group, 'python') >= 0
				!sudo pip install python-language-server
			endif
		
			" JavaScript
			if index(g:bundle_group, 'web') >= 0 
				!sudo npm install -g typescript typescript-language-server
			endif

			if executable('ctags')
				!sudo pip install pygments
			endif

			" vim
			!sudo npm install -g vim-language-server
			
			" bash
			!sudo npm install -g bash-language-server

			" CSS
			!sudo npm install -g vscode-css-languageserver-bin

			" HTML
			!sudo npm install --global vscode-html-languageserver-bin

		endif

	endfunction	


if index(g:bundle_group, 'asyncComplete') >= 0
	
	" 词典补全
    Plug 'skywind3000/vim-dict'
    Plug 'skywind3000/vim-auto-popmenu'

	Plug 'mityu/vim-wispath'

	" Language Serve
	if index(g:lang_serve, 'vim-lsp') >= 0
		Plug 'prabirshrestha/vim-lsp', { 'do': function('InstallRequirediForAsync') }
		Plug 'mattn/vim-lsp-settings'
	endif

	if index(g:lang_serve, 'ale') >= 0
		Plug 'rhysd/vim-lsp-ale'
	endif

	" Language Complete
	if index(g:lang_complete, 'async') >= 0
		Plug 'prabirshrestha/asyncomplete.vim'
		Plug 'prabirshrestha/async.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'

		" Omnifunc 
		Plug 'yami-beta/asyncomplete-omni.vim'

		" TypeScript
		" Plug 'ryanolsonx/vim-lsp-typescript'

		" File
		Plug 'liaosw97/asyncomplete-file.vim'

		" 缓冲区
		Plug 'prabirshrestha/asyncomplete-buffer.vim'

		" HTML补全
		Plug 'prabirshrestha/asyncomplete-emmet.vim'
    
		" Git
		Plug 'laixintao/asyncomplete-gitcommit'


		" Tmux
		"Plug 'wellle/tmux-complete.vim'

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
endif

"----------------------------------------------------------------------
" incsearch
"----------------------------------------------------------------------
if index(g:bundle_group, 'incsearch') >= 0
    Plug 'haya14busa/incsearch.vim'		    	
    Plug 'haya14busa/incsearch-fuzzy.vim'
    Plug 'haya14busa/incsearch-easymotion.vim'

endif

"----------------------------------------------------------------------
" leetcode
"----------------------------------------------------------------------
if index(g:bundle_group, 'leetcode') >= 0
    Plug 'ianding1/leetcode.vim'
endif

"----------------------------------------------------------------------
" python
"----------------------------------------------------------------------
if index(g:bundle_group, 'python') >= 0
    Plug 'sillybun/vim-repl'
endif

"----------------------------------------------------------------------
" 中文输入法
"----------------------------------------------------------------------

if index(g:bundle_group, 'zhInput') >= 0
	Plug 'ZSaberLv0/ZFVimIM'
	Plug 'ZSaberLv0/ZFVimJob' " 可选, 用于提升词库加载性能
	Plug 'ZSaberLv0/ZFVimGitUtil' " 可选, 如果你希望定期自动清理词库 push 历史
	Plug 'liaosw97/ZFVimIM_pinyin_base' " 你的词库
	Plug 'ZSaberLv0/ZFVimIM_openapi' " 可选, 百度云输入法
endif

"----------------------------------------------------------------------
" debug
"----------------------------------------------------------------------
if index(g:bundle_group, 'debug') >= 0
	Plug 'puremourning/vimspector'
endif

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------
call plug#end()

