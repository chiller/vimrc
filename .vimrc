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
Plugin 'sickill/vim-monokai'
Plugin 'nvie/vim-flake8'
Plugin 'msanders/snipmate.vim'
call vundle#end()
filetype plugin indent on

" FZF
set rtp+=/usr/local/Cellar/fzf/0.9.4-1
nnoremap <C-v> :FZF<CR>

" Colorscheme
colorscheme monokai

" Flake8
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_quickfix=0
let g:flake8_show_in_gutter=1

syntax on
set ruler
