-- Leader Key
vim.g.mapleader = " "  -- Set leader key to space

-- UI Enhancements
vim.opt.number = true               -- Show absolute line numbers
vim.opt.relativenumber = true       -- Enable relative line numbers
vim.opt.cursorline = true           -- Highlight the current line
vim.opt.cursorcolumn = true         -- Highlight the current column (vertical)
vim.opt.cursorlineopt = 'both'      -- Highlight both line and number
vim.opt.termguicolors = true        -- Enable 24-bit color support
vim.opt.wrap = true                 -- Enable line wrapping

-- Clipboard
vim.opt.clipboard = "unnamed,unnamedplus" -- Use system clipboard

-- Disable Netrw (If using nvim-tree)
vim.g.loaded_netrw = 1             
vim.g.loaded_netrwPlugin = 1       

-- Indentation
vim.opt.tabstop = 2                 -- Tab width = 2 spaces
vim.opt.shiftwidth = 2              -- Auto-indent width = 2 spaces
vim.opt.softtabstop = 2             -- Consistent backspacing
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.autoindent = true           -- Maintain indentation from previous line
vim.opt.smartindent = true          -- Smart indenting based on syntax

