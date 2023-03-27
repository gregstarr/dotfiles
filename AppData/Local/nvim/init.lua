vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require('plugins')
require('options')
require('remaps')
require("luasnip.loaders.from_lua").load({paths="./lua/snippets"})
