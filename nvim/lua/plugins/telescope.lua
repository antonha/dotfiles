return {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "NeoTree" },
    },
    }
