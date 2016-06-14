if $SHELL =~ 'fish'
  set shell=/bin/sh
endif
"===================================================================================
"         FILE:  .vimrc
"  DESCRIPTION:  suggestion for a personal configuration file ~/.vimrc
"       AUTHOR:  Dr.-Ing. Fritz Mehner
"      CREATED:  04.04.2009
"     REVISION:  $Id: customization.vimrc,v 1.6 2009/10/03 12:24:30 mehner Exp $
"===================================================================================
"
"===================================================================================
" GENERAL SETTINGS
"===================================================================================

"-------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
"-------------------------------------------------------------------------------
set nocompatible
set viminfo+=<1000
"
"-------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
"-------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
"
"-------------------------------------------------------------------------------
" Switch syntax highlighting on.
"-------------------------------------------------------------------------------
syntax    on
colorscheme pablo
"
" Platform specific items:
" - central backup directory (has to be created)
" - default dictionary
" Uncomment your choice.
if  has("win16") || has("win32")     || has("win64") ||
  \ has("win95") || has("win32unix")
    "
"    runtime mswin.vim
"    set backupdir =$VIM\vimfiles\backupdir
"    set dictionary=$VIM\vimfiles\wordlists/german.list
else
"    set backupdir =$HOME/.vim.backupdir
"    set dictionary=$HOME/.vim/wordlists/german.list
endif
"
" Using a backupdir under UNIX/Linux: you may want to include a line similar to
"   find  $HOME/.vim.backupdir -name "*" -type f -mtime +60 -exec rm -f {} \;
" in one of your shell startup files (e.g. $HOME/.profile)
"
"-------------------------------------------------------------------------------
" Various settings
"-------------------------------------------------------------------------------
set autoindent                  " copy indent from current line
set autoread                    " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set backspace=indent,eol,start  " backspacing over everything in insert mode
"set backup                      " keep a backup file
set browsedir=current           " which directory to use for the file browser
set complete+=k                 " scan the files given with the 'dictionary' option
set history=50                  " keep 50 lines of command line history
set hlsearch                    " highlight the last used search pattern
set incsearch                   " do incremental searching
set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
"set mouse=a                     " enable the use of the mouse
"set nowrap                      " do not wrap lines
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set t_Co=256
set cursorline
"hi CursorLine cterm=NONE ctermbg=lightyellow ctermfg=black guibg=lightyellow guifg=black
hi CursorLine cterm=NONE ctermbg=black guibg=black
hi ColorColumn ctermbg=black guibg=black
set shiftwidth=4                " number of spaces to use for each step of indent
set showcmd                     " display incomplete commands
"set smartindent                 " smart autoindenting when starting a new line
set tabstop=4                   " number of spaces that a <Tab> counts for
set visualbell                  " visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu                    " command-line completion in an enhanced mode
"
set enc=utf-8
set fileencodings=utf-8,ucs-bom,big5,cp950,default,latin1
"
"===================================================================================
" BUFFERS, WINDOWS
"===================================================================================
"
"-------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufEnter * :lchdir %:p:h
endif
"
"-------------------------------------------------------------------------------
" close window (conflicts with the KDE setting for calling the process manager)
"-------------------------------------------------------------------------------
 noremap  <C-Esc>       :close<CR>
inoremap  <C-Esc>  <C-C>:close<CR>
"
"-------------------------------------------------------------------------------
" Fast switching between buffers
" The current buffer will be saved before switching to the next one.
" Choose :bprevious or :bnext
"-------------------------------------------------------------------------------
 noremap  <silent> <s-tab>       :if &modifiable && !&readonly &&
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
inoremap  <silent> <s-tab>  <C-C>:if &modifiable && !&readonly &&
     \                      &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"
"-------------------------------------------------------------------------------
" Leave the editor with Ctrl-q (KDE): Write all changed buffers and exit Vim
"-------------------------------------------------------------------------------
nnoremap  <C-q>    :wqall<CR>
"
"-------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif " has("autocmd")
"
"-------------------------------------------------------------------------------
"  some additional hot keys
"-------------------------------------------------------------------------------
"    F2   -  write file without confirmation
"    F3   -  call file explorer Ex
"    F4   -  show tag under curser in the preview window (tagfile must exist!)
"    F5   -  open quickfix error window
"    F6   -  close quickfix error window
"    F7   -  display previous error
"    F8   -  display next error
"-------------------------------------------------------------------------------
"
map   <silent> <F2>        :write<CR>
map   <silent> <F3>        :Explore<CR>
nmap  <silent> <F4>        :exe ":ptag ".expand("<cword>")<CR>
map   <silent> <F5>        :copen<CR>
map   <silent> <F6>        :cclose<CR>
map   <silent> <F7>        :cp<CR>
map   <silent> <F8>        :cn<CR>
"
imap  <silent> <F2>   <Esc>:write<CR>
imap  <silent> <F3>   <Esc>:Explore<CR>
imap  <silent> <F4>   <Esc>:exe ":ptag ".expand("<cword>")<CR>
imap  <silent> <F5>   <Esc>:copen<CR>
imap  <silent> <F6>   <Esc>:cclose<CR>
imap  <silent> <F7>   <Esc>:cp<CR>
imap  <silent> <F8>   <Esc>:cn<CR>
"
"-------------------------------------------------------------------------------
" Fast switching between buffers
" The current buffer will be saved before switching to the next one.
" Choose :bprevious or :bnext
"-------------------------------------------------------------------------------
"
 map  <silent> <s-tab>  <Esc>:if &modifiable && !&readonly &&
     \                  &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
