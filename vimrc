"""""""""""""""""""""""""""""""""""""""
" sn0ot's vimrc config
"""""""""""""""""""""""""""""""""""""""
set nocompatible          " make Vim behave in a more useful way (compared to beig Vi-compatible)
set langmenu=en           " lang for menu traslation, must be set before loading menus, switching on filetype detection or syntax highlighting
let $LANG='en'
set encoding=utf-8        " sets the character encoding used inside Vim (default was "latin1")
set mouse=a               " enable scrolling with mouse wheel
set updatetime=100        " controls the delay before vim writes its swap file in ms

syntax on                 " list syntax/lexical items to enable highlighting
filetype plugin indent on " filetype based contex, check status with :filetype
set noswapfile
set nobackup              " don't make a back up before overwriting a file
set nowritebackup

" ----- indentation
set expandtab             " Use the approtiate number of spaces to represent a <Tab>
set tabstop=4             " Number of space that a <Tab> in the file counts for
set shiftwidth=4          " Make >> perform the same number of spaces
set autoindent            " Copy indent from current line when starting a new line"
set smartindent           " Things like automatically insert an indent in line following a '{'

" ----- readability 
set number                " show line numbers
set relativenumber        " show the line number relative to the line with the cursor in front of each line
set wrap                  " lines longer than width of the window will wrap and display continuously on the next line
set linebreak             " break lines at a character in 'breakat' (like space for example) instead of last character that fits on screen
set colorcolumn=90        " guard at column 90

" ----- searching
set incsearch             " while typing a search command show where the pattern, as it was typed so far, matches
set hlsearch              " when there is a previous search pattern, highlight all its matches
set ignorecase            " (with smartcase) /Foo matches foo Foo FOO
set smartcase             " overrides the 'ignorecase' option if the search pattern contains uppercase characters

" --- exit without delay
set timeoutlen=1000 " time out on mapping after {num} ms
set ttimeoutlen=0 " time out on key codes after {num} ms

" ----- error handling
set noerrorbells 
set novisualbell
set t_vb=
set tm=500

if has ("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif 


set lazyredraw            " Don't redraw screen while running macros. Performance optimizaion
set wildmenu              " command-line completion operates in an enhanced mode
set title                 " title of the window will be set to filename [+=-] (path) or 'titlestring' (if it is not empty)


"""""""""""""""""""""""""""""""""""""""
" Remap 
"""""""""""""""""""""""""""""""""""""""
nnoremap <F2> :source $MYVIMRC<CR> " source vimrc without restarting vim
let mapleader = ' '
let maplocalleader = ' '

" ----- Moving Lines
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv

" ----- Open new line below and above current line
nnoremap <leader>o  o<esc>
nnoremap <leader>O  O<esc>

" ---- system clipboard 
augroup wayland_clipboard
    au!
    au TextYankPost * call system("wl-copy", @")    " automatically copy last yank to system clipboard
augroup END

"""""""""""""""""""""""""""""""""""""""
" Plugin Management (vim-plug) + configs & mapping
"""""""""""""""""""""""""""""""""""""""

" Automatic installation of the minimalist plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" ------ NERDTree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " will be loaded on the first invocation of NERDTreeToggle command
map <C-n> :NERDTreeToggle<CR>

" ----- Fuzzy finder
" assumes fzf is already in installed on system and in $PATH
Plug 'junegunn/fzf.vim'
nnoremap <silent> <Leader>f    :Files<CR>    " Search file names from current cwd
nnoremap <silent> <Leader>F    :Files ~/<CR> " Search file names from home dir
nnoremap <silent> <Leader><CR> :Buffers<CR>  " Search list of open buffers
nnoremap <silent> <Leader>/    :BLines<CR>   " Search current buffer
nnoremap <silent> <Leader>`    :Marks<CR>    " Search list of marks
nnoremap <silent> <Leader>g    :Commits!<CR> " Search list of Git commits

" ----- Language Pack
Plug 'sheerun/vim-polyglot'

" ----- Autoclose ",',(,[,{, etc
Plug 'Raimondi/delimitMate'
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2
set showmatch  " show matching brackets when text indicator is over them
" <S+Tab> to jump out of parenthesis

" ----- junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" ---- Peek at contents of registers
Plug 'junegunn/vim-peekaboo'
" toggle fullscreen with spacebar

" ----- A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'
set laststatus=2 " always show status line on the last window"

" ----- A light and configurable statusline/tabline plugin for Vim 
Plug 'itchyny/lightline.vim'
set noshowmode  " disable current operating mode of vim, Lightline shows us the mode anyway
set cmdheight=1 " number of screen lines to use for the command-line
let g:lightline = {'colorscheme': 'dracula'}

" ----- A Vim plugin which shows a git diff in the 'gutter' (sign column)
Plug 'airblade/vim-gitgutter'

" ----- Fugitive
Plug 'tpope/vim-fugitive'

" ----- Resizing of vim windows
Plug 'simeji/winresizer', {'on': 'WinResizerStartResize'}
map <C-e> :WinResizerStartResize<CR> 

" ----- Vim TMUX navigator
Plug 'christoomey/vim-tmux-navigator'
"let g:tmux_navigator_disable_when_zoomed = 1

"TO:DO follow instructions for ycm server
"Plug 'ycm-core/YouCompleteMe'

" systastic (?)



" Mathch pairs (?)
"Plug 'andymass/vim-matchup'

" ----- Themes
Plug 'dracula/vim', { 'as': 'dracula' }
let g:dracula_italic = 0        " disable italics
"Plug 'drewtempelmeyer/palenight.vim', {'as': 'palenight'}
"Plug 'crusoexia/vim-monokai'
"Plug 'dikiaap/minimalist'
"Plug 'KabbAmine/yowish.vim'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'rakr/vim-two-firewatch'
"Plug 'vim-scripts/peaksea'
"Plug 'liuchengxu/space-vim-dark' "change text color
Plug 'joshdick/onedark.vim'
"Plug 'altercation/vim-colors-solarized'
call plug#end()

"colorscheme onedark
colorscheme dracula

"Transparent Background 
hi Normal     ctermbg=NONE guibg=NONE
"hi LineNr     ctermbg=NONE guibg=NONE
"hi SignColumn ctermbg=NONE guibg=NONE
