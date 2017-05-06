"  /===================================================\
"  | Vimfiles by Nelio Carneiro                     |
"  | - http://twitter.com/neliojrr                    |
"  | Many tricks were stolen from Salviano Ludgerio  |
"  | - http://github.com/salvianoo                  |
"  \===================================================/

" Preamble ----------------------------------------------------------------- {{{
set nocompatible                " no legacy vi

" Vundle setup
"filetype off
"set rtp+=~/.vim/bundle/vundle
"call vundle#rc()

call plug#begin('~/.vim/bundle')

Plug 'othree/yajs.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/oceanic-next'
Plug 'cakebaker/scss-syntax.vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/timl'
Plug 'tomtom/tcomment_vim'

"Plug 'garbas/vim-snipmate'
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'

Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-ragtag'

Plug 'sjl/vitality.vim'
Plug 'sjl/tslime2.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'mileszs/ack.vim'

Plug 'mxw/vim-jsx'
Plug 'digitaltoad/vim-pug'
Plug 'epilande/vim-react-snippets'
Plug 'SirVer/ultisnips'

call plug#end()

" // Clojure specific bundles
" Bundle 'guns/vim-clojure-static'
" Bundle 'tpope/vim-fireplace'
" Bundle 'tpope/vim-classpath'

" filetype plugin indent on     "required by Vundle

"}}}
" Basic Options ------------------------------------------------------------ {{{
set encoding=utf-8
set noswapfile
set modelines=0                 " security fix
set hidden                      " allow switching edited buffers without saving
set history=100
set number
set ruler                       " show the cursor position all
set ttyfast
set showcmd                     " show current mode down the bottom
set autoindent                  " automatic indent new lines
set nofoldenable
set shell=/bin/zsh
set laststatus=2                " always show the status line
set visualbell                  " stop annoying bells
set cursorline                  " highlight cursor line
set list
" set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set listchars=tab:▸\ ,extends:❯,precedes:❮
set scrolloff=3
set backspace=indent,eol,start  " backspace though everthing in insert mode
set splitbelow

" Makes terminal Vim work sanely
set notimeout
set ttimeout
set ttimeoutlen=50

" Set mvim screen size
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window (for an alternative on Windows, see simalt below).
  set lines=999 columns=999
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=100
  endif
endif

" Better Completion
set completeopt=menu,preview,longest

" Resize split when the window is resized
au VimResized * exe "normal! \<c-w>="

" CursorLine {{{
" Only show cursorline in the current window and in normal mode

augroup cline
  au!
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline
augroup END

" }}}
" Wildmenu Completion {{{

set wildmenu                        " enable ctrl-n and ctrl-p to scroll thur matches
set wildmode=list:longest

