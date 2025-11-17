return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require("Comment").setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })

    -- Alt+/ to toggle comment in normal and visual mode
    vim.keymap.set('n', '<M-/>', '<Plug>(comment_toggle_linewise_current)',
      { desc = 'Toggle comment on current line' })
    vim.keymap.set('v', '<M-/>', '<Plug>(comment_toggle_linewise_visual)',
      { desc = 'Toggle comment on selection' })
  end,
}
