return {
	-- { import = 'rafi.plugins.extras.coding.copilot' },
	{ "rafi/awesome-vim-colorschemes", enabled = false },
	{ "nvim-lualine/lualine.nvim", enabled = false },
	{ "alkaloidbit/nord.nvim", branch = "localchanges" },
	{
		"rafi/tabstrip.nvim",
		opts = {
			colors = {
				modified = { fg = "#eceff4", ctermfg = 2 },
			},
			icons = {

				modified = "●",
				session = "",
			},
		},
		branch = "localchanges",
	},
	{
		"feline-nvim/feline.nvim",
	},
	{
		"nvimdev/whiskyline.nvim",
		enabled = false,
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"rebelot/heirline.nvim",
		enabled = false,
		module = false,
	},
	{ import = "rafi.plugins.extras.coding.emmet" },
	{ import = "rafi.plugins.extras.editor.ufo" },
	{ import = "rafi.plugins.extras.editor.flybuf" },
	{ import = "rafi.plugins.extras.lsp.lightbulb" },
}
