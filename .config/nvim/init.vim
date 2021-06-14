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
Plug 'folke/lsp-trouble.nvim'

Plug 'vim-test/vim-test'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'joalon/stgit-unofficial.nvim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ThePrimeagen/harpoon'

Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf.vim'
Plug 'chiefnoah/neuron-v2.vim'

Plug 'mhinz/vim-startify'
Plug 'jupyter-vim/jupyter-vim'

Plug 'tomasr/molokai'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'

call plug#end()

" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader="\<Space>"

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" lsp-trouble config
lua require("trouble").setup{}

" nvim-dap
lua require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
lua require('dap-python').test_runner = 'pytest'
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>

" Neuron config
" lua << EOF
" require'neuron'.setup {
"     virtual_titles = true,
"     mappings = true,
"     run = nil, -- function to run when in neuron dir
"     neuron_dir = "~/.neuron", -- the directory of all of your notes, expanded by default (currently supports only one directory for notes, find a way to detect neuron.dhall to use any directory)
"     leader = "<leader>z", -- the leader key to for all mappings, remember with 'go zettel'
" }
" EOF

" stgit config
nnoremap <leader>ss :call StgSeries()<CR>
nnoremap <leader>sk :call StgPop()<CR>
nnoremap <leader>sj :call StgPush()<CR>
nnoremap <leader>sr :!stg refresh -i<CR>

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
nnoremap <leader>fr <cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }<cr>
nnoremap <leader>gr <cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1] }<cr>

nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>gg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>

" Use Markdown in vimwiki
let g:vimwiki_list = [{'path': '~/.vim/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0 " only set extension on file when in vimwiki dir

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-g>"

" LSP Config
lua require('lspconfig').gopls.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').pyls.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').tsserver.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').elixirls.setup{ on_attach=require'completion'.on_attach }
lua require('lspconfig').hls.setup{}
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
set scrolloff=15

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
noremap <Leader>gs :Git<CR>
noremap <Leader>ga :Git add -p<CR>
noremap <Leader>gc :Git commit<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gp :Git push<CR>
noremap <Leader>gl :Git pull<CR>
noremap <Leader>gd :Gdiffsplit<CR>
"noremap <Leader>gr :Gremove<CR> " Conflicts with telescope...
noremap <Leader>gw :Gwrite<CR>

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
autocmd FileType go setlocal formatprg=gofmt

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
