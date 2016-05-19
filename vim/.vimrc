" -----------------------------------------------------------------------------
" file:         ~/.vimrc
" author:       fielding johnston - http://justfielding.com
" -----------------------------------------------------------------------------


" plugins {{{1
" -----------------------------------------------------------------------------
if filereadable(expand("~/.vim/bundles.vim"))                                   " if bundles.vim exists then...
	source ~/.vim/bundles.vim                                                     " include vundle's bundle config!
endif

" init {{{1
" -----------------------------------------------------------------------------
filetype plugin indent on
syntax on

" set {{{1
" ----------------------------------------------------------------------------
set nocompatible                                                                " vim sets this automatically upon findin a vimrc file, keeping because it's my homie
set encoding=utf-8                                                              " sets encoding to utf-8
set autoread                                                                    " Re-read file if changed outside
set autowrite                                                                   " Auto save before commands like :next
set backspace=2                                                                 " full backspacing compat
set history=50                                                                  " keep 50 lines of command line history
set ruler                                                                       " show the cursor position all the time
set showcmd                                                                     " display incomplete commands
set incsearch                                                                   " do incremental searching
set hlsearch                                                                    " highlight last used search pattern
set nowrap                                                                      " don't wrap line
set textwidth=0                                                                 " stops linewrapping at invisible margins
set colorcolumn=80                                                              " column indicator
set lbr                                                                         " wrap text
set number                                                                      " show line numbers
set pastetoggle=<f5>                                                            " toggle paste mode
set clipboard=unnamed                                                           " Use the OS clipboard by default
set wildmenu                                                                    " enhanced tab-completion
set suffixesadd=.rb                                                             " comma seperated list of file suffixes
set includeexpr+=substitute(v:fname,'s$','','g')                                " expression substitution
set showtabline=2
set modeline                                                                    " respect modeline
set modelines=4
set lazyredraw

" working file settings and location
set directory=~/.vim/files/swap//
set updatecount=100
set undofile
set undodir=~/.vim/files/undo/
set backup
set backupdir=~/.vim/files/backup/
set backupext=-vimbackup
set backupskip=
set viminfo='100,n~/.vim/files/viminfo

                                                                                " TODO: Come up with what I want to use for listchars
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

" disable audio/visual bells
" evaluate after flickering fix
set noerrorbells
set novisualbell
set t_vb=

" folding
" TODO: look in to foldignore
set foldignore=                                                                 " don't ignore anything when folding
set foldmethod=marker                                                           " collapse code using indent levels
set foldnestmax=20                                                              " limit max folds for indent and syntax methods

" status bar info and appearance
" set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\            " content for statusline
set laststatus=2                                                                " lastwindow always has status line
set cmdheight=1                                                                 " set 1 line limit for 'messages'
set noshowmode                                                                  " Hide the default mode text

" indenting
set autoindent                                                                  " turns autoidenting on for new lines
set smartindent                                                                 " does the right thing (mostly)
set cindent                                                                     " stricter rules for C programs
set shiftwidth=2                                                                " 2 cols for autoindenting

" don't add newlines at the end of files
set binary
set noeol

" tabs
set expandtab                                                                   " use spaces instead of true tabs
set tabstop=2                                                                   " 2 column tabs


let mapleader=','
" "let g:html_indent_tags = 'li\|p'

                                                                                " TODO: actually implement indent_guides worth a flip
let g:indent_guides_auto_colors=0
let g:indent_guides_color_change_percent=10
let g:indent_guides_guide_size=1

" maps!
" Q does formatting qith gq. Vim 5.0 style
map Q gq

" Shift or not to shift! that is the question
map ; :

" Force writing to a file with sudo
cmap w!! w !sudo tee % >/dev/null

" enables CTRL-U after inserting a line break
inoremap <C-U> <C-G>u<C-U>
" spacebar unhighlights search text
:noremap <silent> <Space> :silent noh<Bar>echo<CR>
" Marked.app preview for markdown files
:nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>
:noremap <F6> :NERDTreeToggle<CR>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  set ttymouse=xterm
endif

" vim 7.4+ support SGR protocol which avoids issues with mouse reporting in 'big' terminals
if has('mouse_sgr')
    set ttymouse=sgr
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  set ofu=syntaxcomplete#Complete
  set path+=/path/to/your/rails-application/app/**
  set path+=/path/to/your/rails-application/lib/**
  set suffixesadd=.rb
  set includeexpr+=substitute(v:fname,'s$','','g')

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 79 characters.:
  autocmd FileType text setlocal textwidth=79

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  autocmd StdinReadPre * let s:std_in=1

  " for now not diffing NERDTree until I get it setup properly
  " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  " autocmd VimEnter * if !argc() | Startify | NERDTree | endif
  " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

  autocmd FileType python setlocal sw=4 sts=4 et

  " Enabled auto sourcing when saving my vimrc
  autocmd BufWritePost .vimrc source $MYVIMRC
endif " has("autocmd")

if has('gui_running')
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h8
  set guioptions-=T                                                             " remove toolbar
  set guioptions-=r                                                             " remove right scroll bars
  set guioptions-=l                                                             " remove left scroll bars
  set guioptions-=m                                                             " remove menu bar
  set guioptions-=b                                                             " remove bottom scroll bar
  set guicursor+=a:block-blinkon0                                               " use solid block cursor
endif
                                                                                " TODO: finish seting up powerline for vim
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" Functions used for .nfo, eventually could be used for others
function! SetFileEncodings(encodings)
let b:myfileencodingsbak=&fileencodings
let &fileencodings=a:encodings
endfunction

function! RestoreFileEncodings()
let &fileencodings=b:myfileencodingsbak
unlet b:myfileencodingsbak
endfunction

" .NFO specific
au BufReadPre *.nfo call SetFileEncodings('cp437')
au BufReadPost *.nfo call RestoreFileEncodings()

" mapping {{{1
" -----------------------------------------------------------------------------

" autocmd {{{1
" -----------------------------------------------------------------------------

" commands {{{1
" -----------------------------------------------------------------------------

" colors {{{1
" -----------------------------------------------------------------------------
set t_Co=256
set t_Sf=[3%dm
set t_Sb=[4%dm

let g:hybrid_custom_term_colors=1
set background=dark
colorscheme hybrid
highlight Normal ctermbg=NONE
highlight CursorLine ctermbg=0
highlight Comment cterm=italic

" statusline {{{1
" -----------------------------------------------------------------------------

" options {{{1
" -----------------------------------------------------------------------------
let g:Powerline_symbols='fancy'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:polyglot_disabled = ['markdown']