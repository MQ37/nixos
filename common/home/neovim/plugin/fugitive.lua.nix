''
vim.keymap.set("n", "<leader>gfs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gfw", vim.cmd.Gwrite)
vim.keymap.set("n", "<leader>gfd", vim.cmd.GDelete)
vim.keymap.set("n", "<leader>gfb", function()
    vim.cmd('Git blame')
end)
''
