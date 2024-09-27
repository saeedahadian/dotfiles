return {
	{
	  "nvim-telescope/telescope.nvim",
	  dependencies = {
	    'nvim-lua/plenary.nvim',
	    'jonarrien/telescope-cmdline.nvim',
	  },
	  keys = {
	    { ':', '<cmd>Telescope cmdline<cr>', desc = 'Cmdline' }
	  },
	}
}
