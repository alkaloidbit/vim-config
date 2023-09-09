local present, feline = pcall(require, "feline")

local fmt = string.format

if not present then
	return
end

local theme = {
	glacier = "#81A1C1", -- nord9 in palette
	bg = "#2E3440",
	black = "#2E3440", -- nord0 in palette
	blue = "#5E81AC", -- nord10 in palette
	teal = "#8FBCBB", -- nord7 in palette
	red = "#BF616A", -- nord11 in palette
	fg = "#ECEFF4", -- nord6 in palette
	white = "#ECEFF4", -- nord6 in palette
	dark_gray = "#3B4252", -- nord1 in palette
	gray = "#434C5E", -- nord2 in palette
	light_gray = "#4C566A", -- nord3 in palette
	light_gray_bright = "#616E88", -- out of palette
	darkest_white = "#D8DEE9", -- nord4 in palette
	darker_white = "#E5E9F0", -- nord5 in palette
	green = "#A3BE8C", -- nord14 in palette
	off_blue = "#88C0D0", -- nord8 in palette
	orange = "#D08770", -- nord12 in palette
	purple = "#B48EAD", -- nord15 in palette
	yellow = "#EBCB8B",
}

vim.api.nvim_set_hl(0, "StatusLine", { bg = "#2E3440", fg = "#81A1C1" })

local mode_theme = {
	["NORMAL"] = theme.glacier,
	["OP"] = theme.teal,
	["INSERT"] = theme.fg,
	["VISUAL"] = theme.off_blue,
	["LINES"] = theme.red,
	["BLOCK"] = theme.orange,
	["REPLACE"] = theme.yellow,
	["V-REPLACE"] = theme.purple,
	["ENTER"] = theme.purple,
	["MORE"] = theme.purple,
	["SELECT"] = theme.red,
	["SHELL"] = theme.teal,
	["TERM"] = theme.off_blue,
	["NONE"] = theme.dark_gray,
	["COMMAND"] = theme.teal,
}

local modes = setmetatable({
	["n"] = "N",
	["no"] = "N",
	["v"] = "V",
	["V"] = "VL",
	[""] = "VB",
	["s"] = "S",
	["S"] = "SL",
	[""] = "SB",
	["i"] = "I",
	["ic"] = "I",
	["R"] = "R",
	["Rv"] = "VR",
	["c"] = "C",
	["cv"] = "EX",
	["ce"] = "X",
	["r"] = "P",
	["rm"] = "M",
	["r?"] = "C",
	["!"] = "SH",
	["t"] = "T",
}, {
	__index = function()
		return "-"
	end,
})

local component = {}

component.empty = {
	provider = function()
		return ""
	end,
	hl = function()
		return {
			bg = "bg",
		}
	end,
	left_sep = "",
	right_sep = "",
}
component.vim_mode = {
	provider = function()
		return modes[vim.api.nvim_get_mode().mode]
	end,
	hl = function()
		return {
			fg = "bg",
			bg = require("feline.providers.vi_mode").get_mode_color(),
			style = "bold",
			name = "NeovimModeHLColor",
		}
	end,
	left_sep = "block",
	right_sep = "block",
}

component.git_branch = {
	provider = "git_branch",
	hl = {
		fg = "light_gray_bright",
		bg = "bg",
		style = "bold",
	},
	left_sep = "block",
	right_sep = "",
	enabled = function ()
		return vim.api.nvim_win_get_width(0) > 80
	end
}

component.git_add = {
	provider = "git_diff_added",
	hl = {
		fg = "green",
		bg = "bg",
	},
	left_sep = "",
	right_sep = "",
}

component.git_delete = {
	provider = "git_diff_removed",
	hl = {
		fg = "red",
		bg = "bg",
	},
	left_sep = "",
	right_sep = "",
}

component.git_change = {
	provider = "git_diff_changed",
	hl = {
		fg = "purple",
		bg = "bg",
	},
	left_sep = "",
	right_sep = "",
}

component.separator = {
	provider = "",
	hl = {
		fg = "bg",
		bg = "bg",
	},
}

component.diagnostic_errors = {
	provider = "diagnostic_errors",
	hl = {
		fg = "red",
	},
}

component.diagnostic_warnings = {
	provider = "diagnostic_warnings",
	hl = {
		fg = "yellow",
	},
}

