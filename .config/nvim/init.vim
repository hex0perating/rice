set nocompatible

syntax enable

" plugins {{
"
" install plugins {{ 
" autoinstall vim-plug {{
let autoload_plug_path = stdpath('config') . '/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path
" }}

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
call plug#end()
" }}
" run plugin configurations {{
" airline {{
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
" }}
" lspconfig {{
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>

autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100)
" }}
" }}
filetype plugin indent on
" }}

" config {{
set number relativenumber
set foldenable
set foldmethod=marker
set foldmarker={{,}}
set clipboard=unnamedplus

" tab behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab

" }}

" keybindings {{

" functions {{

" :helplist {{
function! ListHelpSubjects()
    new
    for f in globpath(&runtimepath, '**/doc/tags', 0, 1)
        call append('$', readfile(f))
    endfor
endfunction
" }}
command Helplist call ListHelpSubjects()

" :helplistfp {{
function LoadHelpTags(filename)
    let docpath = substitute(a:filename, '\\', '/', 'g')
    let docpath = substitute(docpath, '/tags$', '/', '')

    let tags = readfile(a:filename)

    return map(tags, { idx, val -> substitute(val, '\t', '\t' . docpath, '') })
endfunction

function! ListHelpFileNames()
    new
    for f in globpath(&runtimepath, '**/doc/tags', 0, 1)
        call append('$', LoadHelpFileNames(f))
    endfor
endfunction

" }}
command Helplistfp call ListHelpFileNames()

" }}

let mapleader=" "
nnoremap <space> <nop>

map <leader>sj ddp
map <leader>z zo
map <leader>c zc

" move windows
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>

" CTRL+S to Save
map <C-s> :w<CR>
map <C-q> :q<CR>
map <C-Q> :q!<CR>
" }}

" colorscheme {{

if has('termguicolors')
	set termguicolors
endif

set background=dark
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_disable_italic_comment = 1
let g:airline_theme = 'gruvbox_material'

colorscheme gruvbox-material

" }}

" nvim-cmp {{
set completeopt=menu,menuone,noselect

lua <<EOF

EOF
" }}
