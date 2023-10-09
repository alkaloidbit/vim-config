local myactions = {}

function myactions.send_to_qflist(prompt_bufnr)
	require("telescope.actions").send_to_qflist(prompt_bufnr)
	vim.api.nvim_command([[ botright copen ]])
end

function myactions.smart_send_to_qflist(prompt_bufnr)
	require("telescope.actions").smart_send_to_qflist(prompt_bufnr)
	vim.api.nvim_command([[ botright copen ]])
end

--- Scroll the results window up
---@param prompt_bufnr number: The prompt bufnr
function myactions.results_scrolling_up(prompt_bufnr)
	myactions.scroll_results(prompt_bufnr, -1)
end

--- Scroll the results window down
---@param prompt_bufnr number: The prompt bufnr
function myactions.results_scrolling_down(prompt_bufnr)
	myactions.scroll_results(prompt_bufnr, 1)
end

---@param prompt_bufnr number: The prompt bufnr
---@param direction number: 1|-1
function myactions.scroll_results(prompt_bufnr, direction)
	local status = require("telescope.state").get_status(prompt_bufnr)
	local default_speed = vim.api.nvim_win_get_height(status.results_win) / 2
	local speed = status.picker.layout_config.scroll_speed or default_speed

	require("telescope.actions.set").shift_selection(prompt_bufnr, math.floor(speed) * direction)
end

-- Custom pickers

local plugin_directories = function(opts)
	local actions = require("telescope.actions")
	local utils = require("telescope.utils")
	local dir = vim.fn.stdpath("data") .. "/lazy"

	opts = opts or {}
	opts.cmd = vim.F.if_nil(opts.cmd, {
		vim.o.shell,
		"-c",
		"find " .. vim.fn.shellescape(dir) .. " -mindepth 1 -maxdepth 1 -type d",
	})

	local dir_len = dir:len()
	opts.entry_maker = function(line)
		return {
			value = line,
			ordinal = line,
			display = line:sub(dir_len + 2),
		}
	end

	require("telescope.pickers")
		.new(opts, {
			layout_config = {
				width = 0.65,
				height = 0.7,
			},
			prompt_title = "[ Plugin directories ]",
			finder = require("telescope.finders").new_table({
				results = utils.get_os_command_output(opts.cmd),
				entry_maker = opts.entry_maker,
			}),
			sorter = require("telescope.sorters").get_fuzzy_file(),
			previewer = require("telescope.previewers.term_previewer").cat.new(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					local entry = require("telescope.actions.state").get_selected_entry()
					actions.close(prompt_bufnr)
					vim.cmd.lcd(entry.value)
				end)
				return true
			end,
		})
		:find()
end

-- Custom window-sizes
---@param dimensions table
---@param size integer
---@return float
local function get_matched_ratio(dimensions, size)
	for min_cols, scale in pairs(dimensions) do
		if min_cols == "lower" or size >= min_cols then
			return math.floor(size * scale)
		end
	end
	return dimensions.lower
end

local function width_tiny(_, cols, _)
	return get_matched_ratio({ [180] = 0.27, lower = 0.37 }, cols)
end

local function width_small(_, cols, _)
	return get_matched_ratio({ [180] = 0.4, lower = 0.5 }, cols)
end

local function width_medium(_, cols, _)
	return get_matched_ratio({ [180] = 0.5, [110] = 0.6, lower = 0.75 }, cols)
end

local function width_large(_, cols, _)
	return get_matched_ratio({ [180] = 0.7, [110] = 0.8, lower = 0.85 }, cols)
end

-- Enable indent-guides in telescope preview
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	group = vim.api.nvim_create_augroup("rafi_telescope", {}),
	callback = function(args)
		if args.buf ~= vim.api.nvim_win_get_buf(0) then
			return
		end
		vim.opt_local.listchars = vim.wo.listchars .. ",tab:▏\\ "
		vim.opt_local.conceallevel = 0
		vim.opt_local.wrap = true
		vim.opt_local.list = true
		vim.opt_local.number = true
	end,
})

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
				prompt_prefix = "  ", -- ❯  
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("aerial")

			-- Highlights
			local fg_bg = require("utils").fg_bg
			local bg = require("utils").bg
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
