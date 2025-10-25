return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function ()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "java",
        "typescript",
        "javascript",
        "svelte",
        "lua",
        "vim",
        "vimdoc",
        "html",
        "css",
        "json",
        "bash",
      },
    })
  end
}
