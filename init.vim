call plug#begin()
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
" Plug 'Shougo/neoinclude.vim'

Plug 'neomake/neomake'
Plug 'tanvirtin/monokai.nvim'
Plug 'folke/lsp-colors.nvim', { 'branch': 'main' }

" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }

"Plug 'srstevenson/vim-picker'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }

Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'dart-lang/dart-vim-plugin'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'tag': 'v0.10.0'}
" Configuration for most commonly used language servers
" :LspInfo shows the status of active and configured language servers
Plug 'neovim/nvim-lspconfig'

Plug 'dense-analysis/ale'
Plug 'wellle/tmux-complete.vim'
Plug 'mfussenegger/nvim-lint'

Plug 'vim-airline/vim-airline'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'codeindulgence/vim-tig'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'

Plug 'vim-scripts/a.vim'
Plug 'mileszs/ack.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'sjl/gundo.vim'

Plug 'vhdirk/vim-cmake', { 'for': 'cmake' }

Plug 'peterhoeg/vim-qml'
Plug 'keith/investigate.vim'
Plug 'vim-ruby/vim-ruby'
call plug#end()


" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" == Visuals ==
"set t_Co=256
set background=dark
if &t_Co > 255 || has("gui_running")
    " colorscheme wombat256mod
    "colorscheme pablo
    " colorscheme xorium
    colorscheme monokai_soda
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" == Powerline==
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
set directory=~/.cache/vim,/tmp    " use this directory for swap files (*~)
set backupdir=~/.cache/vim,/tmp    " use this directory for backup files (*~)
set autoread " automatically reload unchanged buffers if the file changed
set signcolumn=yes " alwas show the signcolumn (used for gitgutter etc)
set updatetime=100 " 100ms update delay for gitgutter and swapfiles
"use spellcheck (english by default)
set nospell
set complete+=kspell
map <silent> <leader>de :setlocal spell spelllang=de spelllang? <CR>
map <silent> <leader>en :setlocal spell spelllang=en spelllang? <CR>
map <silent> <leader>ns :setlocal nospell spelllang= spell? <CR>
inoremap <silent> <C-s> <C-x><C-k>

set hidden " hide instead of closing buffers, so we can switch without saving and undo lists remain
set wildignore=CMakeFiles,*~,.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,.DS_Store,*.aux,*.out,*.toc,tmp,*.scssc
set wildmenu
set wildmode=list:longest,full
if executable('/bin/zsh')
    " set shell=/bin/zsh\ -l
    set shell=/bin/fish
    :tnoremap <Esc><Esc> <C-\><C-n>
    :tnoremap <leader><leader> <C-\><C-n>
    :tnoremap <A-Esc> <Esc>

    :tnoremap <A-h> <C-\><C-n><C-w>h
    :tnoremap <A-j> <C-\><C-n><C-w>j
    :tnoremap <A-k> <C-\><C-n><C-w>k
    :tnoremap <A-l> <C-\><C-n><C-w>l
    :nnoremap <A-h> <C-w>h
    :nnoremap <A-j> <C-w>j
    :nnoremap <A-k> <C-w>k
    :nnoremap <A-l> <C-w>l
    let g:terminal_scrollback_buffer_size = 100000

    ":tnoremap <leader>a <C-\><C-n>:Ttoggle<CR>
endif

" Show trailing whitespace:
match ErrorMsg '\s\+$'

" Set leader key
let mapleader = ","

" clear search matching
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Telescope mappings
nmap <unique> <nowait> <leader>t <cmd>Telescope find_files<cr>
nmap <unique> <nowait> <leader>b <cmd>Telescope buffers<cr>
nmap <unique> <nowait> <leader>g <cmd>Telescope live_grep<cr>

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

" toggle terminal
nnoremap <silent> <leader>a :Ttoggle<CR><C-w>ja
tnoremap <silent> <leader>a <C-\><C-n>:Ttoggle<CR>
nmap <silent> <leader>m :T1 srcbuild make install<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" Paste from yankregister instead of default to support repeated replace operations
" vnoremap p "0p
vnoremap P "0p

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
if has('mouse')
 set mouse=a
