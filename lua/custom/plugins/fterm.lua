vim.pack.add { 'https://github.com/numToStr/FTerm.nvim' }
require('FTerm').setup {}

vim.keymap.set('n', '<leader>tt', function() require('FTerm').toggle() end, { desc = '[T]oggle floating [T]erminal' })
vim.keymap.set('t', '<leader>tt', '<C-\\><C-n><Cmd>lua require("FTerm").toggle()<CR>', { desc = '[T]oggle floating [T]erminal' })
