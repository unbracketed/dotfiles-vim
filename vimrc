" This must be first, because it changes other options as side effect
set nocompatible

filetype off
call pathogen#runtime_append_all_bundles()
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
colorscheme mustang
"also liked:
" relaxedgreen, neverness, impact, dante, adaryn, vividchalk, wuye
"

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

autocmd BufRead,BufNewFile *.py syntax on
autocmd BufRead,BufNewFile *.py set ai
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,with,try,except,finally,def,class

" Python stuff
" ****************************************************************
"
" activate virtualenv in vim python
if($VIRTUAL_ENV)
    :python activate_this = '$VIRTUAL_ENV/bin/activate_this.py'
    :python execfile(activate_this, dict(__file__=activate_this))
endif

"load any vim customizations for the virtualenv
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
end

autocmd FileType python compiler pylint


" Omni Completion *************************************************************
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
set completeopt+=longest
" close scratch preview automatically
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=RopeCompleteFunc
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
" May require ruby compiled in
"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete 

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" -----------------------------------------------------------------------------  
"
"  " NERDTree
"  ********************************************************************
:noremap <Leader>n :NERDTreeToggle<CR>

" NERD Commenter **************************************************************
let NERDCreateDefaultMappings=0 " I turn this off to make it simple

" Toggle commenting on 1 line or all selected lines. Wether to comment or not
" is decided based on the first line; if it's not commented then all lines
" will be commented
:map <Leader>c :call NERDComment(0, "toggle")<CR> 

" fugitive.vim
" ------------------------------
"rebind my favorite aliases for Fugitive
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>ga :Gwrite<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gd :Gdiff<cr>

"Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"-----------------------------------------------------------------------------  
"                                Startup
"
"
"----------------------------------------------------------------------------  
" Open NERDTree on start
"autocmd VimEnter * exe 'NERDTree' | wincmd l 




"----------------------------------------------------------------------------  
"                                Host specific
"
"
"----------------------------------------------------------------------------  
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
