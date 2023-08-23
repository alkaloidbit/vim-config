local M = {}

function M.reload()
	-- Telescope will give us something like ju/colors.lua,
	-- so this module convert the selected entry to
	-- the module name: ju.colors
	local function get_module_names(s)
		local module_name

		module_name = s:gsub("%.lua", "")
		module_name = module_name:gsub("%/", ".")
		module_name = module_name:gsub("%.init", "")

		return module_name
	end

	local prompt_title = "~ neovim modules ~"

	local path = "~/.config/nvim/lua"

	local opts = {
		prompt_title = prompt_title,
		cwd = path,

		attach_mappings = function(_, map)
			map("i", "<c-e>", function(_)
				local entry = require("telescope.actions.state").get_selected_entry()
				local name = get_module_names(entry.value)

				R(name)
				P(name .. " RELOADED!!!")
			end)

			return true
		end,
	}
	require("telescope.builtin").find_files(opts)
end

-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}

M.project_files = function()
	local opts = {}

	local cwd = vim.fn.getcwd()
	if is_inside_work_tree[cwd] == nil then
		vim.fn.system("git rev-parse --is-inside-work-tree")
		is_inside_work_tree[cwd] = vim.v.shell_error == 0
	end

	if is_inside_work_tree[cwd] then
		require("telescope.builtin").git_files(opts)
	else
		require("telescope.builtin").find_files(opts)
	end
end

M.dotfiles = function(opts)
	local actions = require("telescope.actions")
	local utils = require("telescope.utils")
	local make_entry = require("telescope.make_entry")
	local tree = os.getenv("DOTBARE_TREE")

	opts = opts or {}
	opts.cwd = tree

  opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_file(opts))

	require("telescope.pickers").new(opts, {
		prompt_title = "[ DotFiles ]",
		finder = require("telescope.finders").new_table({
			results = utils.get_os_command_output({ "dotbare", "ls-files", "--full-name" }, tree),
			entry_maker = opts.entry_maker,
		}),
		sorter = require('telescope.sorters').get_fuzzy_file(),
		previewer = require('telescope.previewers.term_previewer').cat.new(opts),
	})
	:find()
end

return M