endif


" Automatically load doxyen syntax for c/c++ and a bunch other languages
let g:load_doxygen_syntax=1

" Investiage 
let g:investigate_command_for_python = '/usr/bin/zeal ^s'

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
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis

command! Linebreak %s///g

" Clean trailing whitespace
command! Cleanspaces :%s/\s\+$//

" NBSP looks like a space but isn't. Use :show list to see them.
command! Cleannobreakspaces :%s/\%ua0/ /

command! Converthtml :%s/&gt;/>/ge | %s/&lt;/</ge | %s/&amp;/&/ge | %s/&quot;/"/ge

command! -range Escape <line1>,<line2>s/"/\\"/ge

command! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
nnoremap = :FormatXML<Cr>

command! FormatJSON :%!jq"
nnoremap = :FormatJSON<Cr>

" function! DoCleanBrackets()
"   " if a:visual
"   "   normal! gv
"   " endif
"   '<,'>s/( /(/g | %s/ )/)/g
" endfunction
"
command! -range From64  :%!base64 --decode
command! -range To64  :%!base64


command! CreatePath :!mkdir -p %:h

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
set clipboard+=unnamedplus

let g:clipboard = {
        \   'name': 'myClipboard',
        \   'copy': {
        \      '+': ['wl-copy'],
        \      '*': ['wl-copy'],
        \    },
        \   'paste': {
        \      '+': ['wl-paste', '--no-newline'],
        \      '*': ['wl-paste', '--no-newline'],
        \   },
        \   'cache_enabled': 1,
        \ }

" Disable recording
map q <Nop>

command! -range Columnize <line1>,<line2>!column -t

command! -range SquashSpaces :<line1>,<line2>s/  */ /

" == Plugin Settings ==
" === Nerdtree  ===
let NERDTreeShowHidden=1

" === Taglist ===
let Tlist_WinWidth = 50

" == Commentary ==
autocmd FileType c,cpp,cs,java,qml setlocal commentstring=//\ %s


" === Rainbow parantheses ===
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
" au Syntax * RainbowParenthesesLoadChevrons
"
" let g:rbpt_colorpairs = [
"     \ ['brown',       'RoyalBlue3'],
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkgray',    'DarkOrchid3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['brown',       'firebrick3'],
"     \ ['gray',        'RoyalBlue3'],
"     \ ['white',       'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
"     \ ['darkred',     'DarkOrchid3'],
"     \ ['red',         'firebrick3'],
"     \ ]
" let g:rbpt_max = 16
" let g:rbpt_loadcmd_toggle = 0

" == Ack/Ag ==
" let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackprg = 'eg'

" == Ultisnips ==
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:dispatch_compilers = {
                \ 'kdesrc': 'kdesrc',
                \ 'makeobj': 'makeobj'}

function! SrcbuildNeomake(...)
    let maker = {'exe': 'srcbuild', 'args': a:000, 'errorformat': '%E%f: line %l\, col %c\, %m'}
    call neomake#Make(0, [maker])
endfunction

command! -nargs=* Srcbuild call SrcbuildNeomake(<f-args>)

" neomake_javascript_maker

" cmake filetype
au BufNewFile,BufRead CMakeLists.txt set filetype=cmake

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#auto_complete_delay = 10
" let g:LanguageClient_serverStderr = '/tmp/clangd.stderr'
" let g:LanguageClient_serverCommands = {
"     \ 'cpp': ['clangd'],
"     \ 'python': ['pyls'],
"     \ 'qml': ['qmllint'],
"     \ }
let g:LanguageClient_diagnosticsList = 'Disabled' " Disabled/Location

"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>jd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>fn :let @+ = expand("%:p")<CR>
" autocmd BufRead,BufNewFile *.md :Goyo
" autocmd BufRead,BufNewFile *.c,*.cc,*.cpp,*.h,*.hh,*.hpp,CMakeLists.txt,*.py,*.qml  :Goyo!
"
" fromstart is the slowest, but also always results in a correct result
autocmd BufEnter * :syntax sync fromstart

