-- require "nvchad.mappings"
--
-- -- add yours here
--
-- local map = vim.keymap.set
--
-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
--
-- -- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- --
require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('n', '<leader>nf', '<cmd>lua require("nvterm.terminal").new("float")<CR>', opts)
map('n', '<leader>tf', '<cmd>lua require("nvterm.terminal").toggle("float")<CR>', opts)
-- close buffer tab
map("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })
map("n","<leader>fg", ":Telescope live_grep<CR>", { desc = "Search in files" })
map("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition", noremap = true, silent = true })
-- map("n", "<leader>f", ":Prettier<CR>", { desc = "Format file" })
-- map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
vim.api.nvim_set_keymap("i","<C-l>","copilot#Accept()", { desc = "Accept copilot suggestion", noremap = true, silent = true, expr = true })

-- Function to toggle the terminal using Snacks.terminal
function ToggleSnacksTerminal()
    -- Exit terminal mode if needed
    if vim.fn.mode() == 't' then
        vim.cmd([[stopinsert]])
    end
    -- Toggle terminal using Snacks
    Snacks.terminal.toggle()
end

-- Keybindings for normal mode and terminal mode
vim.api.nvim_set_keymap("n", "<leader>st", ":lua ToggleSnacksTerminal()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>st", [[<C-\><C-n>:lua ToggleSnacksTerminal()<CR>]], { noremap = true, silent = true })

-- Hide all terminals with <leader>0
function HideAllTerminals()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) then
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].buftype == "terminal" then
        vim.api.nvim_win_hide(win)
      end
    end
  end
end
map("n", "<leader>0", HideAllTerminals, { desc = "Hide all terminals" })
map("t", "<leader>0", function()
  vim.cmd("stopinsert")
  HideAllTerminals()
end, { desc = "Hide all terminals" })

-- Multiple numbered Snacks terminals (1-5)
-- Usage: <leader>1 opens terminal 1, <leader>2 opens terminal 2, etc.
-- Each number is a separate persistent terminal you can switch between.
for i = 1, 5 do
  -- Use feedkeys to simulate count prefix for unique terminal IDs
  local keys = vim.api.nvim_replace_termcodes(i .. "<Cmd>lua Snacks.terminal.toggle()<CR>", true, false, true)
  map("n", "<leader>" .. i, function()
    vim.api.nvim_feedkeys(keys, "n", false)
  end, { desc = "Terminal " .. i })
  map("t", "<leader>" .. i, function()
    vim.cmd("stopinsert")
    vim.api.nvim_feedkeys(keys, "n", false)
  end, { desc = "Terminal " .. i })
end

-- Navigate between windows from terminal mode without closing the terminal
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Navigate left window" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Navigate down window" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Navigate up window" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Navigate right window" })

-- Git / Diffview keybinds
map("n", "<leader>gD", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview (all changes)" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history (current file)" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "File history (all files)" })
map("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
map("n", "<leader>gn", "<cmd>Neogit<cr>", { desc = "Open Neogit" })

-- Lazygit in floating terminal (with TERM fix)
map("n", "<leader>gg", function()
  Snacks.terminal.toggle("TERM=xterm-256color lazygit", {
    win = {
      position = "float",
      width = 0.9,
      height = 0.9,
    },
  })
end, { desc = "Lazygit" })

-- Splits
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal split sizes" })

-- Fix Telescope opening in terminal window: jump to first normal window first
local function focus_main_window()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bt = vim.bo[buf].buftype
    -- Skip terminal, nofile (scratch), prompt, quickfix, etc.
    if bt == "" or bt == "acwrite" then
      vim.api.nvim_set_current_win(win)
      return true
    end
  end
  return false
end

-- Override <leader>ff to always open in main editor window
map("n", "<leader>ff", function()
  focus_main_window()
  vim.cmd("Telescope find_files")
end, { desc = "Find files (in main window)" })

-- Same fix for <leader>sf (Snacks picker)
map("n", "<leader>sf", function()
  focus_main_window()
  Snacks.picker.files()
end, { desc = "Find files (Snacks)" })

-- Keybindings cheatsheet
map("n", "<leader>?", function()
  local keybinds_file = vim.fn.stdpath("config") .. "/KEYBINDS.md"
  Snacks.win({
    file = keybinds_file,
    width = 0.6,
    height = 0.8,
    wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
  })
end, { desc = "Keybindings cheatsheet" })
