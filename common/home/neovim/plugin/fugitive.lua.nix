''
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gw", vim.cmd.Gwrite)
vim.keymap.set("n", "<leader>gd", vim.cmd.GDelete)
vim.keymap.set("n", "<leader>gb", function()
    vim.cmd('Git blame')
end)
''
