vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- -- Run :NvimTreeToggle when nvim is started
-- vim.cmd "NvimTreeToggle"

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  command = "NvimTreeToggle",
})

-- set modifiable
vim.bo.modifiable = true


require'lspconfig'.pyright.setup{
  on_attach = function(client, bufnr)
    -- Optional: configure lsp-ts-utils or lspsaga here if needed
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
      -- pythonPath = function()
      --   local handle = io.popen('poetry env info -p')
      --   local result = handle:read("*a")
      --   handle:close()
      --   return result:match('([^\n]+)')
      -- end,
    },
  }
}