set wildignore+=.git                              " Version control
set wildignore+=*.aux,*.out,*.toc                 " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg    " binary images "
set wildignore+=*.DS_Store                        " OSX bullshit
set wildignore+=node_modules
set wildignore+=bower_components
set wildignore+=*/tmp/*

set wildignore+=*.pyc                             " Python bytecode

set wildignore+=*.class                           " Java bytecode

" Clojure/Leiningen
" set wildignore+=classes
" set wildignore+=lib

" }}}
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit and Steve Losh for this tip
augroup line_return
  au!
  au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \     execute 'normal! g`"zvzz' |
      \ endif
augroup END

" }}}
" Tabs, spaces, wrapping {{{

filetype plugin indent on
set shiftwidth=2
set tabstop=2                   " yep, two
set expandtab                   " use spaces, not tabs
set nowrap                      " do not wrap lines
set textwidth=80
set formatoptions=qrn1
set colorcolumn=+1              " this will highlight column 80

" }}}
" Leader {{{

" Use comma as <leader> key instead of backslash
let mapleader = "\\"
let maplocalleader = "\\"

" }}}
" Color scheme {{{

syntax on
set background=dark
" set guifont=Ubuntu\ Mono\ derivative\ Powerline:h16
" set guifont=Meslo\ LG\ M\ for\ Powerline:h28
set guifont=Monaco:h16

" Reload the colorscheme whenever we write the file
augroup color_colonoscopy_dev
  au!
  au BufWritePost colonoscopy.vim color colonoscopy
augroup END

" }}}

" }}}
" Convenience mappings ----------------------------------------------------- {{{

" Space is so much easier than :
" noremap ; :

" inoremap jj <esc>

noremap vv ^vg_

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Emacs binding in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Substitute
noremap <leader>s :%s//<left>

"make <c-l> clear the highlight as well as redraw
nnoremap <leader><space> :nohls<cr>

" Map hashrocket as textmate
" imap <c-l> <space>=><space>
vnoremap <c-l> :!python

"I like that
nnoremap <localleader>= ==
vnoremap - =

" normal mode
" nnoremap <tab> %
" visual mode
" vnoremap <tab> %

" Using UtilSnips with tab
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" React syntax highlighting for .js
let g:jsx_ext_required = 0

" HTML tag closing
inoremap <C-e> <Space><BS><Esc>:call InsertCloseTag()<cr>a

" not sure to use this
" inoremap <c-space> <c-x><c-u>

" As see on vimcast about edit command
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%

" Expanded to directory of current file in command mode
" http://vimcasts.org/e/14
cnoremap %% <c-r>=expand('%:h').'/'<cr>

" Get off my lawn
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

" Send visual selection to gist.github.com as a private, filetyped Gist
" Requires the gist command line too (brew install gist)
vnoremap <leader>G :w !gist -t %:e \| pbcopy<cr>
vnoremap <leader>UG :w !gist -p \| pbcopy<cr>

" }}}
" Quick Editing ------------------------------------------------------------ {{{

noremap <leader>ev <C-w>v<C-w>j:e ~/.vim/vimrc<cr>
noremap <leader>et <C-w>v<C-w>j:e ~/.tmux.conf<cr>
noremap <leader>eb <C-w>v<C-w>j:e ~/.zshrc<cr>

" }}}
" Searching and movement --------------------------------------------------- {{{

set ignorecase                  " ignore case when searching...
set smartcase                   " only if they contain at least one capital letter
set incsearch                   " do incremental searching
set showmatch
set hlsearch                    " highlight matches
set gdefault

"Keep search matches in the middle of the window and pulse the line when moving
"to them.
nnoremap n nzzzv
nnoremap N Nzzzv

" Easier navigation betwen split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"it's 2012"
noremap j gj
noremap k gk

" Switch between the currently open buffer and the previous one
nnoremap <leader><leader> <c-^>

" Window rezising
" nnoremap <c-a> 4<c-w>>
" nnoremap <c-e> 4<c-w><

" Easily move to start/end of line:
" noremap <c-a> ^
noremap <c-e> g_

"}}}
" Folding -------------------------------------------------------------------{{{

set foldlevelstart=0
set foldmethod=marker

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

nnoremap zO zCzO

function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3

    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let livpjune = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . "…" . ' '
endfunction
set foldtext=MyFoldText()

" }}}
" Filetype-specific -------------------------------------------------------- {{{

" Golang {{{
augroup ft_go
  set ft=go
augroup END
" }}}
" Ruby {{{
augroup ft_ruby
  au!
  au Filetype ruby setlocal ts=2 sts=2 sw=2 expandtab
  " au FileType ruby setlocal imap <c-l> <space>=><space>
augroup END
" }}}
" Javascript {{{
augroup ft_javascript
  au!

  au Filetype javascript setlocal foldmethod=marker
  au Filetype javascript setlocal ts=2 sts=2 sw=2 expandtab

  au FileType javascript inoremap <buffer> {<cr> {}<left><cr><space><space>.<cr><esc>kA<bs>
augroup END
" }}}
" Python {{{
augroup ft_python
  au!

  au FileType python setlocal define=^\s*\\(def\\\\|class\\)
  au FileType man nnoremap <buffer> <cr> :q<cr>

  au Filetype python setlocal ts=2 sts=2 sw=2 expandtab
  au BufNewFile,BufRead *.py compiler nose
augroup END
"}}}
" Django {{{

augroup ft_django
  au!

  au BufNewFile,BufRead urls.py   setlocal nowrap
  au BufNewFile,BufRead urls.py   normal! zR
augroup END

"}}}
" CSS, SCSS and Less {{{

augroup ft_css
  au!

  au BufNewFile,BufRead *.less setlocal filetype=less
  au BufNewFile,BufRead *.scss setlocal filetype=scss

  au FileType css,scss,less setlocal foldmethod=marker
  au FileType css,scss,less setlocal foldmarker={,}
  au Filetype css,scss,less set omnifunc=csscomplete#CompleteCSS
  " search wtf this line do
  au FileType css,scss,less setlocal iskeyword+=-

  " Use <localleader>v to sort properties. Turns this:

  "     p {
  "         width: 200px;
  "         height: 100px;
  "         background: red;

  "         ...
  "     }
  "
  "into this:
  "
  "     p {
  "         background: red;
  "         height: 100px;
  "         width: 200px;
  "
  "
  "         ...
  "     }
  au FileType *.css,*.scss,*.less noremap <buffer> <localleader>v ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

  " Make {<cr> insert a pair of brackets in such a way that the cursor is
  " correctly positioned inside of them AND the following code doesn't get
  " unfolded.
  au FileType *.css,*.scss,*.less inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>

augroup END

" }}}
" Lisp {{{
augroup ft_lisp
  au!
  au FileType lisp call TurnOnLispFolding()
augroup END
" }}}
" C {{{
augroup ft_c
  au Filetype c setlocal ts=2 sts=2 sw=2 expandtab
  au Filetype c setlocal foldmethod=marker
  au Filetype c setlocal foldmarker={,}
augroup END
" }}}
" Java {{{
augroup ft_java
  au Filetype java setlocal ts=2 sts=2 sw=2 expandtab
augroup END
" }}}
" C++ {{{
augroup ft_cpp
  au Filetype cpp setlocal ts=2 sts=2 sw=2 expandtab
  au Filetype cpp setlocal foldmethod=marker
  au Filetype cpp setlocal foldmarker={,}
augroup END
" }}}
" Guard {{{
augroup ft_guard
  au!
  au BufRead,BufNewFile Guardfile set ft=ruby
augroup END
" }}}
" Vagrant {{{
augroup ft_vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set ft=ruby
augroup END
" }}}
" Puppet {{{
augroup ft_puppet
  au!

  au Filetype puppet setlocal foldmethod=marker
  au FileType puppet setlocal foldmarker={,}
  au Filetype puppet setlocal ts=4 sts=4 sw=4 expandtab
augroup END
" }}}
" Nginx {{{
augroup ft_nginx
  au!

  au FileType nginx setlocal foldmethod=marker
  au FileType nginx setlocal foldmarker={,}
  au Filetype nginx setlocal ts=4 sts=4 sw=4 expandtab
augroup END
" }}}
" Vim {{{
augroup ft_vim
  au!

  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
" }}}
" Treetop-files {{{

set runtimepath+=~/.vim/plugin/treetop.vim

"}}}
" Others Files {{{

if has("autocmd")
  filetype on                       " file type detection
  filetype plugin indent on
  " set ofu=syntaxcomplete#Complete

  " styles depending on file type
  au filetype html set omnifunc=htmlcomplete#CompleteTags

  autocmd BufWritePre *.js,*.py,*.yml,*.rb,*.html,*.css,*.scss,*.erb,*.haml :call <sid>StripTrailingWhitespaces()
endif

"}}}

" }}}
" Plugins settings --------------------------------------------------------- {{{

" Ack {{{

noremap <leader>a :Ack

"}}}
" Emmet {{{

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" }}}
" NERDTree {{{

" let NERDTreeHighlightCursorline=1
" let NERDTreeIgnore = ['bower_components', 'node_modules', '.*\pyc$', '.*\jpg$', '.*\pdf$']
"
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1
" let NERDChristmasTree = 1
" let NERDTreeChDirMode = 2
"
" au FileType nerdtree setlocal nolist
map <leader>p :NERDTreeToggle<cr>

" }}}
" Ctrl-P {{{

" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_map = '<leader>,'
noremap <c-o> :CtrlPBuffer<cr>

let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20
" let g:ctrlp_extensions = ['tag']
"
let g:ctrlp_prompt_mappings = {
      \ 'PrtSelectMove("j")':   ['<c-j>', '<down>', '<s-tab>'],
      \ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
      \ 'PrtHistory("-1")':     ['<c-n>'],
      \ 'PrtHistory("1")':      ['<c-p>'],
      \ 'ToggleFocus()':        ['<c-tab>'],
      \ }

" let ctrlp_filter_greps = "" .
"       \ "egrep -iv '\\.(" .
"       \ "jar|class|swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
"       \ ")$' | " .
"       \ "egrep -v '^(\\./)?(" .
"       \ "deploy/|lib/|classes/|libs/|deploy/vendor/|.git/|.hg/|.svn/|.*migrations/" .
"       \ ")'"
"
" let my_ctrlp_user_command = "" .
"       \ "find %s '(' -type f ')' -maxdepth 15 -not -path '*/\\.*/*' | " .
"       \ ctrlp_filter_greps
"
" let my_ctrlp_git_command = "" .
"       \ "cd %s && git ls-files | " .
"       \ ctrlp_filter_greps
"
" let g:ctrlp_user_command = ['.git/', my_ctrlp_git_command, my_ctrlp_user_command]

nnoremap <leader>. :CtrlPTag<cr>
" Alterar path do ctags com homebrew
nnoremap <leader><cr> :silent !/usr/local/Cellar/ctags/5.8/bin/ctags -R . tags<cr>:redraw!<cr>

" }}}
" Fugitive {{{

noremap <leader>gs :Gstatus<cr>

augroup ft_fugitive
  au!
  au BufNewFile,BufRead .git/index setlocal nolist
augroup END

" }}}
" tSlime {{{

let g:tslime_ensure_trailing_newlines = 1
let g:tslime_normal_mapping = '<localleader>t'
let g:tslime_visual_mapping = '<localleader>t'
let g:tslime_vars_mapping = '<localleader>T'

"}}}
" Syntastic {{{

let g:syntastic_enable_signs = 1
let g:syntastic_check_on_open = 1
let g:syntastic_disabled_filetypes = ['html', 'rst']
let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
let g:syntastic_sjl_conf = '$HOME/.vim/jsl.conf'
let g:syntastic_ruby_exec = '~/.rbenv/versions/2.1.0/bin/ruby'
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" let g:syntastic_java_javac_classpath = "/Users/salvianoo/Desktop/java-proj/build/classes/main/hello"

"}}}
" tComment {{{
map <leader>c <c-_><c-_>
" }}}
" StripTrailingWhitespaces {{{

nnoremap <leader>W :call <sid>StripTrailingWhitespaces()<cr>

function! <sid>StripTrailingWhitespaces()
  " preparation save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
"}}}

" }}}
" Environments (GUI/Console) ----------------------------------------------- {{{

" Theme
syntax enable

" for vim 8
if (has("termguicolors"))
  set termguicolors
endif


if has('gui_running')
  "colorscheme solarized
  colorscheme OceanicNext
  " Airline
  let g:airline_powerline_fonts = 1
  "let g:airline_theme = 'solarized'

  " Remove all the UI cruft
  " go is same of guioptions
  set go-=T
  set go-=l
  set go-=L
  set go-=r
  set go-=R

  " set fuoptions=maxvert,maxhorz
  " set fullscreen

else " console vim
  "colorscheme solarized
  colorscheme OceanicNext
  "let g:airline_theme = 'solarized'
  let g:tmuxline_powerline_separators = 0

  set mouse=a " mouse support
  set t_Co=256
endif

" }}}

" I'm tough guy
" noremap h <NOP>
" noremap j <NOP>
" noremap k <NOP>
" noremap l <NOP>
