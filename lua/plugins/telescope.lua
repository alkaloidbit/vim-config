return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"stevearc/aerial.nvim",
			 "nvim-treesitter/nvim-treesitter", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
		},
		keys = {
			{
				"<leader>co", "<cmd>Telescope aerial<cr>", desc = "Code Outline"
			}
		},
		opts = function ()
			return require "plugins.configs.telescope"
		end,
		config = function(_, opts)
			local telescope = require "telescope"
			telescope.setup(opts)

			-- load extensions
			for _, ext in ipairs(opts.extensions_list) do
				telescope.load_extension(ext)
			end
		end
	},

	{
		"stevearc/aerial.nvim",
		config = true,
	},
}
