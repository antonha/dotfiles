return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function ()
      require("lualine").setup({
        options = {
          theme = "catppuccin"
        },
        sections = {
          lualine_c = {
            {
              'filename',
              path = 1,  -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = absolute with tilde for home
              shorting_target = 40,  -- Shorten when path exceeds this length
            }
          }
        }
      })
    end
}
