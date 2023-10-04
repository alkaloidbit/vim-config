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
				prompt_prefix = '  ', -- ❯  
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("aerial")

			-- Highlights
			local fg_bg = require("utils").fg_bg
			local bg  = require("utils").bg
			local fg = require("utils").fg

			local colors = require("plugins.colorscheme.nord.named_colors")

			fg_bg("TelescopePromptPrefix", colors.red, colors.black2)

			bg("TelescopeNormal", colors.darker_black)

			fg_bg("TelescopePreviewTitle", colors.black, colors.green)

			fg_bg("TelescopePromptTitle", colors.black, colors.red)

			fg_bg("TelescopeSelection", colors.white, colors.black2)



			fg_bg("TelescopeBorder", colors.darker_black, colors.darker_black)
			fg_bg("TelescopePromptBorder", colors.black2, colors.black2)
			fg_bg("TelescopePromptNormal", colors.white, colors.black2)
			fg_bg("TelescopeResultsTitle", colors.darker_black, colors.darker_black)
			fg_bg("TelescopePromptPrefix", colors.red, colors.black2)

		end,
	},

	{
		"stevearc/aerial.nvim",
		config = true,
	},
}
