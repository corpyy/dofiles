" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those 
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim 
" will be overwritten everytime an upgrade of the vim packages is performed.  
" It is recommended to make changes after sourcing debian.vim since it alters 
" the value of the 'compatible' option.

"**************************************************
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

"**************************************************
" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
" set compatible
set nocompatible

"**************************************************
" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

"**************************************************
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

"**************************************************
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"**************************************************
" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

"**************************************************
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.

set showcmd                 " Show (partial) command in status line.
set showmatch               " Show matching brackets
set ignorecase              " Do case insensitive matching
set smartcase               " Do smart case matching
set incsearch               " Incremental search
set autowrite               " Automatically save before commands like :next and :make
set hidden                  " Hide buffers when they are abandoned
set mouse=a                 " Enable mouse usage (all modes)
set guifontset=a14,r14,k14
set linespace=1
"set paste
set textwidth=0
set tabstop=4
set autoindent
set expandtab
"set noexpandtab
set shiftwidth=4
set softtabstop=4
set smarttab
set backspace=indent,eol,start
"set columns=75
"set lines=55 
set showcmd
set cmdheight=2
set guioptions+=a
set clipboard+=unnamed,autoselect
set number
set ruler
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%ceV%8P
set laststatus=2
set title
set wildmenu
set foldlevel=0
set directory=$HOME
set hlsearch                " Hilight search

" Centerize cursor when search
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

"***************************************************
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


"***************************************************
" Syntax of Go

if $GOROOT != ''
    set rtp+=$GOROOT/misc/vim
endif

"***************************************************
" Clolor scheme

colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1
" set background=dark

"***************************************************
" Change status line color when using insert mode
"
if !exists('g:hi_insert')
    "let g:hi_insert= 'highlight StatusLine guifg=White guibg=DarkCyan gui=none ctermfg=White ctermbg=DarkCyan cterm=none'
    let g:hi_insert= 'highlight StatusLine guifg=White guibg=33 gui=none ctermfg=White ctermbg=33 cterm=none'
endif

"if has('unix') && !has('gui_running')
"    inoremap <silent> <ESC> <ESC>
"    inoremap <silent> <C-[> <ESC>
"endif

if has('syntax')
    augroup InsertHook
        autocmd!
        autocmd InsertEnter * call s:StatusLine('Enter')
        autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif

let s:slhlcmd= ''
function! s:StatusLine(mode)
    if a:mode== 'Enter'
        silent! let s:slhlcmd= 'highlight ' . s:GetHighlight('StatusLine')
        silent exec g:hi_insert
    else
        highlight clear StatusLine
        silent exec s:slhlcmd
    endif
endfunction

function! s:GetHighlight(hi)
    redir => hl
    exec 'highlight ' .a:hi
    redir END
    let hl= substitute(hl, '[\r\n]', '', 'g')
    let hl= substitute(hl, 'xxx', '', '')
    return hl
endfunction


"***************************************************************
" Cursorline
"
set cursorline
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter, BufRead * set cursorline
augroup END
:hi clear CursorLine
:hi CursorLine gui=underline
:hi CursorLine ctermbg=black guibg=black

"****************************************************************
" Text Encoding

set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8 
set ffs=unix
if exists('&ambiwidth')
        set ambiwidth=double
endif

"***************************************************************
" Invalidation of Angles

inoremap <LEFT> <Nop>
inoremap <RIGHT> <Nop>
inoremap <DOWN> <Nop>
inoremap <UP> <Nop>
inoremap <PageDown> <Nop>
inoremap <PageUp> <Nop>
nnoremap <LEFT> <Nop>
nnoremap <RIGHT> <Nop>
nnoremap <DOWN> <Nop>
nnoremap <UP> <Nop>
nnoremap <PageDown> <Nop>
nnoremap <PageUp> <Nop>


"****************************************************************
" Make command

autocmd filetype python :set makeprg=python\ %

"****************************************************************
" Tab operation

nnoremap <C-Right> :tabnew <Return>
nnoremap <C-Left> :tabclose <Return>
nnoremap <C-Up> gt
nnoremap <C-Down> gT
inoremap <C-Right> <Esc>:tabnew<Return>
inoremap <C-Left> <Esc>:tabclose<Return>
inoremap <C-Up> <Esc>gt
inoremap <C-Down> <Esc>gT


