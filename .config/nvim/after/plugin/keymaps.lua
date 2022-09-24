local Remap = require("core.utils")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

-- Project View (netrw)
nnoremap("<leader>pv", ":Ex<CR>")

-- Navigation

-- behave like other capitals
nnoremap("Y", "y$")
-- keeping it centered
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
-- moving text
nnoremap("J", ":m '>+1<CR>gv=gv")
nnoremap("K", ":m '<-2<CR>gv=gv")
nnoremap("<leader>k", ":m .-2<CR>==")
nnoremap("<leader>j", ":m .+1<CR>==")

-- telescope
-- nnoremap("<leader>ps", function()
--     require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
-- end)
nnoremap("<Leader>sf", function()
    require('telescope.builtin').find_files({desc = "[S]earch [F]iles"})
end)
nnoremap("<leader>sw", function()
    require('telescope.builtin').grep_string({desc = "[S]earch current [W]ord"})
end)
nnoremap("<leader>sb", function()
    require('telescope.builtin').buffers({desc = "[S]earch []"})
end)
nnoremap("<leader>sh", function()
    require('telescope.builtin').help_tags({desc = "[S]earch [H]elp"})
end)
nnoremap('<leader>sg', function()
    require('telescope.builtin').live_grep({ desc = '[S]earch by [G]rep' })
end)
nnoremap('<leader>sd', function()
    require('telescope.builtin').diagnostics({ desc = '[S]earch [D]iagnostics' })
end)

-- diagnostics
nnoremap("[d", vim.diagnostic.goto_prev)
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("<leader>e", vim.diagnostic.open_float)
nnoremap("<leader>q", vim.diagnostic.setloclist)