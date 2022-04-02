"======================================================================
"
" init-plugconfig.vim - 
"
" Created by liaosw97 on 2021/01/16
" Last Modified: 2021/01/16 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :
"
"
"
"----------------------------------------------------------------------
" Use around source 、matcher_head and sorter_rank.
.
"----------------------------------------------------------------------
call ddc#custom#patch_global('sources', ['vim-lsp'])
call ddc#custom#patch_global('sources', ['ale'])
call ddc#custom#patch_global('sources', ['around'])
call ddc#custom#patch_global('sources', ['file'])
call ddc#custom#patch_global('sources', ['buffer'])
call ddc#custom#patch_global('sources', ['tabnine'])
call ddc#custom#patch_global('sources', ['rg'])
call ddc#custom#patch_global('sources', ['line'])
call ddc#custom#patch_global('sources', ['ctags'])

call ddc#custom#patch_global('sourceOptions', {
	 \ '_': {
     \   'matchers': ['matcher_head', 'matcher_length', 'matcher_editdistance'],
     \   'sorters': ['sorter_rank'],
	 \   'converters': ['converter_fuzzy', 'converter_remove_overlap'],
	 \	 'buffer': {'mark': 'B'},
	 \	},
	 \ 'around': {'mark': 'A'},
     \ 'vim-lsp': {
     \   'matchers': ['matcher_head'],
     \   'mark': 'lsp',
     \	},
	 \ 'file': {
     \   'mark': 'F',
     \   'isVolatile': v:true,
     \   'forceCompletionPattern': '\S/\S*',
	 \	},
	 \ 'tabnine': {
     \   'mark': 'TN',
     \   'maxCandidates': 5,
     \   'isVolatile': v:true,
	 \	},
     \ 'rg': {'mark': 'rg', 'minAutoCompleteLength': 4,},
     \ 'line': {'mark': 'line'},
     \ 'ctags': {'mark': 'C'},
     \ })


call ddc#custom#patch_global('completionMenu', 'pum.vim')


call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
	  \ 'ale': {'cleanResultsWhitespace': v:false},
      \ 'line': {'maxSize': 1000},
      \ })


call ddc#custom#patch_global('filterParams', {
      \ 'matcher_editdistance': {'showScore': v:true, 'diffLen': 0, 'limit': 2},
      \ })
"----------------------------------------------------------------------
"----------------------------------------------------------------------


call ddc#enable()
call popup_preview#enable()
call signature_help#enable()
