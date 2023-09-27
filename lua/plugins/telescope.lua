return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"stevearc/aerial.nvim",
		},
		keys = {
			{
				"<leader>co", "<cmd>Telescope aerial<cr>", desc = "Code Outline"
			}
		},
		config = function(_, opts)
			require("telescope").load_extension("aerial")
		end
	},

	{
		"stevearc/aerial.nvim",
		config = true,
	},
}
