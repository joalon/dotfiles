syntax on
filetype plugin indent on

set exrc
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set mouse=a

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set colorcolumn=80

call plug#begin('~/.vim/plugged')
" Neovim lsp Plugins
"Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/completion-nvim'
"Plug 'tjdevries/nlua.nvim'
"Plug 'tjdevries/lsp_extensions.nvim'

" Neovim Tree shitter
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/playground'

" Debugger Plugins
Plug 'puremourning/vimspector'

Plug 'tweekmonster/gofmt.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" Color
Plug 'tomasr/molokai'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'

" Startify
Plug 'mhinz/vim-startify'
 
" vimwiki
Plug 'vimwiki/vimwiki'
Plug 'jupyter-vim/jupyter-vim'

" firenvim
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()


"set background=dark
"colorscheme gruvbox
fun! ColorMyPencils()
    colorscheme gruvbox
    set background=dark

    let g:gruvbox_contrast_dark = 'hard'
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    let g:gruvbox_invert_selection='0'

    highlight ColorColumn ctermbg=0 guibg=grey
    highlight Normal guibg=none
    " highlight colour of not-current line numbers
    highlight LineNr guifg=#aed75f
    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
endfun
call ColorMyPencils()



if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
\ 'rebase': {
\   'prompt': 'Rebase> ',
\   'execute': 'echo system("{git} rebase {branch}")',
\   'multiple': v:false,
\   'keymap': 'ctrl-r',
\   'required': ['branch'],
\   'confirm': v:false,
\ },
\ 'track': {
\   'prompt': 'Track> ',
\   'execute': 'echo system("{git} checkout --track {branch}")',
\   'multiple': v:false,
\   'keymap': 'ctrl-t',
\   'required': ['branch'],
\   'confirm': v:false,
\ },
\}

" Debugger remaps
" nnoremap <leader>m :MaximizerToggle!<CR>
" nnoremap <leader>dd :call vimspector#Launch()<CR>
" nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
" nnoremap <leader>dt :call
" GotoWindow(g:vimspector_session_windows.tagpage)<CR>
" nnoremap <leader>dv :call
" GotoWindow(g:vimspector_session_windows.variables)<CR>
" nnoremap <leader>dw :call
" GotoWindow(g:vimspector_session_windows.watches)<CR>
" nnoremap <leader>ds :call
" GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
" nnoremap <leader>do :call
" GotoWindow(g:vimspector_session_windows.output)<CR>
" nnoremap <leader>de :call vimspector#Reset()<CR>
"
" nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>
"
" nmap <leader>dl <Plug>VimspectorStepInto
" nmap <leader>dj <Plug>VimspectorStepOver
" nmap <leader>dk <Plug>VimspectorStepOut
" nmap <leader>d_ <Plug>VimspectorRestart
" nnoremap <leader>d<space> :call vimspector#Continue()<CR>
"
" nmap <leader>drc <Plug>VimspectorRunToCursor
" nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
" nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
"
" " <Plug>VimspectorStop
" " <Plug>VimspectorPause
" " <Plug>VimspectorAddFunctionBreakpoint

" greatest remap ever
vnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG
inoremap <C-c> <esc>

"let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
"lua require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

autocmd VimEnter * if isdirectory(expand("<amatch>")) | exe 'FZF! '.expand("<amatch>") | endif
