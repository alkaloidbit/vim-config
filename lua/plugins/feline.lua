-- Plugin: feline
-- https://github.com/feline-nvim/feline.nvim


return {

	-----------------------------------------------------------
	{
		'feline-nvim/feline.nvim',
		event = 'VeryLazy',
		opts = function()
			local icons = require("config.icons")
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

			vim.api.nvim_set_hl(0, "StatusLine", { bg = "#434C5E", fg = "#D8DEE9" })

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
				["n"] = "NORMAL",
				["no"] = "NORMAL",
				["v"] = "VISUAL",
				["V"] = "V-LINE",
				[""] = "V-BLOCK",
				["s"] = "SELECT",
				["S"] = "S-LINE",
				[""] = "S-BLOCK",
				["i"] = "INSERT",
				["ic"] = "I",
				["R"] = "REPLACE",
				["Rv"] = "VR",
				["c"] = "COMMAND",
				["cv"] = "EX",
				["ce"] = "X",
				["r"] = "P",
				["rm"] = "M",
				["r?"] = "C",
				["!"] = "SH",
				["t"] = "TERM",
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

			component.display_cwd = {
				provider = function()
					local result = vim.fn.getcwd()
					local home = os.getenv("HOME")
					if home and vim.startswith(result, home) then
						result = "~" .. result:sub(home:len() + 1)
					end
					return "󰝰 " .. result
				end,
				hl = function()
					return {
						fg = "off_blue",
						bg = "bg",
						style = "bold",
					}
				end,
				left_sep = " ",
				right_sep = "",
			}

			component.vim_mode = {
				provider = function()
					return modes[vim.api.nvim_get_mode().mode]
				end,
				hl = function()
					return {
						fg = require("feline.providers.vi_mode").get_mode_color(),
						bg = "bg",
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
				enabled = function()
					return vim.api.nvim_win_get_width(0) > 80
				end,
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

			component.lsp_status = {
				provider = function()
					if not rawget(vim, "lsp") then
						return ""
					end

					local progress = vim.lsp.util.get_progress_messages()[1]
					if vim.o.columns < 120 then
						return ""
					end

					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients ~= 0 then
						if progress then
							local spinners = {
								"◜ ",
								"◠ ",
								"◝ ",
								"◞ ",
								"◡ ",
								"◟ ",
							}
							local ms = vim.loop.hrtime() / 1000000
							local frame = math.floor(ms / 120) % #spinners
							local content = string.format("%%<%s", spinners[frame + 1])
							return content or ""
						else
							return "לּ LSP"
						end
					end
					return ""
				end,
				hl = {},
				left_sep = "",
				right_sep = "",
			}

			component.lsp = {
				provider = function(msg)
					msg = msg or ""
					local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })

					if next(buf_clients) == nil then
						if type(msg) == "boolean" or #msg == 0 then
							return ""
						end
						return msg
					end

					local buf_ft = vim.bo.filetype
					local buf_client_names = {}

					-- add client
					for _, client in pairs(buf_clients) do
						if client.name ~= "null-ls" then
							table.insert(buf_client_names, client.name)
						end
					end

					-- add formatter
					local lsp_utils = require("plugins.lsp.utils")
					local formatters = lsp_utils.list_formatters(buf_ft)
					vim.list_extend(buf_client_names, formatters)

					-- add linter
					local linters = lsp_utils.list_linters(buf_ft)
					vim.list_extend(buf_client_names, linters)

					-- add hover
					local hovers = lsp_utils.list_hovers(buf_ft)
					vim.list_extend(buf_client_names, hovers)

					-- add code action
					local code_actions = lsp_utils.list_code_actions(buf_ft)
					vim.list_extend(buf_client_names, code_actions)

					local hash = {}
					local client_names = {}
					for _, v in ipairs(buf_client_names) do
						if not hash[v] then
							client_names[#client_names + 1] = v
							hash[v] = true
						end
					end
					table.sort(client_names)
					return icons.ui.Code .. " " .. table.concat(client_names, ", ") .. " " .. icons.ui.Code .. " "
				end,
				hl = function()
					return {
						fg = "green",
						bg = "bg",
						style = "bold",
					}
				end,
				left_sep = " ",
				right_sep = "",
				enabled = function()
					return vim.api.nvim_win_get_width(0) > 80
				end,
			}

			component.lazy_status = {
				provider = function()
					local res = require("lazy.status").has_updates()
					if res then
						return tostring(require("lazy.status").updates())
					else
						return ""
					end
				end,
				hl = function()
					return {
						fg = "orange",
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
				hl = function()
					local position = math.floor(vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0) * 100)
					local fg
					local style

					if position <= 5 then
						fg = "green"
						style = "bold"
					elseif position >= 95 then
						fg = "orange"
						style = "bold"
					else
						fg = "yellow"
						style = nil
					end
					return {
						fg = fg,
						style = style,
						bg = "bg",
					}
				end,
				left_sep = " ",
				right_sep = "",
			}

			component.file_info = {
				provider = "file_info",
				hl = {
					fg = "fg",
					bg = "bg",
					style = "bold",
				},
				left_sep = " ",
				right_sep = "",
			}

			component.current_position = {
				provider = function()
					return fmt(" %3d:%-2d", unpack(vim.api.nvim_win_get_cursor(0)))
				end,
				hl = {
					fg = "fg",
					bg = "bg",
				},
				left_sep = "",
				right_sep = "",
			}

			component.search_count = {
				provider = "search_count",
				hl = {
					fg = "fg",
					bg = "bg",
				},
				left_sep = "",
				right_sep = "",
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
				-- component.file_info,
				component.display_cwd,
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
				-- component.lsp_status,
				-- component.lazy_status,
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
				components = components,
				theme = theme,
				vim_mode_colors = mode_theme,
				force_inactive = {
					filetypes = { "^neo%-tree$" },
					buftypes = { "^terminal$" },
					bufnames = {},
				},
			}
		end,
	}
}
