return {
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    config = function()
      local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
      require("dap-python").setup(python)
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup DAP UI
      dapui.setup()

    -- Auto open/close DAP UI
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Keybindings
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue debugging" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
    vim.keymap.set("n", "<leader>dr", function()
      dap.repl.toggle()
      -- Find and focus the REPL window
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype == "dap-repl" then
          vim.api.nvim_set_current_win(win)
          vim.cmd("startinsert")
          break
        end
      end
    end, { desc = "Toggle REPL" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate debugging" })
  end,
  },
}
