" Use Vundle as plugin manager
" 1.
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" 2.
" Launch vim and run :PluginInstall

set nocompatible              " be iMproved, required
set hidden
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'andviro/flake8-vim'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tommcdo/vim-fugitive-blame-ext'
Plugin 'vim-scripts/TortoiseTyping'
" Plugin 'Shougo/neocomplete.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/mru.vim'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'chase/vim-ansible-yaml'

" snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" This is needed so ultisnips and YCM work together
Bundle 'ervandew/supertab'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

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
" MARK FOR REMOVAL
Plugin 'jceb/vim-orgmode'

Plugin 'szw/vim-ctrlspace'
" quickfix open and hide
Plugin 'milkypostman/vim-togglelist'

" TODO: might want to remove these
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" colorscheme monokai
colorscheme sunburst

call vundle#end()
filetype plugin indent on

" FZF
set rtp+=/usr/local/Cellar/fzf/0.9.4-1
set rtp+=/usr/local/Cellar/fzf/0.9.3
set rtp+=~/.fzf
nnoremap <C-p> :FZF<CR>

" Todo
set rtp+=~/.vimrc/plugin

" Flake8
" autocmd BufWritePost *.py call Flake8()
" let g:flake8_show_quickfix=0
" let g:flake8_show_in_gutter=0
" let g:flake8_show_in_file=1
let g:PyFlakeSigns = 1
let g:PyFlakeCWindow = 0
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
set relativenumber
nnoremap <F5> :set relativenumber!<cr>
map <F4> :browse old<CR>

" Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

nnoremap <C-B> :!python % <CR>

set hlsearch
highlight Search  ctermfg=Black ctermbg=Red cterm=NONE
" keep cursor centered on screen
set so=999


" Ag for Ack
" don't forget to
" brew install the_silver_searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" when you open a file, open it at the line you were last at
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" remove spaces on blank lines after save
autocmd BufWritePre * :%s/\s\+$//e

function! GetTestPath()
    let testpath = expand('%:p')
    let testpath = substitute(testpath, "/tests/", "/", "")
    let testpath = substitute(testpath, ".py", "", "")
    let pathlist = split(testpath, '/')
    execute "normal! ?class\<cr>w\"zyw\<C-O>"
    execute "normal! ?    def\<cr>2w\"xyw\<C-O>"
    let pathlist = [pathlist[-2], pathlist[-1], @z, @x]
    let @+ = join(pathlist, ".")
    echom "Test path copied to clipboard"
endfunction
command! GT call GetTestPath()

" airline
Plugin 'bling/vim-airline'
set laststatus=2
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_x = airline#section#create([])
function! Strip()
    return substitute(@*, "^\\s\\+\\|\\s\\+$","","g")[:10]

endfunction

let g:airline_section_y = '%{Strip()}'
let g:airline_mode_map = { '__' : '-', 'n'  : 'N', 'i'  : 'I', 'R'  : 'R', 'c'  : 'C', 'v'  : 'V', 'V'  : 'V', '' : 'V', 's'  : 'S', 'S'  : 'S', '' : 'S', }

" split - opposite of J (join)
function! SplitOnComma()
    let current_line = line(".")
    s/(/&??/g
    s/)/??&/g
    s/,/&??/g
    s/?? */\r/g
    let line_delta = line(".") - current_line - 1
    execute "normal! ". line_delta   ."k"
    execute "normal! ". line_delta .">>"
    execute "normal! ". line_delta ."j"
endfunction

nnoremap K :call SplitOnComma()<CR>
nnoremap <SPACE>  <C-w>
" Python movements
" Previous/next function
map } / *def <cr> :noh <CR>
map { ? *def <cr> :noh <CR>

" LEADER MAPPINGS
nnoremap <LEADER>r :reg <CR>
nnoremap <LEADER>a za
nnoremap <LEADER>` I`<ESC>A`<ESC>^

:command W w