component.diagnostic_hints = {
	provider = "diagnostic_hints",
	hl = {
		fg = "glacier",
	},
}

component.diagnostic_info = {
	provider = "diagnostic_info",
}

component.lsp = {
	provider = "lsp_client_names",
	hl = function()
		return {
			fg =  "green",
			bg = "bg",
			style = "bold",
		}
	end,
	left_sep = "block",
	right_sep = "block",
	enabled = function ()
		return vim.api.nvim_win_get_width(0) > 80
	end
}

component.lazy_status = {
	provider = function ()
		local res = require("lazy.status").has_updates()
		if res then
			return tostring(require("lazy.status").updates())
		else
			return ""
		end
	end,
	hl = function()
		return {
			fg =  "orange",
			bg = "bg",
			style = "bold",
		}
	end,
	left_sep = "block",
	right_sep = "block",

}

component.file_type = {
	provider = {
		name = "file_type",
		opts = {
			filetype_icon = true,
			case = "lowercase",
		},
	},
	hl = {
		fg = "fg",
		bg = "bg",
	},
	left_sep = "block",
	right_sep = "block",
}
component.line_percentage = {
	provider = function()
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)

		if curr_line == 1 then
			return "󱔓 "
		elseif curr_line == lines then
			return "󱂩 "
		else
			return string.format("%2d%%%%", math.ceil(curr_line / lines * 99))
		end
	end,
	hl = function ()
		local position = math.floor(vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0) * 100)
		local fg
		local style

		if position <= 5 then
			fg = "glacier"
			style = "bold"
		elseif position >= 95 then
			fg = "red"
			style = "bold"
		else
			fg = "purple"
			style = nil
		end
		return {
			fg = fg,
			style = style,
			bg = "bg",
		}
	end,
	left_sep = " "
	,
	right_sep = "",
}

component.file_info = {
	provider = 'file_info',
	hl = {
		fg = "fg",
		bg = "bg",
		style = "bold",
	},
	left_sep = " ",
	right_sep = "",
}

component.current_position = {
	provider = function ()
		return fmt( " %3d:%-2d", unpack(vim.api.nvim_win_get_cursor(0)))
	end,
	hl = {
		fg = "fg",
		bg = "bg",
	},
	left_sep = "",
	right_sep = ""
}

component.search_count = {
	provider = 'search_count',
	hl = {
		fg = "fg",
		bg = "bg",
	},
	left_sep = "",
	right_sep = ""
}

component.scroll_bar = {
	provider = function()
		local opts = { reverse = true }
		local scroll_bar_blocks = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
		local curr_line = vim.api.nvim_win_get_cursor(0)[1]
		local lines = vim.api.nvim_buf_line_count(0)

		if opts.reverse then
			return string.rep(scroll_bar_blocks[8 - math.floor(curr_line / lines * 7)], 2)
		else
			return string.rep(scroll_bar_blocks[math.floor(curr_line / lines * 7) + 1], 2)
		end
	end,
	hl = function()
		local position = math.floor(vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0) * 100)
		local fg
		local style

		if position <= 5 then
			fg = "glacier"
			style = "bold"
		elseif position >= 95 then
			fg = "red"
			style = "bold"
		else
			fg = "purple"
			style = nil
		end
		return {
			fg = fg,
			style = style,
			bg = "bg",
		}
	end,
	left_sep = "|",
	right_sep = "",
}

local left = {
	component.vim_mode,
	component.file_info,
	-- component.file_type,
	component.git_add,
	component.git_delete,
	component.git_change,
}
local right = {
	component.separator,
	component.diagnostic_errors,
	component.diagnostic_warnings,
	component.diagnostic_info,
	component.diagnostic_hints,
	-- component.search_count,
	component.lazy_status,
	component.lsp,
	component.git_branch,
	-- component.current_position,
	component.line_percentage,
	-- component.scroll_bar
}

local components = {
	active = { left, right },
	inactive = { { component.empty }, { component.empty } },
}

return {
	feline.setup({
		components = components,
		theme = theme,
		vi_mode_colors = mode_theme,
		force_inactive = {
			filetypes = {"^neo%-tree$"},
			buftypes = {"^terminal$"},
			bufnames = {},
		}
	}),
}
