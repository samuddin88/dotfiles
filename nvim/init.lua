-- Main Neovim entry point
-- Remapping <Space> to leader and the sequence of `require` directives should not be reordered 
--
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config")
require("plugins")
