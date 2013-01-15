" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif
execute pathogen#infect()
execute pathogen#helptags()

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number

set t_Co=256

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" if has('mouse')
"  set mouse=a
" endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

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

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

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

else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" use this directory for backup files (*~)
set directory=~/.vim/backup,/tmp
" wrap searches
set wrapscan
"use spellcheck (english by default)
"set spell 

set background=dark

nmap <F3> :FufFile <CR>
"------------------------"  
"NERDTREE PLUGIN SETTINGS  
"------------------------"  
"Shortcut for NERDTreeToggle  
nmap <leader>nt :NERDTreeToggle <CR>  
  
"Show hidden files in NerdTree  
let NERDTreeShowHidden=1




highlight Pmenu ctermfg=1 ctermbg=4 guibg=grey30



" https://github.com/Rip-Rip/clang_complete/issues/158
" Don't move this to any function, it needs to be global
let g:clang_use_library = 1

au BufNewFile,BufRead *.c,*.cc,*.cpp,*.h,*.hh,*.hpp call SetupCPPenviron()

function! SetupCPPenviron()
    "
    " Search path for 'gf' command (e.g. open #include-d files)
    "
    set path+=/usr/include/c++/**
    
    "
    " == Tags ==
    "
    " If I ever need to generate tags on the fly, I uncomment this:
    " noremap <C-F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" build tags of your own project with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
    set tags+=/usr/include/tags
" configure tags - add additional tags here or comment out not-used ones
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/qt4
"set tags+=~/.vim/tags/kde


" == clang ==

" python initClangComplete(vim.eval('g:clang_complete_lib_flags'))

    "
    " necessary for using libclang
    "
    let g:clang_library_path='/usr/lib/llvm'

    " clang_complete Complete options (disable preview scratch window)
    "set completeopt=menu,menuone,longest
     " Limit popup menu height
    "set pumheight=15
     
    " Disable auto popup, use <Tab> (or C+x,c+u) to autocomplete
    " let g:clang_complete_auto=0
    "
    " Show clang errors in the quickfix window
     let g:clang_complete_copen=1

    " https://github.com/Rip-Rip/clang_complete/issues/10
     let g:clang_user_options='|| exit 0'
 
" SuperTab option for context aware completion
"let g:SuperTabDefaultCompletionType = "context"

" == OmniCppComplete ==
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

" se autoindent
set undofile
set undodir=~/.vim/undodir
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

"colorscheme pablo
colorscheme wombat256mod
