"This must be first, because it changes other options as a side effect.
set encoding=utf-8

filetype off

if filereadable(expand("~/.vim/vimrc.bundles"))
  source ~/.vim/vimrc.bundles
" https://raw.githubusercontent.com/thoughtbot/dotfiles/master/vimrc.bundles

if &compatible
  set nocompatible
end

" Remove declared plugins
function! s:UnPlug(plug_name)
  if has_key(g:plugs, a:plug_name)
    call remove(g:plugs, a:plug_name)
  endif
endfunction
command!  -nargs=1 UnPlug call s:UnPlug(<args>)

let g:has_async = v:version >= 800 || has('nvim')

call plug#begin('~/.vim/bundle')

" Define bundles via Github repos
Plug 'christoomey/vim-run-interactive'

if g:has_async

" display stuff
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
"Plug 'tpope/vim-commentary'

" navigation and searching
Plug 'preservim/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'rking/ag.vim'
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'henrik/vim-indexed-search'
"Plug 'easymotion/vim-easymotion'
"Plug 'tpope/vim-fugitive'
Plug 'Shougo/vimshell'

" language and framework
Plug 'dense-analysis/ale'
"Plug 'posva/vim-vue'
"Plug 'vim-syntastic/syntastic'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'sebdah/vim-delve'
"Plug 'avakhov/vim-yaml'
Plug 'chase/vim-ansible-yaml'
"Plug 'vim-scripts/bash-support.vim'
"Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'vim-scripts/paredit.vim'
"Plug 'guns/vim-clojure-static'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tpope/vim-cucumber'
"Plug 'mutewinter/nginx.vim'
Plug 'tpope/vim-markdown'
""Plug 'ngmy/vim-rubocop'
"Plug 'tpope/vim-rails'
"Plug 'vim-ruby/vim-ruby'
"Plug 'stamblerre/gocode', {'rtp': 'nvim/'}
"
" multipliers (most/all file types)
Plug 'Shougo/deoplete.nvim', {'do':':UpdateRemotePlugins'}
Plug 'visualfc/gocode'
"Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'  " Default snippets for many languages
Plug 'tpope/vim-surround'
"Plug 'ervandew/supertab'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/tComment'
"Plug 'junegunn/fzf'

if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

call plug#end()

endif " g:has_async
endif " if filereadable(expand("~/.vim/vimrc.bundles"))

" GUI options (test)
if has("gui_running")
    set guioptions-=T
    set guioptions-=r
    set guioptions-=R
    set guioptions-=m
    set guioptions-=l
    set guioptions-=L
    set guitablabel=%t
endif

set showtabline=2
set formatoptions+=j
set nomodeline

" folding config
"set foldmethod=syntax
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
"  set term=gnome-256color
endif
set title
colorscheme desert

" snippets settings - https://github.com/Shougo/neosnippet.vim
let g:neosnippet#enable_snipmate_compatibility = 1
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" visual region select
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

filetype plugin indent on
syntax on
filetype plugin on

" Improve vim's scrolling speed
set ttyfast
set lazyredraw

if has('nvim')
  " no mouse
  set mouse-=a
  " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  "call deoplete#enable()
else
  set ttyscroll=3

  " use chunked diff, not char diff
  "set diffopt+=algorithm:patience
endif

set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab
set number
set relativenumber
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
"set listchars=tab:▸\ ,trail:▫,eol:¬,nbsp:_,extends:❯,precedes:❮

" navigate quickfix list
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>

" golang settings
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" use go library server (experimental)
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

au FileType go nmap <F12> <Plug>(go-def)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go setlocal listchars=tab:\|\ 
" autocmd FileType go call sacp#enableForThisBuffer({ "matches": [
"       \ { '=~': '\v[a-zA-Z]{4}$' , 'feedkeys': "\<C-x>\<C-n>"} ,
"       \ { '=~': '\.$'            , 'feedkeys': "\<C-x>\<C-o>", "ignoreCompletionMode":1} ,
"       \ ]
" \ })
let g:go_fmt_command = "goimports"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_deadline = "12s"
let g:go_addtags_transform = "snakecase"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1

" go snippet config
let g:go_snippet_engine = "neosnippet"

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

" swapfiles are lame. we have git
set noswapfile
set nobackup
set nowb

" " ================ Persistent Undo ==================
" " Keep undo history across sessions, by storing in file.
" " Only works all the time.
" silent !mkdir ~/.vim/backups > /dev/null 2>&1
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

" gitgutter bg color matches line numbers
highlight clear SignColumn

" wrap git commits at column 72 and check spelling
autocmd Filetype gitcommit setlocal spell textwidth=72

" Leader commands
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
map <Leader>ra :%s/

" reselect visual block after indent/outdent
noremap < <gv
noremap > >gv

" two leaders to previous buffer
nnoremap <leader><leader> :b#<cr>

" function OpenNERDTree()
"   execute ":NERDTree"
" endfunction
"
" command -nargs=0 OpenNERDTree :call OpenNERDTree()
"
" nmap <ESC>t :OpenNERDTree<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" use ctrl-p fuzzy finder (plugin)
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

autocmd User Rails let  g:fuzzy_roots = [RailsRoot()]

au BufRead,BufNewFile *.bldr set filetype=ruby
au BufWritePost .vimrc so $MYVIMRC
"au BufNewFile,BufRead *.json setf javascript

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
autocmd BufWritePre *.rb,*.go,*.css,*.php,*.c,*.h,*.ino,*.cpp :call <SID>StripTrailingWhitespaces()

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" spell check stuff
autocmd BufRead,BufNewFile *.md,*.markdown,*.txt setlocal spell
"autocmd FileType text setlocal spell
set complete+=kspell
map <F5> :setlocal spell! spelllang=en_us<CR>

" Tab completion
set wildmode=list:longest,list:full  
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*  

" zeal doc tool
:nnoremap gz :!zeal --query "<cword>"&<CR><CR>

" Let :w!! gain sudo privileges without closing and reopening vim
cmap w!! w !sudo tee % >/dev/null

" Quick cycling between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

