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

