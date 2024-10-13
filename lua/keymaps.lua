-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = false
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Function for insering predefined types along with their mappings
local function insertType(type)
  return function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { type .. '<>' })
    local new_col = col + #type + 2
    vim.api.nvim_win_set_cursor(0, { row, new_col }) -- Set the cursor position just before '>'
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>i', true, false, true), 'n', false)
  end
end

vim.keymap.set('i', '<C-a>', insertType 'Arc', { desc = 'Insert Arc type' })
vim.keymap.set('i', '<C-b>', insertType 'Box', { desc = 'Insert Box type' })
vim.keymap.set('i', '<C-c>', insertType 'Cell', { desc = 'Insert Cell type' })
vim.keymap.set('i', '<C-C>', insertType 'Cow', { desc = 'Insert Cow type' })
vim.keymap.set('i', '<C-E>', insertType 'Extension', { desc = 'Insert Extension type' })
vim.keymap.set('i', '<C-j>', insertType 'Json', { desc = 'Insert Json type' })
vim.keymap.set('i', '<C-m>', insertType 'Mutex', { desc = 'Insert Mutex type' })
vim.keymap.set('i', '<C-o>', insertType 'Option', { desc = 'Insert Option type' })
vim.keymap.set('i', '<C-P>', insertType 'Path', { desc = 'Insert Path type' })
vim.keymap.set('i', '<C-p>', insertType 'Pin', { desc = 'Insert Pin type' })
vim.keymap.set('i', '<C-q>', insertType 'Query', { desc = 'Insert Query type' })
vim.keymap.set('i', '<C-R>', insertType 'Request', { desc = 'Insert Request type' })
vim.keymap.set('i', '<C-r>', insertType 'Result', { desc = 'Insert Result type' })
vim.keymap.set('i', '<C-s>', insertType 'String', { desc = 'Insert String type' })
vim.keymap.set('i', '<C-T>', insertType 'Btreemap', { desc = 'Insert Btreemap type' })
vim.keymap.set('i', '<C-v>', insertType 'Vec', { desc = 'Insert Vec type' })
vim.keymap.set('i', '<C-w>', insertType 'Weak', { desc = 'Insert Weak type' })

vim.keymap.set('v', '<C-t>', function()
  local user_input = vim.fn.input 'Enter input: '
  if user_input == '' or user_input == nil then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
    return
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>bi' .. user_input .. '<<Esc>ea><Esc>', true, false, true), 'n', false)
end)

local function wrapType(type)
  return function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>bi' .. type .. '<<Esc>ea><Esc>', true, false, true), 'n', false)
  end
end

vim.keymap.set('s', 'a', wrapType 'Arc', { desc = 'Wrap current word with Arc' })
vim.keymap.set('s', 'b', wrapType 'Box', { desc = 'Wrap current word with Box' })
vim.keymap.set('s', 'c', wrapType 'Cell', { desc = 'Wrap current word with Cell' })
vim.keymap.set('s', 'C', wrapType 'Cow', { desc = 'Wrap current word with Cow' })
vim.keymap.set('s', 'E', wrapType 'Extension', { desc = 'Wrap current word with Extension' })
vim.keymap.set('s', 'j', wrapType 'Json', { desc = 'Wrap current word with Json' })
vim.keymap.set('s', 'm', wrapType 'Mutex', { desc = 'Wrap current word with Mutex' })
vim.keymap.set('s', 'o', wrapType 'Option', { desc = 'Wrap current word with Option' })
vim.keymap.set('s', 'P', wrapType 'Path', { desc = 'Wrap current word with Path' })
vim.keymap.set('s', 'p', wrapType 'Pin', { desc = 'Wrap current word with Pin' })
vim.keymap.set('s', 'q', wrapType 'Query', { desc = 'Wrap current word with Query' })
vim.keymap.set('s', 'R', wrapType 'Request', { desc = 'Wrap current word with Request' })
vim.keymap.set('s', 'r', wrapType 'Result', { desc = 'Wrap current word with Result' })
vim.keymap.set('s', 's', wrapType 'String', { desc = 'Wrap current word with String' })
vim.keymap.set('s', 'T', wrapType 'Btreemap', { desc = 'Wrap current word with Btreemap' })
vim.keymap.set('s', 'v', wrapType 'Vec', { desc = 'Wrap current word with Vec' })
vim.keymap.set('s', 'w', wrapType 'Weak', { desc = 'Wrap current word with Weak' })

-- delete surrounding type wrapper in <>
vim.keymap.set('s', 'd', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>F<dbxf>x', true, false, true), 'n', false)
end)

-- delete surrounding type wrapper in ()
vim.keymap.set('s', 'x', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>F(dbxf)x', true, false, true), 'n', false)
end)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-d>', '<c-d>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-d>', '<c-d>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-u>', '<c-u>zz', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-u>', '<c-u>zz', { noremap = true })

vim.api.nvim_set_keymap('n', 'Y', 'yiw', { noremap = true })
vim.api.nvim_set_keymap('n', 'P', 'viw"_dp', { noremap = true })

-- Save file with Ctrl+s
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>a', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-s>', '<Esc>:w<CR>gv', { noremap = true, silent = true })

-- Select all with Ctrl+a
vim.api.nvim_set_keymap('n', '<C-a>', 'ggVG', { noremap = true })

-- remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.api.nvim_set_keymap('n', '<CR>', ':put! _<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'x', [[getline('.') =~ '^$' ? 'dd' : 'x']], { noremap = true, expr = true, silent = true })
-- Set a keybinding to search for recent files using Telescope

vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sc', 'LiveGrep Neovim Config', {
  noremap = true,
  callback = function()
    require('telescope.builtin').live_grep {
      search_dirs = { '~/.config/nvim' }, -- Specify the Neovim config directory
    }
  end,
})
vim.api.nvim_set_keymap('n', '<Tab>', '<C-w>w', { noremap = true, silent = true })
-- vim: ts=2 sts=2 sw=2 et
