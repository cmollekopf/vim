" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'minibufexpl')
call add(g:pathogen_disabled, 'clangcomplete')
call add(g:pathogen_disabled, 'fuzzyfinder')
" call add(g:pathogen_disabled, 'youcompleteme')
call add(g:pathogen_disabled, 'conque-gdb')
" call add(g:pathogen_disabled, 'yankring')
call add(g:pathogen_disabled, 'camelcasemotion')
call add(g:pathogen_disabled, 'background-make')
call add(g:pathogen_disabled, 'snipmate')

execute pathogen#infect()
execute pathogen#helptags()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set ttymouse=xterm  " so vim doesn't hang inside screen and tmux

" == Visuals ==
"set t_Co=256
set background=dark
if &t_Co > 255 || has("gui_running")
    " colorscheme wombat256mod
    "colorscheme pablo
    colorscheme xorium
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

highlight Pmenu ctermfg=1 ctermbg=4 guibg=grey30

" == Powerline==
set encoding=utf-8
" set laststatus=0 "never show statusbar
set laststatus=2 "always show statusbar
" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup

" == General ==
" se autoindent
set undofile
set undodir=~/.vim/undodir
set undolevels=1000  "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" allow backspacing over everything in insert mode (same as bs=2)
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=700 " keep 700 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set wrapscan    " wrap searches
set incsearch   " do incremental searching
set ignorecase  " ignore case while searching
set smartcase   " don't ignore case while searching when typing upper case
set smarttab    " insert tabs on the start of a line according to shiftwidth, not tabstop
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and'>'
set expandtab     " convert tabs to spaces
set relativenumber number
set directory=~/.vim/backup,/tmp    " use this directory for swap files (*~)
set backupdir=~/.vim/backup,/tmp    " use this directory for backup files (*~)
"use spellcheck (english by default)
"set spell 
set hidden " hide instead of closing buffers, so we can switch without saving and undo lists remain
set wildignore=CMakeFiles,*~,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc
set wildmenu
set wildmode=list:longest,full
if executable('/bin/zsh')
    set shell=/bin/zsh\ -l
endif

" Show trailing whitespace:
match ErrorMsg '\s\+$'

" Set leader key
let mapleader = ","

" clear search matching
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Always search very magic (so we can do search1|search2)
" :nnoremap / /\v
" :cnoremap s/ s/\v

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" quit with leader q
nmap <silent> <leader>q :qa<CR>
" write with leader w
nmap <silent> <leader>w :w<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" Paste from yankregister instead of default to support repeated replace operations
" vnoremap p "0p

" Don't loose selection while indenting
vnoremap < <gv
vnoremap > >gv

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" moving in buffers
nnoremap <C-L> :bn<CR>
nnoremap <C-H> :bp<CR>
nnoremap <C-x> :bd<CR>

" increment and decrement with alt
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" camelcasemotion - replace default motions
" map w <Plug>CamelCaseMotion_w
" map b <Plug>CamelCaseMotion_b
" map e <Plug>CamelCaseMotion_e
" sunmap w
" sunmap b
" sunmap e

" omap iw <Plug>CamelCaseMotion_iw
" xmap iw <Plug>CamelCaseMotion_iw
" omap ib <Plug>CamelCaseMotion_ib
" xmap ib <Plug>CamelCaseMotion_ib
" omap ie <Plug>CamelCaseMotion_ie
" xmap ie <Plug>CamelCaseMotion_ie

" yankring with alt
"let g:yankring_replace_n_pkey = '<C-p>'
"let g:yankring_replace_n_nkey = '<C-n>'

nnoremap <F1> :NERDTreeToggle <CR>  
" nnoremap <F2> :FufFile <CR>
nnoremap <F3> :GitGutterToggle <CR>
nnoremap <F4> :TlistToggle <CR>
nnoremap <F5> :GundoToggle<CR>

" syntax check Bash script
map <leader>cb :!bash -n %<cr>

" build tags of your own project with Ctrl-F11
nnoremap <F11> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" use :w!! if you forgot to sudo open a file
cmap w!! w !sudo tee % >/dev/null

"fix commant-t abort
let g:CommandTCancelMap=['<ESC>','<C-c>']

"Esc with jk
:imap jk <Esc>

" In many terminal emulators the mouse works just fine, thus enable it.
" if has('mouse')
"  set mouse=a
" endif


" Automatically load doxyen syntax for c/c++ and a bunch other languages
let g:load_doxygen_syntax=1

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Reset cursor to beginning for commit messages
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" == Convenience Functions ==

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if !exists(":Linebreak")
  command Linebreak %s///g
endif

" Clean trailing whitespace
if !exists(":Cleanspaces")
  command Cleanspaces :%s/\s\+$//
endif

if !exists(":Converthtml")
  command Converthtml :%s/&gt;/>/ge | %s/&lt;/</ge | %s/&amp;/&/ge | %s/&quot;/"/ge
endif

" function! DoCleanBrackets()
"   " if a:visual
"   "   normal! gv
"   " endif
"   '<,'>s/( /(/g | %s/ )/)/g
" endfunction

nnoremap ds<space> F<space>xf<space>x

