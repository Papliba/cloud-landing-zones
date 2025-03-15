return { 
  'echasnovski/mini.nvim', version = '*',
  config = function ()
    require('mini.files').setup()
    -- Keymap for opening MiniFiles
    vim.keymap.set("n", "<Leader>e", function() MiniFiles.open() end, { desc = "Open MiniFiles" })
  end
}