"*****************************************************************
" Syntax of Go

if $GOROOT != ''
    set rtp+=$GOROOT/misc/vim
endif

" gocode
set rtp+=$GOROOT/misc/vim

" golint
exe "set rtp+=".globpath($GOPATH, "src/github.com/golang/lint/misc/vim")

" autocmd
auto BufWritePre *.go Fmt

"*****************************************************************
" vim-quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

"*****************************************************************
" Neovundle plugin

set nocompatible               " be iMproved
filetype off                   " required!

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif


" write plugins from neobundle#begin to neobundle#end
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
" If I use plugins in GitHub repositries
NeoBundle 'tpope/vim-fugitive'

" If I use plugins in git repositories but except Github repositories
NeoBundle 'git://git.wincent.com/command-t.git'

" If I use plugins except git repositries
NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim'
NeoBundle 'FuzzyFinder'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'grep.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'vim-scripts/AnsiEsc.vim'
NeoBundle 't9md/vim-quickhl'
NeoBundle "tyru/caw.vim.git"
NeoBundle 'uarun/vim-protobuf'
NeoBundle 'Blackrush/vim-gocode'
NeoBundle 'L9'


"***** NERDTree
nnoremap <C-d> :NERDTree<CR>

"***** Color scheme
NeoBundle 'tomasr/molokai'


"***** Auto complement
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif
" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}

"***** Use Shell
NeoBundleLazy 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}
" vimshell {{{
nmap <silent> vs :<C-u>VimShell<CR>
nmap <silent> vp :<C-u>VimShellPop<CR>
" }}}


"""""" File viewer
NeoBundleLazy 'Shougo/vimfiler', {
  \ 'depends' : ["Shougo/unite.vim"],
  \ 'autoload' : {
  \   'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
  \   'mappings' : ['<Plug>(vimfiler_switch)'],
  \   'explorer' : 1,
  \ }} 
" vimfiler {{{
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_data_directory       = expand('~/.vim/etc/vimfiler')
nnoremap <silent><C-u><C-j> :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR>
" }}}


"""""" Autoclose
NeoBundle 'Townk/vim-autoclose'
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>


"""""" Endwise
NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}


""""""" Memo
NeoBundle 'glidenote/memolist.vim'
" memolist {{{
let g:memolist_path = expand('~/Dropbox/memolist')
let g:memolist_gfixgrep = 1
let g:memolist_unite = 1
let g:memolist_unite_option = "-vertical -start-insert"
nnoremap mn  :MemoNew<CR>
nnoremap ml  :MemoList<CR>
nnoremap mg  :MemoGrep<CR>
" }}}


"""""" Motion
NeoBundle 'Lokaltog/vim-easymotion'
" vim-easymotion {{{
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
" }}}

"***** Alien
NeoBundleLazy 'junegunn/vim-easy-align', {
  \ 'autoload': {
  \   'commands' : ['EasyAlign'],
  \   'mappings' : ['<Plug>(EasyAlign)'],
  \ }}

" vim-easy-align {{{
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" }}}


"***** html complement
NeoBundle 'mattn/emmet-vim'

"***** Syntax
NeoBundle 'rcmdnk/vim-markdown'
" vim-markdown {{{
let g:vim_markdown_folding_disabled = 1
" }}}

"***** jedi.vim
NeoBundle 'davidhalter/jedi-vim'



call neobundle#end()

filetype plugin indent on     " required!
filetype indent on
NeoBundleCheck

" neocomplete/neocomplcache 用
if neobundle#is_installed('neocomplete')
    " neocomplete用設定
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'
elseif neobundle#is_installed('neocomplcache')
    " neocomplcache用設定
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1
endif
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"


" 複数行コメントアウトプラグイン用
nmap <C-i> <Plug>(caw:i:toggle)
vmap <C-i> <Plug>(caw:i:toggle)



set fencs=iso-2022-jp,sjis,euc-jp
set nu

"***************************************************** 
" tab
" show
set tabstop=4
" insert
set shiftwidth=8


