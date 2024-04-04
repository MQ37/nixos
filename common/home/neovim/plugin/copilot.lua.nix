''
require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = false,
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

local suggestion = require("copilot.suggestion")
vim.keymap.set("n", "<leader>cpa", suggestion.toggle_auto_trigger)
''
