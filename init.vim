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

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = false,
		}),
	},
	sources = {
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "ultisnips" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "calc" },
		{ name = "cmp_tabnine" },
		{ name = "latex_symbols" },
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lua = "[LUA]",
				nvim_lsp = "[LSP]",
				path = "[PTH]",
				ultisnips = "[SNP]",
				buffer = "[BUF]",
				calc = "[CAL]",
				spell = "[SPL]",
				latex_symbols = "[LTX]",
				cmp_tabnine = "[TN]",
			})[entry.source.name]

			vim_item.kind = ({
				Text = "  Text",
				Method = "  Method",
				Function = "  Function",
				Constructor = "  Constructor",
				Field = "ﰠ  Field",
				Variable = "  Variable",
				Class = "ﴯ  Class",
				Interface = "  Interface",
				Module = "  Module",
				Property = "ﰠ  Property",
				Unit = "塞 Unit",
				Value = "  Value",
				Enum = "  Enum",
				Keyword = "  Keyword",
				Snippet = "﬌  Snippet",
				Color = "  Color",
				File = "  File",
				Reference = "  Reference",
				Folder = "  Folder",
				EnumMember = "  EnumMember",
				Constant = "  Constant",
				Struct = "פּ Struct",
				Event = "  Event",
				Operator = "  Operator",
				TypeParameter = "  TypeParam",
			})[vim_item.kind]

			if entry.source.name == "cmp_tabnine" then
				vim_item.kind = "  Tabnine"
			elseif entry.source.name == "calc" then
				vim_item.kind = "  Calc"
			end

			return vim_item
		end,
	},
	experimental = { native_menu = false, ghost_text = true },
})

cmp.setup.filetype("markdown", {
	sources = {
		{ name = "buffer", keyword_length = 3 },
		{ name = "spell", keyword_length = 3 },
		{ name = "latex_symbols" },
		{ name = "path" },
		{ name = "ultisnips" },
		{ name = "calc" },
		{ name = "cmp_tabnine" },
	},
})

-- TODO: only enable if connected to wifi
-- cmp.setup.cmdline(":", {
-- 	sources = cmp.config.sources({
-- 		{ name = "path" },
-- 	}, {
-- 		{ name = "cmdline" },
-- 	}),
-- })

vim.cmd("hi CmpItemAbbr guifg=foreground")
vim.cmd("hi CmpItemAbbrDepreceated guifg=error")
vim.cmd("hi CmpItemAbbrMatchFuzzy gui=italic guifg=foreground")
vim.cmd("hi CmpItemKind guifg=#C678DD") -- Boolean
vim.cmd("hi CmpItemMenu guifg=#928374") -- Comment

EOF
