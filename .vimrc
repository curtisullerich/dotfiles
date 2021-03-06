" vim-sublime - A minimal Sublime Text -like vim experience bundle
"               http://github.com/grigio/vim-sublime
" Best view with a 256 color terminal and Powerline fonts
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'
" Install Vundle (clone the git repo to ~/.vim/bundle/vundle), open vim, run :PluginInstall
Plugin 'tpope/vim-surround'
Plugin 'gcmt/breeze.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'tomtom/tcomment_vim'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/lh-brackets'

" Color Themes
Plugin 'flazz/vim-colorschemes'
colorscheme monokai
" colorscheme earth
" Plugin 'vim-scripts/Conque-GDB' disabled 2018-02-20 because this took 1s on vim startup
Plugin 'tpope/vim-abolish'
Plugin 'vim-scripts/ConvertBase.vim'
Plugin 'sheerun/vim-polyglot'  " syntax highlighting for many languages.
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'Raimondi/delimitMate'

" Translate the character under the cursor to a decimal value:
nmap <M-a>d i<C-R>=char2nr(getline(line("."))[col(".") - 1])<CR><ESC>lx
" ... hexadecimal value:
nmap <M-a>h ix<C-R>=ConvertToBase(char2nr(getline(line("."))[col(".") - 1]),16)<CR><ESC>lx
" ... octal value:
nmap <M-a>o i<C-R>=ConvertToBase(char2nr(getline(line("."))[col(".") - 1]),8)<CR><ESC>lx

nmap <c-j> Jdf/dl


""""""""
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.
set autoindent
set backspace=indent,eol,start
set complete-=i
set showmatch
set showmode
set smarttab

set nrformats-=octal
set shiftround

set ttimeout
set ttimeoutlen=50

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set ruler
set showcmd
set wildmenu

set autoread

set encoding=utf-8
set tabstop=2 shiftwidth=2 expandtab
set listchars=tab:▒░,trail:▓
set list

inoremap <C-U> <C-G>u<C-U>

set number
set hlsearch
set ignorecase
set smartcase

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" do not history when leavy buffer
set hidden

" FIXME: (broken) ctrl s to save
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <Esc>:update<CR>

set nobackup
set nowritebackup
set noswapfile
set fileformats=unix,dos,mac

" exit insert mode 
inoremap <C-c> <Esc>

set completeopt=menuone,longest,preview

"
" Plugins config
"

" CtrlP
set wildignore+=*/.git/*,*/.hg/*,*/.svn/* 

" Ultisnip
" NOTE: <f1> otherwise it overrides <tab> forever
let g:UltiSnipsExpandTrigger="<f1>"
let g:UltiSnipsJumpForwardTrigger="<f1>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:did_UltiSnips_vim_after = 1

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#disable_rtp_load = 1 " to speed up startup

"
" Basic shortcuts definitions
"  most in visual mode / selection (v or ⇧ v)
"

" Find
map <C-f> /
" indend / deindent after selecting the text with (⇧ v), (.) to repeat.
vnoremap <Tab> >
vnoremap <S-Tab> <
" comment / decomment & normal comment behavior
vmap <C-m> gc
" Disable tComment to escape some entities
let g:tcomment#replacements_xml={}
" Text wrap simpler, then type the open tag or ',"
vmap <C-w> S
" Cut, Paste, Copy
"vmap <C-x> d
"vmap <C-v> p
"vmap <C-c> y
" Undo, Redo (broken)
nnoremap <C-z>  :undo<CR>
inoremap <C-z>  <Esc>:undo<CR>
nnoremap <C-y>  :redo<CR>
inoremap <C-y>  <Esc>:redo<CR>
" Tabs
" let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1
nnoremap <C-b>  :tabprevious<CR>
inoremap <C-b>  <Esc>:tabprevious<CR>i
nnoremap <C-n>  :tabnext<CR>
inoremap <C-n>  <Esc>:tabnext<CR>i
nnoremap <C-t>  :tabnew<CR>
inoremap <C-t>  <Esc>:tabnew<CR>i
nnoremap <C-k>  :tabclose<CR>
inoremap <C-k>  <Esc>:tabclose<CR>i

" go to the next and previous buffer. analagous to gt for next tab.
noremap gb :bn<CR>
noremap gB :bp<CR>

" find/replace current symbol with \s
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" lazy ':'
map \ :

let mapleader = ','
" nnoremap <Leader>p :set paste<CR>
" nnoremap <Leader>o :set nopaste<CR>
noremap  <Leader>g :GitGutterToggle<CR>

" From vimrc.bak
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases 
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch 
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%
set rnu

set cursorline

" this machine config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

hi Search ctermbg=LightBlue

if filereadable(expand("~/.vimrc.google"))
  source ~/.vimrc.google
endif

set paste
set tabstop=2
set autoindent
