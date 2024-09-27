local cmp = require('cmp')

cmp.setup({
	snippet = {
    		expand = function(args)
    		  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    		end,
	},
	mapping = cmp.mapping.preset.insert({ -- Preset: ^n, ^p, ^y, ^e, you know the drill..
	    	["<C-p>"] = cmp.mapping.select_prev_item(),
    		["<C-n>"] = cmp.mapping.select_next_item(),
    		-- Add tab support
    		["<S-Tab>"] = cmp.mapping.select_prev_item(),
    		["<Tab>"] = cmp.mapping.select_next_item(),
    		["<C-d>"] = cmp.mapping.scroll_docs(-4),
    		["<C-f>"] = cmp.mapping.scroll_docs(4),
    		["<C-Space>"] = cmp.mapping.complete(),
    		["<C-e>"] = cmp.mapping.close(),
    		["<CR>"] = cmp.mapping.confirm({
    			behavior = cmp.ConfirmBehavior.Insert,
    		  	select = true,
		})
    	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer', keyword_length = 3 }
	}),
})
