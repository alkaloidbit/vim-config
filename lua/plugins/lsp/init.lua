return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			dependencies = {
				"jay-babu/mason-null-ls.nvim",
				{ "j-hui/fidget.nvim", config = true },
			},
			servers = {
				marksman = {},
			},
		},
	},
  { "jay-babu/mason-null-ls.nvim", opts = { ensure_installed = nil, automatic_installation = true, automatic_setup = false } },
	{
		"utilyre/barbecue.nvim",
		event = "VeryLazy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		enabled = false,
		config = true,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "VeryLazy",
		opts = {
			symbol_in_winbar = {
				enable = false,
			},
			lightbulb = {
				enable = false,
			},
		},
	},
	{
		"Bekaboo/dropbar.nvim",
		event = "VeryLazy",
		enabled = function()
			return vim.fn.has("nvim-0.10.0") == 1
		end,
	},
}
