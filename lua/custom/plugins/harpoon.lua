-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin
local harpoon = require 'harpoon'

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end)
vim.keymap.set('n', '<C-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set('n', '<C-S-P>', function()
  harpoon:list():prev()
end)
vim.keymap.set('n', '<C-S-N>', function()
  harpoon:list():next()
end)
--
--
-- local mark = require 'harpoon.mark'
-- local ui = require 'harpoon.ui'
--
-- vim.keymap.set('n', '<c-p>', mark.add_file, { desc = 'add file to harpoon' })
-- vim.keymap.set('n', '<c-e>', ui.toggle_quick_menu, { desc = 'open harpoon' })
--
-- vim.keymap.set('n', '<c-n>', function()
--   ui.nav_next()
-- end, { desc = 'go to next file' })
-- vim.keymap.set('n', '<c-b>', function()
--   ui.nav_prev()
-- end, { desc = 'go to previous file' })
--
-- -- remaps
-- vim.api.nvim_set_keymap('x', '<leader>p', '"_dp', { noremap = true, silent = true })
-- -- vim: ts=2 sts=2 sw=2 et
