return {
	-- { import = 'rafi.plugins.extras.coding.copilot' },
	{ 'rafi/awesome-vim-colorschemes', enabled = false },
	{ 'shaunsingh/nord.nvim' },
	{
		'rafi/tabstrip.nvim',
		opts = {
			colors = {
				modified = { fg = '#434C5E', ctermfg = 2 },
			},
			icons = {
				modified = '',
				session = '',
			},
		},
	},
}