autocmd FileType php setlocal commentstring=\/\/\ %s


set inccommand=split

let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_linters = {
 \   'javascript': ['eslint'],
 \   'dart': ['language_server'],
 \   'python': ['flake8'],
 \}
  " Enabled Linters: ['flake8', 'mypy', 'pylint', 'pyright', 'ruff']

" Disable ale on large files because it's sloooooow
lua <<EOF
    vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("IndentBlanklineBigFile", {}),
        pattern = "*",
        callback = function()
            if vim.api.nvim_buf_line_count(0) > 1000 then
                vim.g.ale_enabled = false
            end
        end,
    })
EOF

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0


if has("nvim-0.5.0")

au BufWritePost * lua require('lint').try_lint()

lua <<EOF
require('lint').linters_by_ft = {
  markdown = {'vale',}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
EOF

	"nvim-treesitter configuration
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "c", "cpp", "qmljs", "javascript", "sql", "make", "bash", "php", "vue", "json",     -- one of "all", "language", or a list of languages
  highlight = {
	enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = { "php" },
    disable = function(lang, buf) -- Disable in large C++ buffers
        --return (lang == "cpp" or lang == "c") and (vim.api.nvim_buf_line_count(buf) > 5000)
        if lang == "c" then
            return true
        end
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
  refactor = {
    highlight_definitions = { enable = true },
	highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
  textobjects = {
    -- possible text objects:
    -- @block.inner
    -- @block.outer
    -- @call.inner
    -- @call.outer
    -- @class.inner
    -- @class.outer
    -- @comment.outer
    -- @conditional.inner
    -- @conditional.outer
    -- @function.inner
    -- @function.outer
    -- @loop.inner
    -- @loop.outer
    -- @parameter.inner
    -- @statement.outer
	select = {
	  enable = true,
	  keymaps = {
		["af"] = "@function.outer",
		["if"] = "@function.inner",
		["ac"] = "@class.outer",
		["ic"] = "@class.inner",
		},
	  },
	move = {
	  enable = true,
	  goto_next_start = {
		["]m"] = "@function.outer",
		["]]"] = "@class.outer",
	  },
	  goto_next_end = {
		["]M"] = "@function.outer",
		["]["] = "@class.outer",
	  },
	  goto_previous_start = {
		["[m"] = "@function.outer",
		["[["] = "@class.outer",
	  },
	  goto_previous_end = {
		["[M"] = "@function.outer",
		["[]"] = "@class.outer",
	  },
	},
	swap = {
	  enable = true,
	  swap_next = {
		["<leader>a"] = "@parameter.inner",
	  },
	  swap_previous = {
		["<leader>A"] = "@parameter.inner",
	  },
	},
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
}
EOF

"" LSP config
lua << EOF
vim.lsp.enable('bashls')
vim.lsp.enable('marksman')
vim.lsp.enable('cspell_ls')
vim.lsp.config('cspell_ls', {
      filetypes = {"go", "rust", "js", "ts", "html", "css", "json", "yaml", "markdown", "gitcommit"},
    })
vim.lsp.enable('phpactor')
vim.lsp.config('phpactor', {
        init_options = {
            ["language_server_phpstan.enabled"] = false,
            ["language_server_psalm.enabled"] = false,
        }
    })

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",  -- can be a string or a function
    spacing = 2,
  },
  signs = true,         -- show signs in the gutter
  underline = true,     -- underline problematic text
  update_in_insert = false, -- don't update diagnostics while typing
  severity_sort = true,     -- sort diagnostics by severity
})

local opts = { noremap=true, silent=true }

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

vim.keymap.set('n', '<leader>qf', quickfix, opts)

EOF


lua << EOF
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

EOF

	"telescope configuration
lua <<EOF
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-t>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

EOF

end
