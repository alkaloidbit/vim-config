return {
	{ "junegunn/fzf", build = "./install --bin" },
	{ "folke/tokyonight.nvim", opts = { style = "storm" } },
	{ "folke/noice.nvim", opts = { lsp = { progress = { enabled = false } } } },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "jcdickinson/codeium.nvim", config = true },
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			{ "saadparwaiz1/cmp_luasnip", dependencies = "L3MON4D3/LuaSnip" },
			"andersevenrud/cmp-tmux",
			"hrsh7th/cmp-cmdline",
		},
		opts = function()
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local luasnip = require("luasnip")

			local function has_words_before()
				if vim.bo.buftype == "prompt" then
					return false
				end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				-- stylua: ignore
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
			end

			return {
				preselect = cmp.PreselectMode.None,
				sorting = defaults.sorting,
				experimental = {
					ghost_text = {
						hl_group = "Comment",
					},
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 50 },
					{ name = "codeium", priority = 50 },
					{ name = "path", priority = 40 },
					{ name = "luasnip", priority = 30 },
				}, {
					{ name = "buffer", priority = 50, keyword_length = 3 },
					{ name = "emoji", insert = true, priority = 20 },
					{
						name = "tmux",
						priority = 10,
						keyword_length = 3,
						option = { all_panes = true, label = "tmux" },
					},
				}),
				mapping = cmp.mapping.preset.insert({
					-- <CR> accepts currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({
							select = true,
							behavior = cmp.ConfirmBehavior.Replace,
						}),
						-- Do not set command mode, it will interfere with noice popmenu.
					}),
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping.select_next_item({ count = 5 }),
					["<C-u>"] = cmp.mapping.select_prev_item({ count = 5 }),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-c>"] = function(fallback)
						cmp.close()
						fallback()
					end,
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.jumpable(1) then
							luasnip.jump(1)
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				formatting = {
					format = function(entry, vim_item)
						-- Prepend with a fancy icon from config lua/rafi/config/init.lua
						local icons = require("rafi.config").icons
						if entry.source.name == "git" then
							vim_item.kind = icons.git
						elseif entry.source.name == "codeium" then
							vim_item.kind = "^"
						else
							local symbol = icons.kinds[vim_item.kind]
							if symbol ~= nil then
								vim_item.kind = symbol .. " " .. vim_item.kind .. " " .. entry.source.name
							end
						end
						return vim_item
					end,
				},
			}
		end,
	},
	{
		"codota/tabnine-nvim",
		build = "./dl_binaries.sh",
		event = "VeryLazy",
		config = function()
			require("tabnine").setup({
				disable_auto_comment = true,
				accept_keymap = "<A-t>",
				dismiss_keymap = "<C-]>",
				debounce_ms = 800,
				suggestion_color = { gui = "#808080", cterm = 244 },
				exclude_filetypes = { "TelescopePrompt" },
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},
		-- stylua: ignore
		keys = {
			{ "zc" },
      { "zo" },
      { "zC" },
      { "zO" },
      { "za" },
      { "zA" },
			{ 'zr', function() require('ufo').openFoldsExceptKinds() end, desc = "Open Folds Except Kinds", },
			{ 'zR', function() require('ufo').openAllFolds() end, desc = "Open All Folds" },
			{ 'zM', function() require('ufo').closeAllFolds() end, desc = "Close All Folds" },
			{ 'zm', function() require('ufo').closeFoldsWith() end, desc = "Close Folds With"},
			{ "zp", function()
					local winid = require('ufo').peekFoldedLinesUnderCursor()
					if not winid then
						vim.lsp.buf.hover()
					end
				end, desc = "Peek Fold", },
		},
		opts = {
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local totalLines = vim.api.nvim_buf_line_count(0)
				local foldedLines = endLnum - lnum
				local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
				suffix = (" "):rep(rAlignAppndx) .. suffix
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
		},
		config = function(_, opts)
			require("ufo").setup(opts)
		end,
	},
	{ "rafi/awesome-vim-colorschemes", enabled = false },
	{ "nvim-lualine/lualine.nvim", enabled = false },
	{
		url = "git@github.com:alkaloidbit/nord.nvim",
		branch = "localchanges",
	},
	{
		"abecodes/tabout.nvim",
		config = function()
			require("tabout").setup({
				tabkey = "<Tab>",
				backwards_tabkey = "<S-Tab>",
				act_as_tab = true,
				act_as_shift_tab = false,
				default_tab = "<C-t>",
				default_shift_tab = "<C-d>",
				enable_backwards = true,
				completion = true,
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = "`", close = "`" },
					{ open = "(", close = ")" },
					{ open = "[", close = "]" },
					{ open = "{", close = "}" },
				},
				ignore_beginning = true,
				exclude = {},
			})
		end,
		wants = { "nvim-treesitter" },
		after = { "nvim-cmp" },
	},
	{
		"Exafunction/codeium.vim",
		enabled = false,
		event = "BufEnter",
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
			under_cursor = true,
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
		},
	},
	{
		"folke/twilight.nvim",
		opts = {
			--  Configuration comes here
		},
	},
	{
		"utilyre/barbecue.nvim",
		event = "VeryLazy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		config = true,
	},
	{ import = "rafi.plugins.extras.ui.bufferline" },
	{ import = "rafi.plugins.extras.coding.emmet" },
	{ import = "rafi.plugins.extras.diagnostics.proselint" },
	{ import = "rafi.plugins.extras.diagnostics.write-good" },
	{ import = "rafi.plugins.extras.editor.anyjump" },
	-- { import = "rafi.plugins.extras.editor.ufo" },
	{ import = "rafi.plugins.extras.editor.flybuf" },
	{ import = "rafi.plugins.extras.formatting.prettier" },
	{ import = "rafi.plugins.extras.lsp.gtd" },
	{ import = "rafi.plugins.extras.lsp.inlayhints" },
	{ import = "rafi.plugins.extras.lsp.lightbulb" },
	{ import = "rafi.plugins.extras.lsp.null-ls" },
	{ import = "rafi.plugins.extras.lsp.yaml-companion" },
	{ import = "rafi.plugins.extras.ui.cybu" },
	{ import = "rafi.plugins.extras.ui.deadcolumn" },
	{ import = "rafi.plugins.extras.ui.goto-preview" },
	{ import = "rafi.plugins.extras.ui.minimap" },
}
