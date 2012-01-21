" This must be first, because it changes other options as side effect
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" Plugins managed by Vundle
"
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/ZoomWin'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'vim-scripts/pep8'
Bundle 'kevinw/pyflakes-vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Lokaltog/vim-powerline'


"non github
Bundle 'git://git.wincent.com/command-t.git'



filetype plugin indent on

" change the mapleader from \ to ,
let mapleader=","
imap jj <Esc> " Professor VIM says '87% of users prefer jj over esc', jj abrams disagrees

set hidden        " hide buffers instead of closing them
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set expandtab     " convert tab to white space
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
" Work-around incomplete terminfo databases                                     
" " Particulalry useful when under `screen`, which may or may not be attached
" to  
" " a physical terminal capable of 256color mode.                                 
"if match($TERMCAP, 'Co#256:') == 0 || match($TERMCAP, ':Co#256:') > 0           
     set t_Co=256                                                                
"endif

"set colorcolumn=80
colorscheme my-lucius


set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window

"don't like dealing with swp files
set nobackup
set noswapfile

set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" Show the current command in the lower right corner
set showcmd
"
" " Show the current mode
set showmode
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set shiftround              " rounds indent to a multiple of shiftwidth
set laststatus=2            " Always show statusline, even if only 1 window.

"For PowerLine glyphs
set encoding=utf-8


"set statusline=%<%f\ (%{&ft})%=%-19(%3l,%02c%03V%)%{fugitive#statusline()}


set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default
" Vertical and horizontal split then hop to a new buffer
:noremap <Leader>v :vsp^M^W^W<cr>
:noremap <Leader>h :split^M^W^W<cr>

" Windows
" *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow 

"easier switching between windows
map <C-J> <C-W>j
map <C-H> <C-W>h
map <C-L> <C-W>l
map <C-K> <C-W>k

"Insert New Line *************************************************************
map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
map <Enter> o<ESC>
"set fo-=r " do not insert a comment leader after an enter, (no work, fix!!)


" Sessions ********************************************************************
" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize


" Invisible characters *********************************************************
set listchars=trail:.,tab:>-,eol:$
set nolist
:noremap <Leader>i :set list!<CR> " Toggle invisible chars

" Switch on syntax highlighting.
syntax on

" Disable the colorcolumn when switching modes.  Make sure this is the
" first autocmd for the filetype here
" This colorcolumn handling isn't working perfectly. For example
" the command-t window will use the column if opened from within a 
" Python buffer
autocmd FileType * setlocal colorcolumn=0

" Python stuff
" ****************************************************************
"
"

autocmd FileType python setlocal colorcolumn=79

" Run pep8 shortcut
let g:pep8_map='<leader>8'

" Trailing space removal on save
function! StripTrailingSpaces()
    let l = line(".")
    let c = col(".")
    silent! execute '%s/\s\+$//e'
    call cursor(l, c)
endfunction
au BufWritePre *.py :call StripTrailingSpaces()



" close scratch preview automatically
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" -----------------------------------------------------------------------------  
"
"  " NERDTree
"  ********************************************************************
":noremap <Leader>n :NERDTreeToggle<CR>

" NERD Commenter **************************************************************
"let NERDCreateDefaultMappings=0 " I turn this off to make it simple

" Toggle Tags List
"nmap <leader>m :Tlist<CR>

" Toggle commenting on 1 line or all selected lines. Wether to comment or not
" is decided based on the first line; if it's not commented then all lines
" will be commented
:map <Leader>c :call NERDComment(0, "toggle")<CR> 



"Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
"shortcut. Don't open first result
nmap <leader>a <Esc>:Ack!


"-----------------------------------------------------------------------------  
"                                Startup
"
"----------------------------------------------------------------------------  
" Open NERDTree on start
"autocmd VimEnter * exe 'NERDTree' | wincmd l 


"----------------------------------------------------------------------------  
"                                Host specific
"
"----------------------------------------------------------------------------  
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
