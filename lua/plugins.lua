return {
	-- { import = 'rafi.plugins.extras.coding.copilot' },
	{ "rafi/awesome-vim-colorschemes", enabled = false },
	{ "nvim-lualine/lualine.nvim", enabled = false },
	{ "alkaloidbit/nord.nvim", branch = "localchanges" },
	{
		"RRethy/vim-illuminate",
		opts = {
			providers = {
				'lsp',
				'treesitter',
				'regex',
			},
		},
	},
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
	-- { import = "rafi.plugins.extras.coding.autopairs" },
	-- { import = "rafi.plugins.extras.coding.cmp-git" },
	-- { import = "rafi.plugins.extras.coding.sandwich" },
	{ import = "rafi.plugins.extras.coding.emmet" },
	{ import = "rafi.plugins.extras.diagnostics.proselint" },
	{ import = "rafi.plugins.extras.diagnostics.write-good" },
	{ import = "rafi.plugins.extras.editor.anyjump" },
	{ import = "rafi.plugins.extras.editor.ufo" },
	{ import = "rafi.plugins.extras.editor.flybuf" },
	{ import = "rafi.plugins.extras.formatting.prettier" },
	{ import = "rafi.plugins.extras.lsp.gtd" },
	{ import = "rafi.plugins.extras.lsp.inlayhints" },
	{ import = "rafi.plugins.extras.lsp.lightbulb" },
	{ import = "rafi.plugins.extras.lsp.null-ls" },
	{ import = "rafi.plugins.extras.lsp.yaml-companion" },
	{ import = "rafi.plugins.extras.ui.barbecue" },
	-- { import = "rafi.plugins.extras.ui.cursorword" },
	{ import = "rafi.plugins.extras.ui.cybu" },
	{ import = "rafi.plugins.extras.ui.deadcolumn" },
	{ import = "rafi.plugins.extras.ui.goto-preview" },
	-- { import = "rafi.plugins.extras.ui.incline" },
	{ import = "rafi.plugins.extras.ui.minimap" },
	-- { import = "rafi.plugins.extras.ui.statuscol" },
}
