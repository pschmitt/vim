" Directories
" NOTE: In order top make that work $VIMINIT has to be set
" export VIMINIT='let $VIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $VIMRC'
" Source: http://tlvince.com/vim-respect-xdg
if empty($VIMDOTDIR)
    if empty($XDG_CONFIG_HOME)
        let $XDG_CONFIG_HOME=expand("$HOME/.config")
    endif
    let $VIMDOTDIR=expand($XDG_CONFIG_HOME/vim)
endif
if empty($XDG_CACHE_HOME)
    let $XDG_CACHE_HOME=expand("$HOME/.cache")
endif

" Environment
set directory=$XDG_CACHE_HOME/vim
"set directory+=~/tmp,/var/tmp,/tmp
set backupdir=$XDG_CACHE_HOME/vim/backup
"set backupdir+=~/tmp
" FIXME: Why the heck is the following directive ignored?!
"set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
set runtimepath=$VIMDOTDIR,$VIMDOTDIR/after,$VIM,$VIMRUNTIME
set undodir=$XDG_CACHE_HOME/vim
set backupext=.bak

" Create temp data dirs if they do not exist yet
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" Enable syntax highlighting
syntax on
filetype plugin on
" Show matching brackets
set showmatch
set nocompatible
set t_Co=256
set undofile
" Maximum number of changes that can be undone
set undolevels=1000
" Maximum number lines to save for undo on a buffer reload
set undoreload=10000
" Enable mouse
set mouse=a

" Hilight current line/col
set cursorcolumn
set cursorline
" Show line numbers
set nu
" Relative line numbers
set rnu

" Numbers of spaces of tab character
set tabstop=4
" Numbers of spaces to (auto)indent
set shiftwidth=4
" Insert spaces instead of tab chars
set expandtab
" Always set autoindenting on
"set autoindent
"set cindent
" Folding
set foldenable
set foldmethod=marker
" Highlight all search results
set hlsearch
" Hilight matching while typing
set incsearch
" Encoding
set encoding=utf-8
set termencoding=utf-8
" Fileformats
set ffs=unix
" Occasions to show status line, 2=always
set laststatus=2
" Command line height
set cmdheight=1
" Fix backspace
set backspace=indent,eol,start
" FIXME: Make l/m, Left/Right jump to next/previous line when on begginig/end of line
set whichwrap+=<,>,[,]

" Key bindings
" Change leader, defaults to \
let mapleader = ","

" Common save shortcuts
" Inoremap <C-s> <esc>:w<cr>a
" Nnoremap <C-s> :w<cr>

" Disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Hilight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Toggle highlight current line and col
map <F4> :set cursorcolumn! cursorline! <CR>

" Toggle relative line numbering
map <F6> :call ToggleRelativeNumber()<CR>
function! ToggleRelativeNumber()
    set rnu!
endfunction

" Automagically remove trailing whitespaces when saving file
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> :%s/\s\+$//e

" Remove trailing whitespaces
" Short version: map <F8> :%s/\s\+$//e<CR>
" http://vimcasts.org/episodes/tidying-whitespace/
nnoremap <silent> <F8> :call <SID>Preserve("%s/\\s\\+$//e")<CR>
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>

" Toggle paste mode
map <F9> :set paste!<CR>

" Map Ctrl-Backspace to delete to beginning of line
imap <C-H> <Esc>c0
map <C-H> <Esc>c0<Esc>

" Spell Check
nmap <silent> <F11> :call ToggleSpell()<CR>
let b:myLang=0
let g:myLangList=["nospell","de_20", "fr", "en_us"]
function! ToggleSpell()
    let b:myLang=b:myLang+1
    if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
    if b:myLang==0
        setlocal nospell
    else
        execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
    endif
    echo "spell checking language:" g:myLangList[b:myLang]
endfunction

" Set bracket matching and comment formats
" Set matchpairs+=<:>
" Set comments-=s1:/*,mb:*,ex:*/
" Set comments+=s:/*,mb:**,ex:*/
" Set comments+=fb:*
" Set comments+=b:\"
" Set comments+=n::

" Fix filetype detection
au BufNewFile,BufRead *.sh set filetype=sh
au BufNewFile,BufRead *.zsh set filetype=zsh

" C file specific options
au FileType c,cpp set cindent
au FileType c,cpp set formatoptions+=ro

" Session Settings
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

" Turn off blinking
set novb

" Turn off beep
"set noerrorbells
"set t_vb=

" Mutt integration
" Autocmd BufRead ~/.mutt/temp/mutt*   :source ~/.vim/mail.vimrc

" Restore cursor position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Source plugins
so $XDG_CONFIG_HOME/vim/vimrc_plugins
