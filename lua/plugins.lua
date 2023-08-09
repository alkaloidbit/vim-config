return {
	-- { import = 'rafi.plugins.extras.coding.copilot' },
	{ 'rafi/awesome-vim-colorschemes', enabled = false },
	{ 'alkaloidbit/nord.nvim', branch = "localchanges" },
	{
		'rafi/tabstrip.nvim',
		opts = {
			colors = {
				modified = { fg = '#eceff4', ctermfg = 2 },

			},
			icons = {

				modified = '●',
				session = '',
			},
		},
		branch = "localchanges",
	},
}
