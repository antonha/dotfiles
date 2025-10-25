return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    require("venv-selector").setup({
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
      fd_binary_name = "fdfind",  -- Use system find if fd not available
      auto_refresh = true,
    })
  end,
  event = "VeryLazy",  -- Auto-load on startup
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached VirtualEnv" },
  },
}
