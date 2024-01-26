''
require("copilot").setup({
  suggestion = {
    enabled = true,
    auto_trigger = false,
    keymap = {
      accept = "<Tab>",
      accept_word = false,
      accept_line = "<M-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  }
})

local suggestion = require("copilot.suggestion")
vim.keymap.set("n", "<leader>cpa", suggestion.toggle_auto_trigger)
''
