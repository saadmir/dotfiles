set nocompatible                    " full vim
syntax enable                       " enable syntax highlighting
set encoding=utf8                   " utf8 default encoding

call pathogen#infect()              " load pathogen
filetype plugin indent on

noremap , \
let mapleader = ","

" syntax highlighting
syntax on
color mango

set t_Co=256
set autochdir

set scrolloff=3                     " show 3 lines of context around the cursor
set autoread                        " set to auto read when a file is changed from the outside
set mouse=a                         " allow for full mouse support
set autowrite
set showcmd                         " show typed commands

set wildmenu                        " turn on WiLd menu
set wildmode=list:longest,list:full " activate TAB auto-completion for file paths
set wildignore+=*.o,.git,.svn,node_modules

set ruler                           " always show current position
set backspace=indent,eol,start      " set backspace config, backspace as normal
set nomodeline                      " security

set hlsearch                        " highlight search things
set incsearch                       " go to search results as typing
set smartcase                       " but case-sensitive if expression contains a capital letter.
set ignorecase                      " ignore case when searching
set gdefault                        " assume global when searching or substituting
set magic                           " set magic on, for regular expressions
set showmatch                       " show matching brackets when text indicator is over them

set lazyredraw                      " don't redraw screen during macros, faster
set ttyfast                         " improves redrawing for newer computers
set fileformats=unix,mac,dos

set nobackup                        " prevent backups of files, since using vcs
set nowritebackup
set noswapfile

"Show line number
set numberwidth=3
set number

set shiftwidth=2                    " set tab width
set softtabstop=2
set tabstop=2

set et
set textwidth=0
set nowrap

set smarttab
set autoindent                      " set automatic code indentation
set hidden                          " allow background buffers w/out writing

set cursorline                      " highlight current line
set colorcolumn=79                 " show a right margin column
hi ColorColumn ctermbg=black guibg=black

"Higlight current line only in insert mode
autocmd InsertLeave * set nocursorline
autocmd InsertEnter * set cursorline

set list                            " show hidden characters
set listchars=tab:\ \ ,trail:·      " show · for trailing space, \ \ for trailing tab
"set listchars=tab:▸\ ,eol:¬
set listchars=extends:>
set listchars+=precedes:<

set clipboard=unnamedplus
nnoremap <C-y> "+y
vnoremap <C-y> "+y
nnoremap <C-p> "+gP
vnoremap <C-p> "+gP

set spelllang=en,es                 " set spell check language
set noeb vb t_vb=                   " disable audio and visual bells

set formatoptions=qrn1

" FOLDING
set nofoldenable                " disable folding
"set foldenable                  " enable folding
"set foldmethod=indent           " most files are evenly indented
"set foldlevel=99
"press Space to toggle the current fold open/closed. However, if the cursor is not in a fold, move to the right (the default behavior)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

vnoremap cs <leader>cs
vmap cs <leader>cs

vnoremap cc <leader>c<Space>
vmap cc <leader>c<Space>

"navigation
"between tabs
nnoremap <S-Right> gt
nnoremap <leader><Right> gt
nnoremap <leader>l gt
nnoremap <leader>k gt
nnoremap <S-Left> gT
nnoremap <leader><Left> gT
nnoremap <leader>h gT
nnoremap <leader>j gT

"left panel for openning NERDTree"
nnoremap <silent><leader>n :NERDTreeMirrorToggle<cr>
nnoremap <silent> <F10> :NERDTreeMirrorToggle<cr>

"an additional key mapping for pressing ESCAPE key
inoremap jj <ESC>

"map left right up down keys to do the same if done with CTRL
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"map ; to : too
nnoremap ; :

"split screen vertically
"nnoremap <leader>w <C-w>v<C-w>l

"fold the tag in HTML files
"nnoremap <leader>ft Vatzf

"paste the selected text and select it too
nnoremap <C-v> V`]

set showmode

"Show Buffer list
set wildchar=<Tab> wildmenu wildmode=list:longest
set wildcharm=<C-Z>

set path=.,,**,~

" indent visual selected code without unselecting and going back to normal mode
vmap > >gv
vmap < <gv

"add a \v before each search string to turn off VIM specific regex and use
"standard regex
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

set guioptions+=a

" only display scroll bar on left and only when there is need for it
" set guioptions-=r
set guioptions-=L
set guioptions-=l
set guioptions+=R

" strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//e<cr>:let @/=''<CR>

" insert path of current file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" fast editing of the .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" allow saving when you forgot sudo
cmap w!! w !sudo tee % >/dev/null

" Unimpaired
" bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" all my .tpl files ARE html
au BufNewFile,BufRead *.tpl :set ft=html

" JavaScript
au BufRead,BufNewFile *.json set ft=javascript

" au BufRead,BufNewFile *.php set indentexpr= | set smartindent
au BufRead,BufNewFile *.phps set filetype=php

"" STATUS LINE
let g:Powerline_stl_path_style = 'full'
"set statusline=%<%F\ %y\ %h\ pwd=%{getcwd()}\ %m\ %r\ %=%b\ 0x%B\ \ r%l,c%c\ %P

"set laststatus=2 " always hide the statusline
"set statusline= " clear the statusline for when vimrc is reloaded
"set statusline+=%-2.2n\  " buffer number
"set statusline+=%F\  " tail of the filename

"set statusline+=%h "help file flag
"set statusline+=%y\  "filetype
"set statusline+=%r "read only flag
"set statusline+=%m  "modified flag

" display the filesize
" set statusline+=[%{FileSize()}]
"set statusline+=\
" display current git branch
" set statusline+=%{fugitive#statusline()}
"set statusline+=\

"set statusline+=%=  "left/right separator

"set statusline+=%c, " cursor column
"set statusline+=%l/%L " cursor line/total lines
"set statusline+=\ %P\  " percent through file
set laststatus=2  " always show status line
"hi StatusLine     ctermbg=Grey        ctermfg=Black

function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes . " Bytes"
    else
        return (bytes / 1024) . "kB"
    endif
endfunction

function TrimWhiteSpace()
  %s/\s*$//
  ''
:endfunction

autocmd FileWritePre * :call TrimWhiteSpace()
autocmd FileAppendPre * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre * :call TrimWhiteSpace()

"autocmd BufWritePost,FileWritePost *.js !jshint <afile>

" Rename tabs to show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            "let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= i . ' ' . file . '  '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set showtabline=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight TabNum      ctermfg=240 ctermbg=NONE cterm=NONE
    highlight TabLineFill ctermfg=240 ctermbg=NONE cterm=NONE
    highlight TabLine     ctermfg=240 ctermbg=NONE cterm=NONE
    highlight TabLineSel  ctermfg=255 ctermbg=NONE cterm=NONE
endif

set guitablabel=%N/\ %t\ %M

" move tabs to the end for new, single buffers (exclude splits)
autocmd BufNew * if winnr('$') == 1 | tabmove99 | endif

let g:CommandTAcceptSelectionMap = '<,-q>'
let g:CommandTAcceptSelectionTabMap = '<CR>'

let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<,-q>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }


"jsbeautifer related
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

