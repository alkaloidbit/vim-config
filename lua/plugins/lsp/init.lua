return {
	-- nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function (_, opts)
			vim.list_extend(opts.ensure_installed, {"javascript", "typescript", "tsx"})
		end,
	},
	-- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/typescript.nvim",
			"jay-babu/mason-null-ls.nvim",
			{ "j-hui/fidget.nvim", config = true },
		},
		opts = {
			servers = {
				marksman = {},
			},
			setup = {
				tsserver = function (_, opts)
					local lsp_utils = require "plugins.lsp.utils"
					lsp_utils.on_attach(function (client, buffer)
						if client.name == "tsserver" then
							-- stylua: ignore
							vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
							vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
						end
					end)
					require("typescript").setup { server  = opts }
					return true
				end,
			}
		},
	},
	-- mason-null-ls
	{
		"jay-babu/mason-null-ls.nvim",
		opts = { ensure_installed = nil, automatic_installation = true, automatic_setup = false },
	},
	-- barbecue.nvim
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
	-- lspsaga
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
	-- dropbar
	{
		"Bekaboo/dropbar.nvim",
		event = "VeryLazy",
		enabled = function()
			return vim.fn.has("nvim-0.10.0") == 1
		end,
	},
}
