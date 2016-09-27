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


"""""""""""""""""""""""
""""""Git""""""""""""""
"""""""""""""""""""""""
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tommcdo/vim-fugitive-blame-ext'

function! GetLatestRevision()
    let @* = system("git log -n 1 --pretty=format:%h -- " . expand('%'))
    echom @*
endfunction
command! LR call GetLatestRevision()

function! GetPrForRevision()
    " get commit hash for current line
    let line=line('.')
    let lhash = system("git blame " . expand('%'). " -L ".line ." | cut -d' ' -f1 | head -n 1 | tr -d '\n' ")
    echom lhash
    execute "!pr_for_sha " . lhash
endfunction
command! Openpr call GetPrForRevision()

"""""""""""""""""""""""
""""""General""""""""""
"""""""""""""""""""""""

Plugin 'mileszs/ack.vim'
Plugin 'vim-scripts/mru.vim'
Plugin 'rbgrouleff/bclose.vim'

"""""""""""""""""""""""
""""""Python"""""""""""
"""""""""""""""""""""""
Plugin 'andviro/flake8-vim'
Plugin 'bps/vim-textobj-python'
xmap [f <Plug>(textobj-python-function-move-p)
omap [f <Plug>(textobj-python-function-move-p)

Plugin 'chase/vim-ansible-yaml'

" Autocomplete and snippets
Plugin 'Valloric/YouCompleteMe'
" snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" This is needed so ultisnips and YCM work together
Bundle 'ervandew/supertab'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_filetype_blacklist = { 'mkd.markdown': 1, 'text': 1 }
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Color schemes
Plugin 'yantze/pt_black'
Plugin 'sickill/vim-sunburst'
Plugin 'sickill/vim-monokai'
" colorscheme monokai
colorscheme sunburst

ab
" Speeddating for incrementing dates
Plugin 'tpope/vim-speeddating'
" For linking in text
" Make sure to edit ~/.vim/bundle/utl.vim/plugin/utl_rc.vim
" to enable browser open
Plugin 'vim-scripts/utl.vim'
Plugin 'vim-scripts/SyntaxRange'

Plugin 'szw/vim-ctrlspace'
set showtabline=0

" quickfix open and hide
Plugin 'milkypostman/vim-togglelist'

Plugin 'plasticboy/vim-markdown'

" Surround with parans
" VS[
" ysiw[
" cs'"
Plugin 'tpope/vim-surround'

Plugin 'mhinz/vim-startify'

" slides - commands: PresentingStart n p q
Plugin 'sotte/presenting.vim'
Plugin 'tybenz/vimdeck'

Plugin 'easymotion/vim-easymotion'
nmap <Leader>f <Plug>(easymotion-overwin-f)
nmap <Leader>L <Plug>(easymotion-overwin-line)

Plugin 'isRuslan/vim-es6'
Plugin 'lambdatoast/elm.vim'
" colorscheme monokai
colorscheme sunburst

" Persistent undo
Plugin 'mbbill/undotree'
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

Plugin 'terryma/vim-expand-region'
" Plugin 'alfredodeza/chapa.vim'
" let g:chapa_default_mappings=1

Plugin 'kana/vim-textobj-user'

call vundle#end()
filetype plugin indent on

" FZF
set rtp+=/usr/local/Cellar/fzf/0.9.4-1
set rtp+=/usr/local/Cellar/fzf/0.9.3
set rtp+=~/.fzf
nnoremap <C-p> :FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -l --ignore=node_modules --ignore=ansible-playbooks'

" Todo
set rtp+=~/.vimrc/plugin

" Flake8
" autocmd BufWritePost *.py call Flake8()
" let g:flake8_show_quickfix=0
" let g:flake8_show_in_gutter=0
" let g:flake8_show_in_file=1
let g:PyFlakeSigns = 1
let g:PyFlakeCWindow = 0

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
set relativenumber

map <F4> :MRU<CR>
nmap <F6> :Gblame<CR>
nnoremap <F5> :set relativenumber!<cr>
nmap <F8> :noh<CR>

" Disable arrow keys
function! DisableArrows()
    map <Left> <Nop>
    map <Right> <Nop>
    map <Up> <Nop>
    map <Down> <Nop>
endfunction
command! DisableArrows call DisableArrows()

function! EnableArrows()
    map <Left> <Left>
    map <Right> <Right>
    map <Up> <Up>
    map <Down> <Down>
endfunction
command! EnableArrows call EnableArrows()

call DisableArrows()

" search settings
set hlsearch
set incsearch
highlight Search  ctermfg=Black ctermbg=darkblue cterm=NONE

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
let g:airline_mode_map = { '__' : '-', 'n'  : 'λ', 'i'  : 'I', 'R'  : 'R', 'c'  : 'C', 'v'  : 'V', 'V'  : 'V', '' : 'V', 's'  : 'S', 'S'  : 'S', '' : 'S', }

" html
" Plugin 'gregsexton/MatchTag'
Plugin 'wikitopian/hardmode'
" Plugin 'kbarrette/mediummode'
let g:mediummode_enabled = 1
let g:mediummode_allowed_character_motions = 5
" Plugin '0x0dea/vim-molasses'
let g:molasses_wait=500

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


" for easier split navigation
nnoremap <SPACE>  <C-w>

" TODO: I need better python movements
" Python movements
" Previous/next function
" map } / *def <cr> :noh <CR>
" map { ? *def <cr> :noh <CR>

" LEADER MAPPINGS
let mapleader = "\<tab>"
nmap \ <tab>
" Show content of registers
nnoremap <LEADER>r :reg <CR>
" Fold unfold
" nnoremap <LEADER>a za
" No idea
nnoremap <LEADER>` I`<ESC>A`<ESC>^
" for procurement
nnoremap <LEADER><LEADER>b :!DEV_ENV=1 ./run.sh unittests run-contexts src --verbose <CR>
" for constantly mistyping :w
:command W w
" For using . in visual mode
vnoremap . :norm.<CR>
" Ack word under cursor
noremap <Leader>a :Ack <cword><cr>
" Jump to previous def
noremap <Leader>d ?^ *def<cr>w
" Replace word last searched for
noremap <Leader>r :%s//

" Startify
let g:startify_custom_header = map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['','']
let g:startify_change_to_dir = 0

" Markdown
let g:vim_markdown_folding_disabled=1
autocmd FileType mkd normal zR
autocmd FileType mkd.markdown normal zR

let g:mediummode_allowed_motions = 5

" Plugin 'maxbrunsfeld/vim-yankstack'
" nmap <leader>p <Plug>yankstack_substitute_older_paste
" nmap <leader>P <Plug>yankstack_substitute_newer_paste

"Rainbow parantheses
Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" Javascript sources
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2

" Comments
" visual select + gc
Plugin 'tomtom/tcomment_vim'

" Plugin 'wookiehangover/jshint.vim'
" let JSHintUpdateWriteOnly=1
" let g:JSHintUpdateWriteOnly=1


" Save buffer automatically when changing files
set autowrite

let g:EasyMotion_leader_key = '<leader>'

" Insert ticks around word
map tt ysiw'
map `` ysiw`
map "" ysiw"
map TT ebi{'<ESC>ea'}<ESC>


"""""""""""""""""""""""
""""""Haskell""""""""""
"""""""""""""""""""""""
" http://www.stephendiehl.com/posts/vim_2016.html
Plugin 'Shougo/vimproc.vim'
Plugin 'eagletmt/ghcmod-vim'
" Syntax checking for haskell
" do this first: stack install hdevtools
" :Errors shows the location window with a list of errors
" :lnext cycles through the errors
Plugin 'scrooloose/syntastic'
map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>
autocmd FileType haskell echom " tw :GhcModTypeInsert ts :GhcModSplitFunCase tq :GhcModType te :GhcModTypeClear"

nnoremap <F9> :lnext <cr>
nnoremap <F10> :lnext <cr>
" HS import
" stack install hsimport
" may need to add this to extra deps ilist-0.2.0.0
" hsimport needs to be on path
" export PATH=/Users/endregalaczi/.local/bin:$PATH
Plugin 'dan-t/vim-hsimport'
autocmd FileType haskell nmap <silent> <F1> :silent update <bar> HsimportModule<CR>
autocmd FileType haskell nmap <silent> <F2> :silent update <bar> HsimportSymbol<CR>

command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'
