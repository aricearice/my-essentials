" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

filetype off

syntax on
set showmatch " show matching braces when text indicator is over them

" Disable the default Vim startup message.
set shortmess+=I


" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline 
    autocmd WinLeave * setlocal nocursorline
augroup END

colorscheme solarized

" Colors let me know whether I'm in a VM

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
    " Do Mac stuff here
    let g:lightline = {'colorscheme': 'solarized'}
    set background=dark
    let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    " customized colors
    highlight SignColumn ctermbg=234
    highlight StatusLine cterm=bold ctermfg=245 ctermbg=235
    highlight StatusLineNC cterm=bold ctermfg=245 ctermbg=235
    highlight SpellBad cterm=underline
    " patches
    highlight CursorLineNr cterm=NONE
  else
    " we in a vm
    set background=light
  endif
endif

let g:solarized_termcolors = 256

" Show line numbers.
set nu
" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber



" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden
" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" tab completion for files/bufferss
set wildmode=longest,list
set wildmenu

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

set hlsearch " Highlight search
set expandtab
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd Filetype tf,yml,yaml,javascript,sh,vim,json,typescript setlocal shiftwidth=2 tabstop=2
autocmd Filetype python setlocal shiftwidth=4 tabstop=4
autocmd Filetype html setlocal shiftwidth=2 tabstop=2
autocmd Filetype markdown setlocal shiftwidth=2 tabstop=2
set autoindent

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" NERDTree 
Plugin 'scrooloose/nerdtree'

" SuperTab
Plugin 'ervandew/supertab'

" Syntastic
Plugin 'scrooloose/syntastic'

" surround.vim
" https://github.com/tpope/vim-surround
" Plugin 'tpope/vim-surround'

" fugitive.vim
" http://vimawesome.com/plugin/fugitive-vim
" a Git wrapper so awesome, it should be illegal
" Plugin 'tpope/vim-fugitive'

" status line
Plugin 'itchyny/lightline.vim'
"Plugin 'vim-airline/vim-airline-themes'

" javascript syntax highlighting
Plugin 'pangloss/vim-javascript'

" typescript vim plugins
" Plugin 'Quramy/tsuquyomi'
" Plugin 'leafgarland/typescript-vim'

" Fuzzy file finder
Plugin 'kien/ctrlp.vim'

" Code search
Plugin 'mileszs/ack.vim'
" vim easymotion
Plugin 'easymotion/vim-easymotion'

call vundle#end()            " required
filetype plugin indent on    " required

" NERDTree
map <C-n> :NERDTreeToggle<CR> " CTRL+n opens up NERDTREE
nnoremap <Leader>f :NERDTreeFind<CR> " \+f finds current file in nerdtree
" Automatically open NERDTree when vim starts up:
" autocmd vimenter * NERDTree

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala      let b:comment_leader = '// '
autocmd FileType javascript,typescript let b:comment_leader = '// '
autocmd FileType yaml,sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab            let b:comment_leader = '# '
autocmd FileType tex                   let b:comment_leader = '% '
autocmd FileType mail                  let b:comment_leader = '> '
autocmd FileType vim                   let b:comment_leader = '" '
autocmd FileType html                  let b:comment_leader = '<!-- '

" Close vim if the only window left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" timeout
set timeout timeoutlen=1000
" map jj to escape key
imap <silent> jj <Esc>
" instead of map to ctrlp!
nmap <silent> ; :CtrlP<CR>

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support.
set mouse+=a

"let b:javascript_fold = 1
"let javascript_enable_domhtmlcss = 1
"" fold everything by syntax
""set foldmethod=syntax
"set foldmethod=indent
"let javaScript_fold=1         " JavaScript

" clipboard!
set clipboard=unnamed

" Make sure backspace works
set backspace=2

set lbr " long lines will be wrapped in 'breakat' rather than last char
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
set lazyredraw " skip redrawing screen in some cases

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


" toggle relative numbering
nnoremap <C-m> :set rnu!<CR>



" movement relative to display lines
nnoremap <silent> <Leader>d :call ToggleMovementByDisplayLines()<CR> " toggle this on/off with \+d
function SetMovementByDisplayLines()
    noremap <buffer> <silent> <expr> k v:count ? 'k' : 'gk'
    noremap <buffer> <silent> <expr> j v:count ? 'j' : 'gj'
    noremap <buffer> <silent> 0 g0
    noremap <buffer> <silent> $ g$
endfunction
function ToggleMovementByDisplayLines()
    if !exists('b:movement_by_display_lines')
        let b:movement_by_display_lines = 0
    endif
    if b:movement_by_display_lines
        let b:movement_by_display_lines = 0
        silent! nunmap <buffer> k
        silent! nunmap <buffer> j
        silent! nunmap <buffer> 0
        silent! nunmap <buffer> $
    else
        let b:movement_by_display_lines = 1
        call SetMovementByDisplayLines()
    endif
endfunction



" ######## SYNTASTIC SETTINGS
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_yaml_checkers = ['jsyaml']
let g:syntastic_debug = 0
let g:syntastic_quiet_messages = {
      \ "regex": ["filenames/match-regex", "filenames/filenames", "File ignored by default"] }

let g:syntastic_typescript_checkers = ['tsuquyomi']
let g:syntastic_python_checkers = ['pylint']
" let g:syntastic_debug = 3
nnoremap <Leader>m :SyntasticToggleMode<CR>


" ######## CTRLP SETTINGS
" ignore meh files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$'
  \ }

" ag / ack.vim NOTE: needs ack, the_silver_searcher installed
command -nargs=+ Gag Gcd | Ack! <args>
nnoremap K :Ack "\b<C-R><C-W>\b"<CR>:cw<CR> " search for current word in dir
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    let g:ackprg = 'ag --vimgrep'
endif

" easymotion
map <Space> <Plug>(easymotion-prefix)

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" Show full path
set statusline+=%F
" Set statusline color based on mode
if version >= 700
    au InsertEnter * hi StatusLine term=reverse ctermbg=Green gui=undercurl guibg=Green
    au InsertLeave * hi StatusLine term=reverse ctermbg=DarkMagenta gui=bold,reverse
endif
" Default the statusline to green when entering Vim
hi StatusLine guibg=Green ctermbg=Green
