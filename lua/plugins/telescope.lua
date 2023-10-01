return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"stevearc/aerial.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{
				"<leader>co",
				"<cmd>Telescope aerial<cr>",
				desc = "Code Outline",
			},
		},
		opts = {
			defaults = {
				prompt_prefix = " ",
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("aerial")

			-- Highlights
			local fg_bg = require("utils").fg_bg
			local colors = require("plugins.colorscheme.colors")
			fg_bg("TelescopePreviewTitle", colors.black, colors.green)
			fg_bg("TelescopePromptTitle", colors.black, colors.red)
			fg_bg("TelescopeResultsTitle", colors.darker_black, colors.blue)
		end,
	},

	{
		"stevearc/aerial.nvim",
		config = true,
	},
}
