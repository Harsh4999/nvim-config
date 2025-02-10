-- -- This file needs to have same structure as nvconfig.lua 
-- -- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- -- Please read that file to know all available options :( 
--
-- ---@type ChadrcConfig
-- local M = {}
--
-- M.base46 = {
-- 	theme = "onedark",
--
-- 	-- hl_override = {
-- 	-- 	Comment = { italic = true },
-- 	-- 	["@comment"] = { italic = true },
-- 	-- },
-- }
--
-- return M
--
-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "penumbra_dark",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

return M

