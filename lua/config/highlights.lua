-- CursorLine & CursorColumn Styling
vim.api.nvim_set_hl(0, 'CursorLine', { underline = true, sp = '#ff0000', bg = 'NONE' })  -- Bright red underline, no forced background
vim.api.nvim_set_hl(0, 'CursorColumn', { bg = 'NONE' })  -- Remove forced background for a cleaner look
