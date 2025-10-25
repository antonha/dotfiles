return {
  "stevearc/overseer.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    strategy = {
      "toggleterm",
      direction = "horizontal",
      open_on_start = true,
    },
    templates = { "builtin" },
  },
  keys = {
    { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
    { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run task" },
    { "<leader>oa", "<cmd>OverseerQuickAction<cr>", desc = "Quick action" },
    { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Task info" },
    { "<leader>ol", "<cmd>OverseerLoadBundle<cr>", desc = "Load task bundle" },
    { "<leader>os", "<cmd>OverseerSaveBundle<cr>", desc = "Save task bundle" },
  },
}
