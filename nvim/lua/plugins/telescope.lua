return {
    'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Telescope",  -- Load when any Telescope command is used
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<M-e>", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    },
    }
