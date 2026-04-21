require("markycoo.lazy")
require("markycoo.keymap")
require("markycoo.set")

-- Disable nvim 0.11's built-in stylua LSP (stylua is used as a formatter via null-ls, not as an LSP)
vim.lsp.enable("stylua", false)

