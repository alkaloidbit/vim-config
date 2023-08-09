local M = {}

function M.override()
	return {
		defaults = {
			autocmds = true,
			keymaps = true,
		},
		features = {
			elite_mode = true,
			window_q_mapping = true,
		},
		icons = {

		},
	}
end

function M.lazy_opts()
	return {}
end

return M
