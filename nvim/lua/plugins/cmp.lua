return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "rcarriga/cmp-dap",
      "saghen/blink.compat",
    },
    event = "InsertEnter",
    opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    enabled = function()
      return vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
    end,
    sources = {
      default = function()
        if require("cmp_dap").is_dap_buffer() then
          return { "dap", "snippets", "buffer" }
        else
          return { "lsp", "path", "snippets", "buffer" }
        end
      end,
      providers = {
        dap = { name = "dap", module = "blink.compat.source" },
      },
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },
    signature = {
      enabled = true,
    },
  },
  opts_extend = { "sources.default" },
  },
}
