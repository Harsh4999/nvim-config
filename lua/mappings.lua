require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('n', '<leader>nf', '<cmd>lua require("nvterm.terminal").new("float")<CR>', opts)
map('n', '<leader>tf', '<cmd>lua require("nvterm.terminal").toggle("float")<CR>', opts)
-- close buffer tab
map("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer" })
-- map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
