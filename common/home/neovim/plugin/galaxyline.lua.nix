''
local colors = {
    bg = '#202328',
    fg = '#bbc2cf',
    yellow = '#ecbe7b',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#ff8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67',
}

local galaxyline = require('galaxyline')

-- file size
galaxyline.section.left[1] = {
  FileSize = {
    provider = 'FileSize',
    condition = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    icon = ' 📂 ',
    separator = '|',
  },
}
-- file name
galaxyline.section.left[2] = {
  FileName = {
    provider = 'FileName',
    condition = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    separator = '|',
  },
}
-- branch
galaxyline.section.left[3] = {
  GitBranch = {
    provider = 'GitBranch',
    icon = ' 🌳 ',
    separator = '|',
  },
}


-- lsp client
galaxyline.section.mid[1] = {
  LspClient = {
    provider = 'GetLspClient',
    icon = ' 🚀 ',
    separator = '|',
  },
}


-- line percent
galaxyline.section.right[4] = {
  LinePercent = {
    provider = 'LinePercent',
    separator = '|',
  },
}
-- line column
galaxyline.section.right[3] = {
  LineColumn = {
    provider = 'LineColumn',
    separator = '|',
  },
}
-- file format
galaxyline.section.right[2] = {
  FileType = {
    provider = 'FileFormat',
    separator = '|',
  },
}
-- file encoding
galaxyline.section.right[1] = {
  FileEncoding = {
    provider = 'FileEncode',
    separator = '|',
  },
}
''
