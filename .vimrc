" Use Vundle as plugin manager
" 1. 
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" 2.
" Launch vim and run :PluginInstall

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'nvie/vim-flake8'
Plugin 'msanders/snipmate.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tommcdo/vim-fugitive-blame-ext'
Plugin 'vim-scripts/TortoiseTyping'
Plugin 'Shougo/neocomplete.vim'

" Color schemes
Plugin 'yantze/pt_black'
Plugin 'sickill/vim-sunburst'
Plugin 'sickill/vim-monokai'

" Org-mode
" Speeddating for incrementing dates
Plugin 'tpope/vim-speeddating'
" For linking in text
" Make sure to edit ~/.vim/bundle/utl.vim/plugin/utl_rc.vim 
" to enable browser open
Plugin 'vim-scripts/utl.vim'
Plugin 'vim-scripts/SyntaxRange'
Plugin 'jceb/vim-orgmode'

" colorscheme monokai
colorscheme sunburst

call vundle#end()
filetype plugin indent on

" FZF
set rtp+=/usr/local/Cellar/fzf/0.9.4-1
set rtp+=/usr/local/Cellar/fzf/0.9.3
set rtp+=~/.fzf
nnoremap <C-v> :FZF<CR>

" Todo
set rtp+=~/.vimrc/plugin

" Flake8
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_quickfix=0
let g:flake8_show_in_gutter=0
let g:flake8_show_in_file=1

" Neocomplete
let g:neocomplete#enable_at_startup = 1

syntax on
set ruler
set number
set term=screen-256color
set t_Co=256
syntax enable
set background=dark

set ts=4
set autoindent
set expandtab
set shiftwidth=4
set cursorline
set showmatch

set clipboard=unnamed

set backspace=indent,eol,start
nmap <F8> :TagbarToggle<CR>
nmap <F6> :Gblame<CR>
nnoremap <F5> :set relativenumber!<cr>
map <F4> :browse old<CR>

" Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>



set hlsearch
highlight Search  ctermfg=Black ctermbg=Red cterm=NONE
" keep cursor centered on screen
set so=999


" Ag for Ack
" don't forget to 
" brew install the_silver_searcher
let g:ackprg = 'ag --nogroup --nocolor --column'
