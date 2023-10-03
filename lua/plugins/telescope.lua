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
				border = {},
				-- prompt_prefix = " ",
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("aerial")

			-- Highlights
			local fg_bg = require("utils").fg_bg
			local colors = require("plugins.colorscheme.nord.named_colors")
			fg_bg("TelescopePromptPrefix", colors.red, colors.black)
			fg_bg("TelescopeNormal", colors.red, colors.black)
			fg_bg("TelescopePreviewTitle", colors.black, colors.green)
			fg_bg("TelescopePromptTitle", colors.black, colors.red)
			fg_bg("TelescopeResultsTitle", colors.black, colors.blue)
			fg_bg("TelescopeSelection", colors.white, colors.black)
			fg_bg("TelescopeResultsDiffAdd", colors.green, colors.black)
			fg_bg("TelescopeResultsDiffChange", colors.yellow, colors.black)
			fg_bg("TelescopeResultsDiffDelete", colors.red, colors.black)


			fg_bg("TelescopeBorder", colors.black, colors.black)
			fg_bg("TelescopePromptBorder", colors.black, colors.black)
			fg_bg("TelescopePromptNormal", colors.white, colors.black)
			fg_bg("TelescopeResultsTitle", colors.black, colors.black)
			fg_bg("TelescopePromptPrefix", colors.red, colors.black)

		end,
	},

	{
		"stevearc/aerial.nvim",
		config = true,
	},
}
