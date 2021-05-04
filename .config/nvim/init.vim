call plug#begin(expand('~/.config/nvim/plugged'))
"*****************************************************************************
"" Plug install packages
"*****************************************************************************
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
Plug 'chaoren/vim-wordmotion'
Plug 'junegunn/gv.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'sheerun/vim-polyglot'

Plug 'folke/lsp-trouble.nvim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'puremourning/vimspector'

Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-startify'
Plug 'jupyter-vim/jupyter-vim'

Plug 'junegunn/goyo.vim'

Plug 'tomasr/molokai'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'

call plug#end()

" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" lsp-trouble setup
lua require("trouble").setup{}


" Telescope config
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF

" Find files using Telescope command-line sugar.
nnoremap <Leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Use Markdown in vimwiki
let g:vimwiki_list = [{'path': '~/.vim/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0 " only set extension on file when in vimwiki dir

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
nmap <F5> <Plug>VimspectorContinue
nmap <F7> <Plug>VimspectorReset
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto

" LSP Config
lua require('lspconfig').gopls.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').pyls.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').tsserver.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').elixirls.setup{ on_attach=require'completion'.on_attach }
" use omni completion provided by lsp
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

set completeopt=menuone,noinsert,noselect
let g:completion_matchin_strategy_list = ['exact', 'substring', 'fuzzy']
set shortmess+=c

nmap <tab> <Plug>(completion_smart_tab)
nmap <s-tab> <Plug>(completion_smart_s_tab)

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Required:
filetype plugin indent on

" Startify header
let g:startify_custom_header = [
    \ '    _______                    .__         ',
    \ '    \      \   ____  _______  _|__| _____  ',
    \ '    /   |   \_/ __ \/  _ \  \/ /  |/     \ ',
    \ '   /    |    \  ___(  <_> )   /|  |  Y Y  \',
    \ '   \____|__  /\___  >____/ \_/ |__|__|_|  /',
    \ '           \/     \/                    \/ ',
    \ ]

set background=dark
set colorcolumn=79

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab


"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
set ruler
set number
set relativenumber

let no_buffers_menu=1
silent! colorscheme gruvbox

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

let g:CSApprox_loaded = 1

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=7

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have these shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev wqq wq
cnoreabbrev Wqq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Netrw config: https://shapeshed.com/vim-netrw/
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 25

let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

nnoremap <F2> :call ToggleNetrw()<CR>

" Warp speed with shift-j/k
nnoremap <S-j> 10j
nnoremap <S-k> 10k

" Disable arrow keys
nnoremap <Up>       <nop>
nnoremap <Down>     <nop>
nnoremap <Left>     <nop>
nnoremap <Right>    <nop>

" Switch between splits with ctrl-<movement>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" terminal emulation
nnoremap <silent> <leader>t :terminal<CR>

" Exit terminal mode with escape
tnoremap <Esc> <C-\><C-n>

packadd termdebug

" Set initial window layout when running termdebug
let g:termdebug_wide=1

"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

set autoread

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Fugitive
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
augroup END

" Disable visualbell
set noerrorbells visualbell t_vb=

" Switching buffers
nnoremap <silent> <C-h> :bprev<CR>
nnoremap <silent> <C-l> :bnext<CR>

" Close buffer
nnoremap <silent> <C-w> :bd<CR>

nnoremap <silent> <Leader>rp :!python3 %<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

" Formatting commands
autocmd FileType elixir setlocal formatprg=mix\ format\ -
autocmd FileType go setlocal formatprg=gofmt -

let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

" vim-airline
let g:airline_symbols = {}
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
