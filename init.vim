" Plugin Setup
call plug#begin('~/.config/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'cloudhead/neovim-fuzzy'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/vim-easy-align'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mihaifm/bufstop'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'tpope/vim-fugitive'
Plug 'vim-syntastic/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'pechorin/any-jump.vim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'romgrk/nvim-treesitter-context'

Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'nvim-treesitter/nvim-treesitter', { 'do' : ':TSUpdate' }

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'glepnir/dashboard-nvim'

call plug#end()

set mouse=a
filetype plugin on
filetype plugin indent on
syntax on
filetype indent on

set autoindent
set autoread
set backspace=2
set clipboard=unnamed
set cursorline
set expandtab
set laststatus=2
set noinsertmode
set number
set ruler
set showcmd
set smartindent
set smarttab
set t_Co=256
set vb

" Nvim Tree-Sitter Folding
set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  context_commentstring = {
    enable = true
  },
  highlight = {
    enable = true,
  },
}

require'nvim-tree'.setup {
  auto_close = true
}
EOF

" Split Switching
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <CR> :noh<CR><CR>

" Big Boi Searching
nnoremap <C-p> :FuzzyOpen<CR>

" Color columns after 93 chars
set colorcolumn=93

" Actual Colorscheme Setup
color dracula
set background=dark

hi IndentGuidesOdd ctermbg=grey
hi IndentGuidesEven ctermbg=lightgrey

noremap <leader>ig :IndentGuidesToggle<CR>

" Sane code tabbing
set tabstop=2
set shiftwidth=2

" Persistent Undo
set undodir=~/.config/nvim/undodir
set undofile

" Better backups
set backupdir=~/.config/nvim/sessions
set dir=~/.config/nvim/sessions

" Session
set ssop-=options

" NvimTree
noremap <leader>d :NvimTreeToggle<CR>

" Telescope
lua << EOF
  require('telescope').setup {
    defaults = {
      file_ignore_patterns = { "node_modules", "cassettes" }
    }
  }
EOF

nmap ; :Telescope find_files<CR>

nmap , :Telescope live_grep<CR>

" Syntastic
let g:syntastic_enable_balloons = 0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='→'
let g:syntastic_stl_format='%E{💀 %fe (%e) ⮃}%W{ 💡 %fw (%w) }'

" Git Gutters
set signcolumn=yes
let g:gitgutter_eager = 0
let g:gitgutter_realtime = 0
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_modified_removed = '│'
let g:gitgutter_sign_removed = '│'

" Comment Header Line
function! CommentHeader()
  let times = 82 - col(".")
  let line  = getline(".")
  let space = " "
  exe ":normal A" . space . repeat("-", times)
endfunction

nnoremap <leader>- :call CommentHeader()<CR>o

" Markdown Date Insert
imap <F3> ## <C-R>=strftime("%m/%d/%Y")<CR>

" Indent Guides
let g:indent_guides_size = 1

" Easy Align
vnoremap <silent> <Enter> :EasyAlign<Enter>

" Gist-VIM
let g:gist_detect_filetype         = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates           = 1
let g:gist_post_privates           = 1
let g:gist_clip_command = 'pbcopy'

" Dashboard
let g:dashboard_default_executive = 'telescope'
let g:dashboard_custom_header = [
\ '• ▌ ▄ ·. ▄▄▄ .• ▌ ▄ ·. ▄▄▄ . ▐ ▄ ▄▄▄▄▄          • ▌ ▄ ·.       ▄▄▄  ▪  ',
\ '·██ ▐███▪▀▄.▀··██ ▐███▪▀▄.▀·•█▌▐█•██  ▪         ·██ ▐███▪▪     ▀▄ █·██ ',
\ '▐█ ▌▐▌▐█·▐▀▀▪▄▐█ ▌▐▌▐█·▐▀▀▪▄▐█▐▐▌ ▐█.▪ ▄█▀▄     ▐█ ▌▐▌▐█· ▄█▀▄ ▐▀▀▄ ▐█·',
\ '██ ██▌▐█▌▐█▄▄▌██ ██▌▐█▌▐█▄▄▌██▐█▌ ▐█▌·▐█▌.▐▌    ██ ██▌▐█▌▐█▌.▐▌▐█•█▌▐█▌',
\ '▀▀  █▪▀▀▀ ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀ ▀▀ █▪ ▀▀▀  ▀█▄▀▪    ▀▀  █▪▀▀▀ ▀█▄▀▪.▀  ▀▀▀▀',
\]
let g:dashboard_custom_footer =[
\ '▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. ',
\ '•█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪',
\ '▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█·',
\ '██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌',
\ '▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀',
\]

" Buffer Switching
map <leader>b :Bufstop<CR>

" Remove Trailing Whitespace
" temp removed until everyone @ work can do the same
" autocmd FileType c,ruby,coffee,css,slim,scss,html,sml autocmd BufWritePre <buffer> :%s/\s\+$//e

" let g:nvim_tree_show_icons = {
" \ 'icons': 1,
" \ }