" Clean spaces in brackets
if !exists(":Cleanbrackets")
  command Cleanbrackets :%s/( /(/g | %s/ )/)/g
  " command -range Cleanbrackets <line1>,<line2>call DoCleanBrackets()
  " if a:visual
  "   normal! gv
  " endif
  " command Cleanbrackets :'<,'>s/( /(/g | %s/ )/)/g
endif

" Paste clipboard
if !exists(":Paste")
  command Paste :read !xclip -selection clipboard -o
endif

if !exists(":Columnize")
  command -range Columnize <line1>,<line2>!column -t
endif

if !exists(":SquashSpaces")
  command -range SquashSpaces :<line1>,<line2>s/  */ /
endif

if !exists(":Ctest")
  command -nargs=1 Ctest :!cb && ctest -R <f-args> -V && cs
endif

function! KDESrcBuild(project)
  let project = a:project
  compiler kdesrc
  set errorformat^=%-G%f:%l:\ warning:%m
  set makeprg="~/docker/testenv.py srcbuild install " . project
  echo &makeprg
  Make
endfunction

if !exists(":Kake")
  command -nargs=1 Kake :call KDESrcBuild(<f-args>)
endif

" Dispatch ~/docker/testenv.py srcbuild install zanshin

" == Plugin Settings ==
" === Nerdtree  ===
let NERDTreeShowHidden=1
" === Taglist ===
let Tlist_WinWidth = 50

" === YCM ===
" Show function declaration in preview
set completeopt+=preview
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_confirm_extra_conf = 0 "disable confirmation
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" === Rainbow parantheses ===
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['white',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

" == Ultisnips ==
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" == C++ Environment ==

" https://github.com/Rip-Rip/clang_complete/issues/158
" Don't move this to any function, it needs to be global
" let g:clang_use_library = 1

" Continuous compilation after every buffer save
" augroup c++
"     autocmd BufWritePost *.{hpp,cpp}
"         \ silent execute ":!make > ~/.vim/cpperrors 2>&1 &" |
"         \ redraw! |
"         \ cgetfile ~/.vim/cpperrors
" augroup END

" fugitive filetype (doesn't seem to work)
" au! BufNewFile,BufRead fugitive://* setf fugitive
"
let g:dispatch_compilers = {
                \ 'kdesrc': 'kdesrc',
                \ 'makeobj': 'makeobj'}


" CMake Parser
" Call stack entries
" let &efm = ' %#%f:%l %#(%m)'
" " Start of multi-line error
" let &efm .= ',%E' . 'CMake Error at %f:%l (message):'
" " End of multi-line error
" let &efm .= ',%Z' . 'Call Stack (most recent call first):'
" " Continuation is message
" let &efm .= ',%C' . ' %m'

" cmake filetype
au BufNewFile,BufRead CMakeLists.txt set filetype=cmake

au BufNewFile,BufRead *.c,*.cc,*.cpp,*.h,*.hh,*.hpp call SetupCPPenviron()

autocmd BufRead,BufNewFile */kdebuild/* compiler kdesrc

autocmd BufRead,BufNewFile *.md :Goyo

function! SetupCPPenviron()
    " set makeprg=/home/chrigi/devel/kde/kdemake
    " set makeprg=makeobj
    " === CMake Output Parser ===
    " Call stack entries
    " let &efm = ' %#%f:%l %#(%m)'
    " Start of multi-line error
    " let &efm .= ',%E' . 'CMake Error at %f:%l (message):'
    " End of multi-line error
    " let &efm .= ',%Z' . 'Call Stack (most recent call first):'
    " Continuation is message
    " let &efm .= ',%C' . ' %m'


    " Search path for 'gf' command (e.g. open #include-d files)
    set path+=/usr/include/**
    set path+=/opt/devel/master/include/**
    " set path+=/usr/include/c++/**
    
    " === Tags ===
    " configure tags - add additional tags here or comment out not-used ones
    " set tags+=/usr/include/tags
    "set tags+=~/.vim/tags/cpp
    "set tags+=~/.vim/tags/qt4
    "set tags+=~/.vim/tags/kde


    " === clang ===

    " python initClangComplete(vim.eval('g:clang_complete_lib_flags'))

    " necessary for using libclang
    " let g:clang_library_path='/usr/lib/llvm'

    " clang_complete Complete options (disable preview scratch window)
    "set completeopt=menu,menuone,longest
    " Limit popup menu height
    "set pumheight=15
     
    " Disable auto popup, use <Tab> (or C+x,c+u) to autocomplete
    " let g:clang_complete_auto=0

    " Show clang errors in the quickfix window
     " let g:clang_complete_copen=1

    " https://github.com/Rip-Rip/clang_complete/issues/10
     " let g:clang_user_options='|| exit 0'
 
    " SuperTab option for context aware completion
    "let g:SuperTabDefaultCompletionType = "context"

    " === OmniCppComplete ===
    "let OmniCpp_NamespaceSearch = 1
    "let OmniCpp_GlobalScopeSearch = 1
    "let OmniCpp_ShowAccess = 1
    "let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
    "let OmniCpp_MayCompleteDot = 1 " autocomplete after .
    "let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
    "let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
    "let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
    " automatically open and close the popup menu / preview window
    "au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    "set completeopt=menuone,menu,longest,preview

endfunction


