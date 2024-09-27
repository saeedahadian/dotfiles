require("config.lazy")

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.notify = require("notify")

require("config.gitsigns")
require("config.devicons")
require("config.lualine")
require("config.nvimtree")
require("config.telescope")
require("config.mason")
require("config.mason-lspconfig")
require("config.cmp")

local wk = require("which-key")
local nvimtree = require("nvim-tree.api")
wk.add({
	{ "<localleader>t", function ()
		nvimtree.tree.toggle({ find_file = true })
	end, desc = "Nvim-tree find file and toggle", mode = "n" },
	{ "<localleader>g", "<cmd>ZenMode<cr>", desc = "Toggle zen mode", mode = "n" },
	{ "gx", "<cmd>silent !xdg-open <cfile><CR>", desc = "Open link under cursor in your default browser", mode = "n" },
})
