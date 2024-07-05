''
require("CopilotChat").setup({
})

local chat = require("CopilotChat")
vim.keymap.set({"n", "v"}, "<leader>cpc", chat.toggle)
''

