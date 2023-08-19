local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "kj", "<Esc>", default_opts)
keymap("t", "kj", "<C-\\><C-n>", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

keymap("n", ",,", "<C-^>", default_opts)

keymap("n", "msg", ":messages <CR>", default_opts)
keymap("n", "msgg", ":messages clear<CR>", default_opts)

keymap("n", ",d", "<cmd>lua require('telescope.builtin').find_files({cwd=vim.fn.expand('%:p:h')})<CR>", default_opts)

keymap("n", ",fo", "<cmd>Telescope lsp_document_symbols<CR>", default_opts)

keymap("n", "<leader>qr", "<cmd>lua require('fr.telescope').reload()<CR>", default_opts)
keymap("n", "<leader>pf", "<cmd>lua require('fr.telescope').project_files()<CR>", default_opts)

keymap("n", "<leader>ff", "<cmd>lua require('fr.finder').find_files()<CR>", default_opts)
