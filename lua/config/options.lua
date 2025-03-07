local opt = vim.opt

opt.foldlevel = 99
opt.foldlevelstart = 99
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.foldcolumn = "1"
opt.foldenable = true
-- opt.foldmethod = "indent"

opt.laststatus = 3 -- global statusline

opt.colorcolumn=""

vim.g.nord_contrast = false
vim.g.nord_borders = false
vim.g.disable_background = false
vim.g.nord_italic = false
vim.g.nord_cursorline_transparent = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = true

vim.wo.number = true
vim.wo.relativenumber = true

config = require("core.utils").load_config()

vim.opt.statusline = "%!v:lua.require('plugins.ui.statusline." .. config.ui.statusline.theme .. "').run()"
