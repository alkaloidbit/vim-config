local M = {}

-- Fzf-lua: Find a file either using git files or search the filesystem.
function M.find_files()
	local fzf = require("fzf-lua")
	if vim.fn.system("git rev-parse --is-inside-work-tree") == true then
		fzf.git_files()
	else
		fzf.files()
	end
end

-- Custom find buffers function. (vim.ui)
function M.find_buffers()
	local results = {}
	local buffers = vim.api.nvim_list_bufs()

	for _, buffer in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buffer) then
			local filename = vim.api.nvim_buf_get_name(buffer)
			table.insert(results, filename)
		end
	end
	vim.ui.select(results, { prompt = "Find buffer:" }, function(selected)
		if selected then
			vim.api.nvim_command("buffer " .. selected)
		end
	end)
end

-- Fzf-lua Find dotfiles
-- dotbare ls-files --full-name --directory "${DOTBARE_TREE}" | awk -v home="${DOTBARE_TREE}/" "{print home \$0}"
function M.find_dotfiles()
	require("fzf-lua").fzf_exec(
		'dotbare ls-files --full-name --directory "${DOTBARE_TREE}" | awk -v home=${DOTBARE_TREE}/ "{print home \\$0}"',
		{
			prompt = 'DotFiles >',
			actions = {
				["default"] = require("fzf-lua").actions.file_edit,
			},
			previewer = "builtin",
			fn_transform = function(x)
				return require'fzf-lua'.make_entry.file(x, {file_icons=true, color_icons=true})
			end,
		}
	)
end

return M
