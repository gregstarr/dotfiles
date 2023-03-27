vim.g.mapleader = " "

-- finds with telescope
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')
vim.keymap.set('n', '<leader>fF', function()
    builtin.find_files({ cwd = utils.buffer_dir() })
end)
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {}) -- Treesitter
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {}) -- Old
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fa', builtin.builtin, {}) -- All / Any
vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, {})
-- greP 
vim.keymap.set('n', '<leader>fP', function()
    vim.ui.input("Grep >", function (input)
        if input then
            builtin.grep_string({ search = input, cwd = utils.buffer_dir() })
        end
    end)
end)
vim.keymap.set('n', '<leader>fp', function()
    vim.ui.input("Grep >", function (input)
        if input then
            builtin.grep_string({ search = input })
        end
    end)
end)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {}) -- Help

-- conveniences
local napi = require('nvim-tree.api')
vim.keymap.set("n", "<leader>pv", napi.tree.toggle, {})
-- moves visual mode selection (lines) up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- centers on c-d and c-u
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- centers on search terms
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- replaces v mode text with put, doesn't spoil yank reg
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader><Enter>", ":nohlsearch<cr>:diffupdate<cr>")
vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- windows and buffers
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>")
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>")
vim.keymap.set("n", "<leader>bh", "<cmd>hide<cr>")
vim.keymap.set("n", "<leader>bo", "<cmd>only<cr>")
vim.keymap.set("n", "<leader>bq", "<cmd>cope<cr>")
vim.keymap.set("n", "<leader>bl", "<cmd>lop<cr>")
vim.keymap.set("n", "<leader>bt", "<cmd>Trouble<cr>")
vim.keymap.set("n", "<leader>bN", "<cmd>setlocal bufhidden=hide | enew<cr>")
vim.keymap.set("n", "<leader>v", "<cmd>vne<cr>")


local luasnip = require("luasnip")
vim.keymap.set("n", "<leader>j", function()
    if luasnip.expand_or_jumpable() then
        print("JUMPING")
        luasnip.expand_or_jump()
    else
        print("NOT JUMPABLE")
    end
end)

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {})
