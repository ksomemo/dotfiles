"syntax highright
syntax on

"行番号の表示
set nu

"デフォルトの文字コード
set encoding=utf-8 
set fileencoding=utf-8

"自動判別に使用する文字コード 
set fileencodings=iso-2022-jp,euc-jp,utf-8,ucs-2,cp932,sjis 

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

" キーバインド
imap <C-j>  <ESC>

