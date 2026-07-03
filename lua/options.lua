require "nvchad.options"
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "terraform", "tf", "tfvars" },
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
})
-- add yours here!

-- Notify on file save
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    Snacks.notify("Saved " .. vim.fn.expand("%:t"), { level = vim.log.levels.INFO, timeout = 1500 })
  end,
})

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- Custom statusline
vim.o.laststatus = 3

-- Mode names and colors
local mode_map = {
  ['n']    = { name = 'NORMAL',  hl = 'StatusLineMode' },
  ['i']    = { name = 'INSERT',  hl = 'StatusLineModeInsert' },
  ['v']    = { name = 'VISUAL',  hl = 'StatusLineModeVisual' },
  ['V']    = { name = 'V-LINE',  hl = 'StatusLineModeVisual' },
  ['']   = { name = 'V-BLOCK', hl = 'StatusLineModeVisual' },
  ['c']    = { name = 'COMMAND', hl = 'StatusLineModeCommand' },
  ['R']    = { name = 'REPLACE', hl = 'StatusLineModeReplace' },
  ['t']    = { name = 'TERMINAL', hl = 'StatusLineMode' },
}

-- Get git branch
local function git_branch()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
  if branch ~= "" then
    return "  " .. branch
  end
  return ""
end

-- Cache git branch (update on buffer enter)
local cached_branch = ""
vim.api.nvim_create_autocmd({"BufEnter", "FocusGained"}, {
  callback = function()
    cached_branch = git_branch()
  end,
})

-- Build statusline
function StatusLine()
  local mode = vim.fn.mode()
  local mode_info = mode_map[mode] or { name = mode, hl = 'StatusLineMode' }
  
  -- Left side: mode + filename + modified
  local left = string.format(
    " %%#%s# %s %%#StatusLine# %%f%%m%%r",
    mode_info.hl,
    mode_info.name
  )
  
  -- Right side: git branch + filetype + position
  local right = string.format(
    "%%#StatusLineGit#%s %%#StatusLine# %%Y  Ln %%l, Col %%c  %%p%%%% ",
    cached_branch
  )
  
  return left .. "%=" .. right
end

-- Set statusline
vim.o.statusline = "%!v:lua.StatusLine()"

-- Statusline colors
vim.api.nvim_set_hl(0, 'StatusLineMode', { fg = '#000000', bg = '#98c379', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineModeInsert', { fg = '#000000', bg = '#61afef', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineModeVisual', { fg = '#000000', bg = '#c678dd', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineModeCommand', { fg = '#000000', bg = '#e5c07b', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineModeReplace', { fg = '#000000', bg = '#e06c75', bold = true })
vim.api.nvim_set_hl(0, 'StatusLineGit', { fg = '#e5c07b', bg = '#3e4452' })

-- Hide statusline when terminal is visible
vim.api.nvim_create_autocmd("FileType", {
  pattern = "snacks_terminal",
  callback = function()
    vim.o.statusline = "%#Normal#"
  end,
})

-- Restore statusline when terminal closes
vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    vim.schedule(function()
      local has_terminal = false
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(win) then
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].buftype == "terminal" then
            has_terminal = true
            break
          end
        end
      end
      if not has_terminal then
        vim.o.statusline = "%!v:lua.StatusLine()"
      end
    end)
  end,
})
