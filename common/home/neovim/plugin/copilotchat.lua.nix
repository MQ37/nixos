''
require("CopilotChat").setup({
})

local chat = require("CopilotChat")
vim.keymap.set("n", "<leader>cpc", chat.toggle)
''

