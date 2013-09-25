" neobundleの設定
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle'))
endif

" install plugin
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
"
" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f
"  your_machines_makefile
NeoBundle 'Shougo/vimproc'

" snippet
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'

filetype plugin on
filetype indent on

" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible()          ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ?                                    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets'


" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : ''
  \}

" ファイルのコンテキストに合わせたsnippetリソースの自動判別
" nnoremap <Space>se :<C-U>NeoSnippetEdit<CR>
let s:bundle = neobundle#get('neosnippet')
function! s:bundle.hooks.on_source(bundle)
  let g:neosnippet#snippets_directory = $HOME . '/.vim/snippets'

  " enable ruby & rails snippet only rails file
  function! s:RailsSnippet()
    if exists("b:rails_root") && (&filetype == "ruby")
      NeoSnippetSource ~/.vim/snippets/rails.snip
    endif
  endfunction

  function! s:RSpecSnippet()
     if (expand("%") =~ "_spec\.rb$") || (expand("%") =~ "^spec.*\.rb$")
       NeoSnippetSource ~/.vim/snippets/rspec.snip
     endif
  endfunction

  function! s:GtestSnippet()
    if (expand("%") =~ ".*Test\.cpp$")
       NeoSnippetSource ~/.vim/snippets/gtest.snip
     endif
  endfunction

  autocmd BufEnter * call s:RailsSnippet()
  autocmd BufEnter * call s:RSpecSnippet()
  autocmd BufEnter * call s:GtestSnippet()

endfunction
unlet s:bundle

" コマンドの定義 snippetの参考元にあったのでメモしておく
" command!
" \ -bang -nargs=*
" \ MyAutocmd
" \ autocmd<bang> vimrc <args>

"syntax highright
syntax on

"行番号の表示
set nu

"デフォルトの文字コード
set encoding=utf-8
set fileencoding=utf-8

"自動判別に使用する文字コード
set fileencodings=utf-8,iso-2022-jp,euc-jp,ucs-2,cp932,sjis

"オートインデントする
set autoindent

"インクリメンタルサーチ
set incsearch

"検索時に大文字小文字を無視する
set ignorecase

"対応する括弧のハイライト表示する
set showmatch

"モード表示する
set showmode

"編集中のファイル名を表示する
set title

"ルーラーの表示する
set ruler

" タブを表示するときの幅
set tabstop=4
" タブを挿入するときの幅
set shiftwidth=4

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" 記号系の表示
set list
set listchars=tab:»\ ,trail:-,nbsp:%,extends:»,precedes:«,eol:↲

" ファイル保存時の事前動作
function! s:remove_dust()
    let cursor = getpos(".")
    " 保存時に行末の空白を除去する
    %s/\s\+$//ge
    " 保存時にtabを2スペースに変換する
    " %s/\t/  /ge
    call setpos(".", cursor)
    unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_dust()

" キーバインド
imap <C-j>  <ESC>

