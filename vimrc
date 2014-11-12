"Use Vim settings, rather than Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" display stuff
Plugin  'bling/vim-airline'
Plugin  'airblade/vim-gitgutter'
Plugin  'tsaleh/vim-align'
Plugin  'tpope/vim-commentary'
Plugin  'Raimondi/delimitMate'

" navigation and searching
Plugin  'scrooloose/nerdtree'
Plugin  'christoomey/vim-tmux-navigator'
Plugin  'kien/ctrlp.vim'
Plugin  'tpope/vim-vividchalk'

" language and framework
Plugin  'fatih/vim-go'
Plugin  'rking/ag.vim'
Plugin  'moll/vim-node'
"Plugin  'vim-scripts/bash-support.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin  'mxw/vim-jsx'
Plugin  'tpope/vim-surround'
Plugin  'vim-scripts/paredit.vim'
Plugin  'guns/vim-clojure-static'
Plugin  'tomtom/tlib_vim'
Plugin  'MarcWeber/vim-addon-mw-utils'
Plugin  'garbas/vim-snipmate'
Plugin  'honza/vim-snippets'
Plugin  'tpope/vim-cucumber'
Plugin  'tpope/vim-haml'
Plugin  'slim-template/vim-slim'
Plugin  'mutewinter/nginx.vim'
Plugin  'tpope/vim-markdown'
"Plugin  'ngmy/vim-rubocop'
Plugin  'tpope/vim-rails'
Plugin  'vim-ruby/vim-ruby'
call vundle#end()

set showtabline=2

"if $COLORTERM == 'gnome-terminal'
  set t_Co=256
"endif
:colorscheme desert

let g:snippets_dir="~/.vim/bundle/snipmate-snippets/"

filetype plugin indent on
syntax on
filetype plugin on

set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set nu
set history=50  " keep 50 lines of command line history
set ruler  " show the cursor position all the time
set showcmd  " display incomplete commands
set laststatus=2
set shortmess=atI

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set ignorecase  " case insensitive search
set smartcase   " If a capital letter is included in search, make it case-sensitive

set complete=.,t
set autoread

set list   " show trailing whitespace
set listchars=tab:▸\ ,trail:▫

" swapfiles are lame. we have git
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=235 ctermbg=2
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=12
endif

" use airline symbols for pretty status line
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" crosshairs cursor - annoying or fantastic?
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn

" highlight just the 81st column of wide lines, for example, right here........> <
highlight ColorColumn ctermbg=235
call matchadd('ColorColumn', '\%81v', 100)

" gitgutter bg color matches line numbers
highlight clear SignColumn

" Leader commands
map <Leader>ac :sp app/controllers/application_controller.rb<cr>
map <Leader>bb :!bundle install<cr>
map <Leader>f :call OpenFactoryFile()<CR>
map <Leader>m :Rmodel 
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
map <Leader>ra :%s/
map <Leader>sc :sp db/schema.rb<cr>
map <Leader>sm :RSmodel 
map <Leader>su :RSunittest 
map <Leader>sv :RSview 
map <Leader>vc :RVcontroller<cr>
map <Leader>vf :RVfunctional<cr>
map <Leader>vm :RVmodel<cr>
map <Leader>vv :RVview<cr>

function OpenNERDTree()
  execute ":NERDTree"
endfunction
command -nargs=0 OpenNERDTree :call OpenNERDTree()

nmap <ESC>t :OpenNERDTree<CR>

" use ctrl-p fuzzy finder (plugin)
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'

autocmd User Rails let  g:fuzzy_roots = [RailsRoot()]

au BufRead,BufNewFile *.bldr set filetype=ruby

function! OpenFactoryFile()
  if filereadable("test/factories.rb")
    execute ":sp test/factories.rb"
  else
    execute ":sp spec/factories.rb"
  end
endfunction

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" autocmd BufWritePre *.rb,*.css,*.go,*.tpl,*.php :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.rb,*.go :call <SID>StripTrailingWhitespaces()

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" spell check stuff
autocmd BufRead,BufNewFile *.md,*.markdown setlocal spell
"autocmd FileType text setlocal spell
set complete+=kspell
map <F5> :setlocal spell! spelllang=en_us<CR>

" Quick cycling between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
