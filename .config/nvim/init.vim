set nocompatible

syntax enable

call plug#begin(stdpath('config') . '/plugged')

Plug 'sainnhe/gruvbox-material'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'vim-airline/vim-airline'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'sirver/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'github/copilot.vim'

" plugins {
"
" install plugins { 
" autoinstall vim-plug {
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path
" }

call plug#end()
" }
" run plugin configurations {
" airline {
" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" always show tabs
set showtabline=2

" we don't need to see stuff like --insert-- anymore
set noshowmode
" }
" lspconfig {
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>

autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100)
" }
" }
filetype plugin indent on
" }

" config {
set number relativenumber
set foldenable
set foldmethod=marker
set foldmarker={,}
set clipboard=unnamedplus
" }

" keybindings {
let mapleader=" "
nnoremap <space> <nop>

map <leader>sj ddp
map <leader>z zo
map <leader>c zc

" move windows
nnoremap <leader>h :wincmd h
nnoremap <leader>j :wincmd j
nnoremap <leader>k :wincmd k
nnoremap <leader>l :wincmd l

" CTRL+S to ioasjfd Save
map <C-s> :w<CR>
" }

" colorscheme {

if has('termguicolors')
	set termguicolors
endif

set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_disable_italic_comment = 1
let g:airline_theme = 'gruvbox_material'

colorscheme gruvbox-material

" }

" nvim-cmp {
set completeopt=menu,menuone,noselect

lua <<EOF
