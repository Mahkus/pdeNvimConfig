-- List of all the keymaps configured
-- vim.keymap.set("n", "<leader>fe", vim.cmd.Ex) -- Press <SPACE> + f + e to open vim explorer

-- List of Telescope keymaps configured
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" }) -- Press <SPACE> + f + f to fuzzy search for files 
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' }) -- Press <SPACE> + f + g to grep serach in files
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' }) -- Press <SPACE> + f + b to 
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' }) 

-- List of Lazy keymaps configured
vim.keymap.set('n', '<leader>ll', vim.cmd.Lazy)

-- keymap to open terminal
vim.keymap.set("n", "<leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd('wincmd J')
    vim.cmd('resize 27')
end)

-- keymap to close nvim
vim.keymap.set("n", "<leader>qq", ":qa!<CR>", { desc = "Force Quit All" })

