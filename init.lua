vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.lsp.set_log_level("OFF")

vim.opt.rtp:prepend(lazypath)
vim.opt.clipboard = "unnamedplus"
local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

-- Theme is set in chadrc.lua (catppuccin)

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

require("configs.lspconfig")
require("options")
-- -- Run :NvimTreeToggle when nvim is started
-- vim.cmd "NvimTreeToggle"

-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   command = "NvimTreeToggle",
-- })
--
-- require('nvim-tree').setup {
--       view = {
--         width = 25,  -- Set the fixed width here
--         side = 'left',
--         preserve_window_proportions = false,
--       },
--   }
--
-- require('nvim-tree').setup {
--   view = {
--     width = 45,  -- Use width that works for you
--     side = 'left',
--     preserve_window_proportions = true,
--   },
--   update_focused_file = {
--     enable = true,
--     update_cwd = true,
--   },
--   sync_root_with_cwd = true,
--   respect_buf_cwd = true,
-- }




-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   callback = function()
--     -- Set the working directory to the current file’s directory
--     local cwd = vim.fn.getcwd()
--     vim.cmd("cd " .. cwd)
--
--     -- Delay to allow dashboard to load properly, then open NvimTree
--     vim.defer_fn(function()
--       vim.cmd("NvimTreeToggle")
--     end, 300)  -- Adjust the delay as needed
--   end,
-- })

-- set modifiable
vim.bo.modifiable = true

-- Auto-open Snacks explorer on the left when nvim is opened
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.defer_fn(function()
      Snacks.explorer()
    end, 100)
  end,
})


-- pyright setup moved to lua/configs/lspconfig.lua

require("codecompanion").setup({
  display = {
    chat = {
      window = {
        width = 0.2,
        relative = "editor"
      }
    }
  },
  adapters = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {

      })
    end,
  },
  strategies = {
    chat = {
      adapter = "copilot",
    }
  }
})

-- Set default theme to tokyonight
vim.g.tokyonight_style = "night"

--
-- vim.api.nvim_create_autocmd("VimEnter", {
--   pattern = "*",
--   callback = function()
--     -- Delay NvimTree toggle after everything has loaded
--     vim.defer_fn(function()
--       vim.cmd("NvimTreeToggle")
--     end, 200)  -- Delay of 100ms (adjust if necessary)
--   end,
-- })



require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}


-- Claude Code: disable ALL leader mappings in its terminal buffer
-- Only <Esc><Esc> remains active to close the window
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.defer_fn(function()
      local bufname = vim.api.nvim_buf_get_name(0)
      if bufname:lower():match("claude") or vim.b.claude_code_terminal then
        local buf = vim.api.nvim_get_current_buf()
        
        -- Send space directly to terminal, bypassing all mappings
        vim.keymap.set("t", "<Space>", function()
          local chan = vim.b.terminal_job_id
          if chan then
            vim.fn.chansend(chan, " ")
          end
        end, { buffer = buf, nowait = true, desc = "Literal space" })
        
        -- Keep <Esc><Esc> working to close Claude
        vim.keymap.set("t", "<Esc><Esc>", function()
          require("claude-code").toggle()
        end, { buffer = buf, nowait = true, desc = "Close Claude float" })
      end
    end, 100)
  end,
})

-- Global fallback for <Esc><Esc>
vim.keymap.set("t", "<Esc><Esc>", function()
  require("claude-code").toggle()
end, { desc = "Close Claude float" })


vim.keymap.set("n", "<leader>cc", function()
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":.")
      if name ~= "" then
        table.insert(buffers, name)
      end
    end
  end

  local context = "Open files:\n" .. table.concat(buffers, "\n")

  require("claude-code").toggle({
    prompt = context
  })
end, { desc = "Claude with open buffers context" })


vim.keymap.set("n", "<leader>ct", function()
  local dir = vim.fn.expand("%:p:h")
  local files = vim.fn.globpath(dir, "*.tf", false, true)
  local rel = {}

  for _, f in ipairs(files) do
    table.insert(rel, vim.fn.fnamemodify(f, ":."))
  end

  local context = "Terraform module files:\n" .. table.concat(rel, "\n")

  require("claude-code").toggle({
    prompt = context
  })
end, { desc = "Claude with Terraform module context" })
-- vim.keymap.set("n", "<leader>cc", function()
--   require("claude-code").toggle()
-- end, { desc = "Toggle Claude" })
