return {
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		enabled = false,
		config = function(_, _)
			require("mini.animate").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
	{
    "echasnovski/mini.clue",
    cond = function()
      return require("config").keymenu.mini_clue
    end,
    event = "VeryLazy",
    opts = function()
      local map_leader = function(suffix, rhs, desc)
        vim.keymap.set({ "n", "x" }, "<Leader>" .. suffix, rhs, { desc = desc })
      end
      map_leader("w", "<cmd>update!<CR>", "Save")
      map_leader("qq", require("utils").quit, "Quit")
      map_leader("qt", "<cmd>tabclose<cr>", "Close Tab")
      -- map_leader("sc", require("utils.coding").cht, "Cheatsheets")
      -- map_leader("so", require("utils.coding").stack_overflow, "Stack Overflow")

      local miniclue = require "mini.clue"
      return {
        window = {
          delay = vim.o.timeoutlen,
        },
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = {
          { mode = "n", keys = "<Leader>a", desc = "+AI" },
          { mode = "x", keys = "<Leader>a", desc = "+AI" },
          { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
          { mode = "n", keys = "<Leader>d", desc = "+Debug" },
          { mode = "x", keys = "<Leader>d", desc = "+Debug" },
          { mode = "n", keys = "<Leader>D", desc = "+Database" },
          { mode = "n", keys = "<Leader>f", desc = "+File" },
          { mode = "n", keys = "<Leader>h", desc = "+Help" },
          { mode = "n", keys = "<Leader>j", desc = "+Jump" },
          { mode = "n", keys = "<Leader>g", desc = "+Git" },
          { mode = "x", keys = "<Leader>g", desc = "+Git" },
          { mode = "n", keys = "<Leader>gh", desc = "+Hunk" },
          { mode = "x", keys = "<Leader>gh", desc = "+Hunk" },
          { mode = "n", keys = "<Leader>gt", desc = "+Toggle" },
          { mode = "n", keys = "<Leader>n", desc = "+Notes" },
          { mode = "n", keys = "<Leader>l", desc = "+Language" },
          { mode = "x", keys = "<Leader>l", desc = "+Language" },
          { mode = "n", keys = "<Leader>lg", desc = "+Annotation" },
          { mode = "n", keys = "<Leader>lx", desc = "+Swap Next" },
          { mode = "n", keys = "<Leader>lxf", desc = "+Function" },
          { mode = "n", keys = "<Leader>lxp", desc = "+Parameter" },
          { mode = "n", keys = "<Leader>lxc", desc = "+Class" },
          { mode = "n", keys = "<Leader>lX", desc = "+Swap Previous" },
          { mode = "n", keys = "<Leader>lXf", desc = "+Function" },
          { mode = "n", keys = "<Leader>lXp", desc = "+Parameter" },
          { mode = "n", keys = "<Leader>lXc", desc = "+Class" },
          { mode = "n", keys = "<Leader>p", desc = "+Project" },
          { mode = "n", keys = "<Leader>q", desc = "+Quit/Session" },
          { mode = "x", keys = "<Leader>q", desc = "+Quit/Session" },
          { mode = "n", keys = "<Leader>r", desc = "+Refactor" },
          { mode = "x", keys = "<Leader>r", desc = "+Refactor" },
          { mode = "n", keys = "<Leader>s", desc = "+Search" },
          { mode = "x", keys = "<Leader>s", desc = "+Search" },
          { mode = "n", keys = "<Leader>t", desc = "+Test" },
          { mode = "n", keys = "<Leader>tN", desc = "+Neotest" },
          { mode = "n", keys = "<Leader>to", desc = "+Overseer" },
          { mode = "n", keys = "<Leader>v", desc = "+View" },
          { mode = "n", keys = "<Leader>z", desc = "+System" },

          -- Submodes
          { mode = "n", keys = "<Leader>tNF", postkeys = "<Leader>tN" },
          { mode = "n", keys = "<Leader>tNL", postkeys = "<Leader>tN" },
          { mode = "n", keys = "<Leader>tNa", postkeys = "<Leader>tN" },
          { mode = "n", keys = "<Leader>tNf", postkeys = "<Leader>tN" },
          { mode = "n", keys = "<Leader>tNl", postkeys = "<Leader>tN" },
          { mode = "n", keys = "<Leader>tNn", postkeys = "<Leader>tN" },
          { mode = "n", keys = "<Leader>tNN", postkeys = "<Leader>tN" },
          { mode = "n", keys = "<Leader>tNo", postkeys = "<Leader>tN" },
          { mode = "n", keys = "<Leader>tNs", postkeys = "<Leader>tN" },
          { mode = "n", keys = "<Leader>tNS", postkeys = "<Leader>tN" },

          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows {
            submode_move = false,
            submode_navigate = false,
            submode_resize = true,
          },
          miniclue.gen_clues.z(),
        },
      }
    end,
  }
}
