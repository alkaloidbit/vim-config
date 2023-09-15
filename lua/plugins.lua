return {
	{ "junegunn/fzf", build = "./install --bin" },
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
		end,
	},
	{ "rafi/awesome-vim-colorschemes", enabled = false },
	{ "nvim-lualine/lualine.nvim", enabled = false },
	{
		url = "git@github.com:alkaloidbit/nord.nvim",
		branch = "localchanges",
	},
	{
		'abecodes/tabout.nvim',
		config = function()
			require 'tabout'.setup {
				tabkey = '<Tab>',
				backwards_tabkey = '<S-Tab>',
				act_as_tab = true,
				act_as_shift_tab = false,
				default_tab = '<C-t>',
				default_shift_tab = '<C-d>',
				enable_backwards = true,
				completion = true,
				tabouts = {
					{open = "'", close = "'"},
					{open = '"', close = '"'},
					{open = '`', close = '`'},
					{open = '(', close = ')'},
					{open = '[', close = ']'},
					{open = '{', close = '}'},
				},
				ignore_beginning = true,
				exclude = {},
			}
		end,
		wants = {'nvim-treesitter'},
		after = {'nvim-cmp'}
	},
	{
		"Exafunction/codeium.vim",
		event = "InsertEnter",
		config = function()
			vim.g.codeium_disable_bindings = 1
			vim.keymap.set("i", "<A-m>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<A-f>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<A-b>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<A-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
			vim.keymap.set("i", "<A-s>", function()
				return vim.fn["codeium#Complete"]()
			end, { expr = true })
		end,
	},
	{
		"RRethy/vim-illuminate",
		opts = {
			providers = {
				"lsp",
				"treesitter",
				"regex",
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				"<localleader>f",
				"<cmd>lua require('fr.telescope').project_files()<CR>",
				desc = "Project Files",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		keys = {
			{ "<localleader>dt", "<cmd>TodoTelescope<CR>", desc = "Todo" },
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {

			default_component_configs = {

				git_status = {
					symbols = {

						-- Change type
						added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
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
		enabled = false,
		branch = "localchanges",
	},
	{
		"feline-nvim/feline.nvim",
	},
	{
		"jackMort/ChatGPT.nvim",
		cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
		config = true,
		enabled = true,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		}
	},
	{
		"folke/twilight.nvim",
		opts = {
			--  Configuration comes here
		},
	},
	{ import = "rafi.plugins.extras.ui.bufferline" },
	{ import = "rafi.plugins.extras.ui.barbecue" },
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
	{ import = "rafi.plugins.extras.ui.cybu" },
	{ import = "rafi.plugins.extras.ui.deadcolumn" },
	{ import = "rafi.plugins.extras.ui.goto-preview" },
	{ import = "rafi.plugins.extras.ui.minimap" },
}
