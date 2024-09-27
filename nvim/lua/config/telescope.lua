local wk = require("which-key")
local telescope = require("telescope.builtin")
wk.add({
	{ "<localleader>ff", function ()
		telescope.find_files({
			hidden = true,
			no_ignore = true,
			no_ignore_parent = true,
		})
	end, desc = "Telescope find files", mode = "n" },
	{ "<localleader>fg", telescope.live_grep, desc = "Telescope live grep", mode = "n" },
})

require('telescope').setup({
  defaults = {
	  layout_strategy = 'horizontal',
  }
})
