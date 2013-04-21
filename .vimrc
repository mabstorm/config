set nocompatible

" need to prevent error if turning off when already off, need off for Pathogen
filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 "Bundle 'gmarik/vundle'

set number
set mouse=a

source $HOME/config/vim/colors/wombat.vim
source $HOME/config/vim/pathogen.vim

set encoding=euc-jp

set rtp+=$HOME/config/vim/

" Set indent options
set autoindent
set smartindent

set listchars=tab:>-
set list
autocmd BufWritePre *.pm,daemon_* :%s/\s\+$//e

" Set tab options
set tabstop=4
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Show search matches
set showmatch
set hlsearch

" Add rule
set ruler

" Set incremental search
set incsearch

" Sets how many lines of history VIM has to remember
set history=700

" Turn syntax highlighting on
syntax on

" Set to auto read when a file is changed from the outside
set autoread

" Set backup and swapfile options
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

call pathogen#infect('~/config/vim/bundle')
filetype plugin indent on

"Bundle 'Valloric/YouCompleteMe'

"insert and remove comments in visual and normal mode
vmap ,ic :s/^/#/g<CR>:let @/ = ""<CR>
map  ,ic :s/^/#/g<CR>:let @/ = ""<CR>
vmap ,rc :s/^#//g<CR>:let @/ = ""<CR>
map  ,rc :s/^#//g<CR>:let @/ = ""<CR>

map <C-F> <C-V>
