


vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.bg = "dark"

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- UI
vim.opt.mouse = "a"
vim.opt.signcolumn = "yes"
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Global border style for floating windows
local border_style = "rounded" -- options: "none", "single", "double", "rounded", "solid", "shadow"
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

-- Set default border for LSP floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border_style
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Backup/Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup('plugins')


-- Configure diagnostics to use borders
vim.diagnostic.config({
  float = {
    border = border_style,
  },
})

-- Auto-show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, focus = false })
  end
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Go to previous error' })
vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, { desc = 'Go to next error' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- Function to find references including superclass references
local function references_with_hierarchy()
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, 'textDocument/typeHierarchy', params, function(err, result, ctx)
    if err or not result then
      -- If type hierarchy not supported, just show regular references
      vim.cmd('Telescope lsp_references')
      return
    end

    -- Collect all items in hierarchy (supertypes)
    local hierarchy_items = { result }

    -- Get supertypes if available
    if result.parents then
      for _, parent in ipairs(result.parents) do
        table.insert(hierarchy_items, parent)
      end
    end

    -- Request references for each item in the hierarchy
    local all_references = {}
    local pending_requests = #hierarchy_items

    for _, item in ipairs(hierarchy_items) do
      local ref_params = {
        textDocument = { uri = item.uri },
        position = item.range.start,
        context = { includeDeclaration = true }
      }

      vim.lsp.buf_request(0, 'textDocument/references', ref_params, function(ref_err, refs)
        if not ref_err and refs then
          for _, ref in ipairs(refs) do
            table.insert(all_references, ref)
          end
        end

        pending_requests = pending_requests - 1
        if pending_requests == 0 then
          -- All requests done, show results
          if #all_references > 0 then
            vim.lsp.util.show_document_locations(all_references, 'utf-8')
          else
            vim.cmd('Telescope lsp_references')
          end
        end
      end)
    end
  end)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', '<cmd>Telescope lsp_type_definitions<cr>', opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<M-CR>', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', 'gR', references_with_hierarchy, { buffer = ev.buf, desc = 'References including superclasses' })
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