imap  <silent> <s-tab>  <Esc>:if &modifiable && !&readonly &&
     \                  &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"
"-------------------------------------------------------------------------------
" Leave the editor with Ctrl-q : Write all changed buffers and exit Vim
"-------------------------------------------------------------------------------
nmap  <C-q>    :wqa<CR>
"
"-------------------------------------------------------------------------------
" comma always followed by a space
"-------------------------------------------------------------------------------
inoremap  ,  ,<Space>
"
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
"
vnoremap ( s()<Esc>P<Right>%
vnoremap [ s[]<Esc>P<Right>%
vnoremap { s{}<Esc>P<Right>%
"
"-------------------------------------------------------------------------------
" autocomplete quotes (visual and select mode)
"-------------------------------------------------------------------------------
xnoremap  '  s''<Esc>P<Right>
xnoremap  "  s""<Esc>P<Right>
xnoremap  `  s``<Esc>P<Right>
"
"-------------------------------------------------------------------------------
" Change the working directory to the directory containing the current file
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufEnter * :lchdir %:p:h
endif " has("autocmd")
"
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===================================================================================
"
"-------------------------------------------------------------------------------
" c.vim
"-------------------------------------------------------------------------------
"
" --empty --
"
"-------------------------------------------------------------------------------
" taglist.vim : toggle the taglist window
" taglist.vim : define the title texts for make
" taglist.vim : define the title texts for qmake
"-------------------------------------------------------------------------------
 noremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F11>  <Esc><Esc>:Tlist<CR>

let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1

let tlist_make_settings  = 'make;m:makros;t:targets'
let tlist_qmake_settings = 'qmake;t:SystemVariables'

if has("autocmd")
  " ----------  qmake : set filetype for *.pro  ----------
  autocmd BufNewFile,BufRead *.pro  set filetype=qmake
endif " has("autocmd")

"set dictionary+=/usr/share/dict/words
"set dictionary+=/home/lyshie/.gcin/tmpfile
"let mapleader=","

"--------  Toggle auto-indenting for code paste --------
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" indent, tab, space
autocmd FileType python,ruby set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4|let g:neocomplcache_disable_auto_complete=1
autocmd FileType c,cpp set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
autocmd FileType aspvbs set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
autocmd FileType php set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4
autocmd FileType sql set tabstop=4|set shiftwidth=4|set expandtab|set softtabstop=4

if version >= 500 " compatible for directly using 'vi'
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()

  Plugin 'gmarik/Vundle.vim'
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'neocomplcache'
  Plugin 'EasyMotion'
  Plugin 'Chiel92/vim-autoformat'
  Plugin 'jsbeautify'
  Plugin 'rails.vim'
  Plugin 'c.vim'
  Plugin 'bling/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'scrooloose/nerdtree'
  Plugin 'scrooloose/syntastic'
  Plugin 'MarcWeber/vim-addon-mw-utils'
  Plugin 'tomtom/tlib_vim'
  Plugin 'garbas/vim-snipmate'
  "Plugin 'SirVer/ultisnips'
  Plugin 'honza/vim-snippets'
  Plugin 'tpope/vim-surround'
  Plugin 'altercation/vim-colors-solarized'
  "Plugin 'perlomni.vim'
  Plugin 'Tabular'
  Plugin 'mattn/emmet-vim'
  Plugin 'davidhalter/jedi-vim'
  "Plugin 'instant-markdown.vim'
  Plugin 'derekwyatt/vim-scala'
  Plugin 'derekwyatt/vim-sbt'
  Plugin 'Glench/Vim-Jinja2-Syntax'
  Plugin 'vcscommand.vim'
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-colorscheme-switcher'
  Plugin 'maksimr/vim-jsbeautify'
  Plugin 'einars/js-beautify'
  Plugin 'mustache/vim-mustache-handlebars'
  Plugin 'SyntaxRange'
  Plugin 'Drawit'
  Plugin 'dbext.vim'
  Plugin 'lervag/vimtex'
  Plugin 'ervandew/supertab'
  Plugin 'chrisgillis/vim-bootstrap3-snippets'

  call vundle#end()

  filetype plugin indent on

  " airline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  set laststatus=2

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  let g:airline_left_sep = '»'
  let g:airline_left_sep = '⮀'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '⮂'

  noremap <F6> :Autoformat<CR><CR>
  "autocmd FileType c,cpp noremap <F6> :Autoformat<CR> :%s#\($\n\s*\)\+\%$##<CR>
  "nnoremap <F10> :TlistToggle<CR>
  nmap <C-N><C-N> :set nornu<CR> :set invnumber<CR>
  nmap <C-N><C-R> :set nonumber<CR> :set invrnu<CR>

  " margin
  nmap <expr> <C-C><C-C> ColorColumn()
  func ColorColumn()
    if !&colorcolumn
      set colorcolumn=80,160,240
    else
      set colorcolumn=0
    endif
  endfunc

  " margin
  nmap <expr> <C-K><C-K> LineBreak()
  func LineBreak()
    if !&linebreak
      set linebreak
	  set showbreak=>\
    else
      set nolinebreak
	  set showbreak=
    endif
  endfunc

  noremap <F3> :NERDTreeToggle<CR><CR>

  " python
  let g:syntastic_python_checkers = ['pyflakes']

  " neocomplcache
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_auto_select = 0
  "let g:neocomplcache_disable_auto_complete = 1

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  "if has('python3')
  "  autocmd FileType python setlocal omnifunc=python3complete#Complete
  "else
  "  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  "endif
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType sql setlocal omnifunc=sqlcomplete#Complete
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  au BufNewFile,BufRead *.hh set filetype=php

  " c.vim
  "let g:C_LocalTemplateFile = $HOME.'/.vim/c-support/templates/Templates'
  let g:C_GlobalTemplateFile = $HOME.'/.vim/c-support/templates/Templates'
  let g:C_FormatDate = '%F'
  let g:C_FormatTime = '%T'
  let g:C_FormatYear = 'year %Y'

  " autoformat
  let g:formatters_php = ['php']
  let g:formatdef_php  = '"/home/lyshie/bin/php_beautifier --directory_filters=/opt/local/PHP_Beautifier --filters=\"ArrayNested() Lowercase() Pear() KeepEmptyLines() SpaceOpAssignments()\"".(&expandtab ? " --indent_spaces=".&shiftwidth : " --indent_tabs=1")'
  let g:formatters_sql = ['sql']
  "let g:formatdef_sql  = '"/home/lyshie/.local/bin/sqlformat -k upper -i lower ".(&expandtab ? " --indent_width=".&shiftwidth : "")." -"'
  let g:formatdef_sql  = '"/opt/local/src/vcs/sql-formatter/bin/sql-formatter"'

  " solarized color scheme
  let g:solarized_termcolors = 256
  let g:solarized_termtrans  = 1
  let g:solarized_contrast   = "high"
  let g:solarized_visibility = "normal"
  if has('gui_running')
    set background=light
  else
    set background=dark
  endif
  colorscheme solarized

  " Tabular
  let mapleader=','
  "if exists(":Tabularize")
    nmap <Leader>t\| :Tabularize /\|<CR>
    vmap <Leader>t\| :Tabularize /\|<CR>
    nmap <Leader>t:  :Tabularize /\:<CR>
    vmap <Leader>t:  :Tabularize /\:<CR>
    nmap <Leader>t,  :Tabularize /,<CR>
    vmap <Leader>t,  :Tabularize /,<CR>
    nmap <Leader>t=  :Tabularize /=<CR>
    vmap <Leader>t=  :Tabularize /=<CR>
  "endif 

  " xolox/vim-colorscheme-switcher
  let g:colorscheme_switcher_define_mappings = 0
  inoremap <silent> <F10> <C-O>:NextColorScheme<CR>
  nnoremap <silent> <F10> :NextColorScheme<CR>
  inoremap <silent> <F9> <C-O>:PrevColorScheme<CR>
  nnoremap <silent> <F9> :PrevColorScheme<CR>

  " maksimr/vim-jsbeautify (JavaScript format in Jinja)
  autocmd FileType jinja noremap <buffer> <F6> :call HtmlBeautify()<cr>
  autocmd FileType jinja vnoremap <buffer> <F6> :call RangeJsBeautify()<cr>
  autocmd FileType php   vnoremap <buffer> <F6> :call RangeHtmlBeautify()<cr>

  " fix broken syntax highlighting
  noremap <F8> <Esc>:syntax sync fromstart<CR>
  inoremap <F8> <C-o>:syntax sync fromstart<CR>

  let g:jedi#show_call_signatures = 0
  let g:jedi#popup_on_dot = 1
endif
