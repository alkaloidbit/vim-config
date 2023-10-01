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
		opts = {
			defaults = {
				prompt_prefix = " ",
			}
		},
		config = function(_, opts)
			require('telescope').setup(opts)
			require("telescope").load_extension("aerial")
		end,
	},

	{
		"stevearc/aerial.nvim",
		config = true,
	},
}
