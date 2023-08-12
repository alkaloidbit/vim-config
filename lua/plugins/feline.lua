local present, feline = pcall(require, "feline")

if not present then return end

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
  yellow = "#FFE59E"
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
}, { __index = function() return "-" end })

local component = {}

component.vim_mode = {
  provider = function() return modes[vim.api.nvim_get_mode().mode] end,
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
  provider = function()
    if not rawget(vim, "lsp") then
      return ""
    end

    local progress = vim.lsp.status()[1]
    if vim.o.columns < 120 then
      return ""
    end

    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
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
  hl = function()
    local progress = vim.lsp.status()[1]
    return {
      fg = progress and "yellow" or "green",
      bg = "bg",
      style = "bold",
    }
  end,
  left_sep = "",
  right_sep = "block",
}

component.file_type = {
  provider = {
    name = "file_type",
    opts = {
      filetype_icon = true,
    },
  },
  hl = {
    fg = "fg",
    bg = "bg",
  },
  left_sep = "block",
  right_sep = "block",
}

component.scroll_bar = {
  provider = function()
    local chars = setmetatable({
      " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
      " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ",
    }, { __index = function() return " " end })
    local line_ratio = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
    local position = math.floor(line_ratio * 100)

    local icon = chars[math.floor(line_ratio * #chars)] .. position
    if position <= 5 then
      icon = " TOP"
    elseif position >= 95 then
      icon = " BOT"
    end
    return icon
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
  left_sep = "block",
  right_sep = "block",
}

local left = {
  component.vim_mode,
  component.file_type,
  component.lsp,
  component.git_branch,
  component.git_add,
  component.git_delete,
  component.git_change,
}
local middle = {}
local right = {
  component.separator,
  component.diagnostic_errors,
  component.diagnostic_warnings,
  component.diagnostic_info,
  component.diagnostic_hints,
  component.scroll_bar,
}

local components = {
  active = { left, middle, right },
}

feline.setup({
  components = components,
  theme = theme,
  vi_mode_colors = mode_theme,
})

-- feline.winbar.setup()

