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

keymap("n", ",d", "<cmd>lua require('telescope.builtin').find_files({cwd=vim.fn.expand('%:p:h'), prompt_title=' Files in Current Buffer Dir '})<CR>", default_opts)

keymap("n", ",fo", "<cmd>Telescope lsp_document_symbols<CR>", default_opts)

keymap("n", "<leader>qr", "<cmd>lua require('fr.telescope').reload()<CR>", default_opts)
keymap("n", "<localleader>df", "<cmd>lua require('fr.telescope').dotfiles()<CR>", default_opts)

-- alternate keymap for telescope.project_files()
-- keymap("n", "<leader>pf", "<cmd>lua require('fr.telescope').project_files()<CR>", default_opts)

-- Fzf-lua find files
-- keymap("n", "<leader>ff", "<cmd>lua require('fr.finder').find_files()<CR>", default_opts)

-- Fzf-lua find dotfiles
-- keymap("n", ";do", "<cmd>lua require('fr.finder').find_dotfiles()<CR>", default_opts)

-- TODO change this keymap to something else
keymap("n", "<leader>ch", "<cmd>lua require('fr.cht').cht()<CR>", default_opts)

keymap("n", "[c", "<cmd>lua require('treesitter-context').go_to_context()<CR>", default_opts)
