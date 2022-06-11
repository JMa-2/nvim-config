:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set smarttab
:set mouse=a



call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'kyazdani42/nvim-tree.lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'romgrk/barbar.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'danymat/neogen'
Plug 'sainnhe/edge'
Plug 'terrortylor/nvim-comment'
Plug 'folke/which-key.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'folke/which-key.nvim'
Plug 'nvim-lualine/lualine.nvim'


call plug#end()

:colorscheme edge 


nnoremap <C-s> :w<CR>
nnoremap <C-w> :bd<CR>

nnoremap <C-Right> W
nnoremap <C-Left> B
nnoremap <C-Up> {
nnoremap <C-Down> }

nnoremap <M-Left> :BufferPrev<CR>
nnoremap <M-Right> :BufferNext<CR>

nnoremap <C-b> :NvimTreeOpen<CR>
nnoremap <C-f> :Telescope live_grep<CR>

nnoremap <C-c> y
nnoremap <C-x> d
nnoremap <C-v> p
nnoremap <C-z> u
nnoremap <C-y> :redo<CR>

nnoremap <S-Right> :wincmd l<CR>
nnoremap <S-Left> :wincmd h<CR>

nnoremap <C-p> :Telescope find_files<CR>


nnoremap <C-d> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <S-d> <cmd>lua vim.lsp.buf.declaration()<CR>

nnoremap <C-/> :CommentToggle<CR>

nnoremap <C-n> :Neogen<CR>

inoremap <C-s> <nop>

inoremap <C-BS> <C-w>

nnoremap <C-e> <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>


set clipboard+=unnamedplus

lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  indent = { enable = true }
}

require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

require("nvim-autopairs").setup {}

require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

require("nvim-tree").setup {
	actions = {
		open_file = {
			quit_on_open = true,
		}
	}
}

require("lualine").setup {
	
}

require("neogen").setup {
	
}

require("nvim_comment").setup {
	
}

require("lspconfig").clangd.setup {
	vim.diagnostic.config({
		virtual_text = false,
		signs = true,
		underline = true,	
	})
}

EOF
