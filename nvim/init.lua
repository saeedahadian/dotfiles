require("config.lazy")

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("gitsigns").setup()
require("nvim-web-devicons").setup()
require("lualine").setup()
require("nvim-tree").setup()

require('lspconfig').phpactor.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.twiggy_language_server.setup{}

local wk = require("which-key")
local telescope = require("telescope.builtin")
local nvimtree = require("nvim-tree.api")
wk.add({
	{ "<localleader>ff", telescope.find_files, desc = "Telescope find files", mode = "n" },
	{ "<localleader>fg", telescope.live_grep, desc = "Telescope live grep", mode = "n" },
	{ "<localleader>t", function ()
		nvimtree.tree.toggle({ find_file = true })
	end, desc = "Nvim-tree find file and toggle", mode = "n" },
	{ "<localleader>g", "<cmd>ZenMode<cr>", desc = "Toggle zen mode", mode = "n" },
})
