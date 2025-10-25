return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "folke/neodev.nvim", opts = {} }

  },

  config = function()
    require("mason").setup()

    -- Get capabilities from blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    require('mason-lspconfig').setup({
      ensure_installed = {
        "pyright",  -- Python LSP
        "lua_ls",   -- Lua LSP
      },
      handlers = {
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities,
            }
        end,
        ["pyright"] = function ()
            require("lspconfig").pyright.setup {
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                  }
                }
              }
            }
        end,
      }
    })
  end
}
