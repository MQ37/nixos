''
local copilot = require("copilot")

copilot.setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = "<M-;>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = true,
    markdown = true,
    ["."] = true,
  }
})

vim.keymap.set("n", "<leader>cpa", ":Copilot toggle<CR>", { noremap = true, silent = true })
''
