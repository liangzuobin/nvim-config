vim.g.mapleader = ','
local keymap = vim.keymap

keymap.set('n', '<leader>q', '<cmd>q<cr>')
keymap.set('n', '<leader>w', '<cmd>w<cr>')
keymap.set('n', '<leader>x', '<cmd>x<cr>')

-- keymap.set('n', '<c-a>', 'gg<S-v>G')

keymap.set('n', '<leader>s', ':vsplit<Return><C-w>w', { silent = true })
-- keymap.set('n', 'f', '<C-w>w')

keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')

-- plugins keymap
keymap.set('n', '<space>ta', '<cmd>ToggleAlternate<cr>')
require('nvim-autopairs').setup({
  disable_filetype = { 'TelescopePrompt', 'vim' }
})
