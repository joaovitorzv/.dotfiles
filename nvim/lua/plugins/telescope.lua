local u = require("utils")
--Add leader shortcuts
u.map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
u.map('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
u.map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
u.map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
u.map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
u.map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

require('telescope').setup {
  defaults = {
    mppings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
