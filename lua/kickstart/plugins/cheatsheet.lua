return {
  -- Lazy.nvim setup for loading Legendary.nvim
  {
    'mrjones2014/legendary.nvim',
    -- Optional dependencies: SQLite for caching, Which-Key for keymap display
    dependencies = {
      { 'kkharji/sqlite.lua' }, -- Optional: for better caching
      { 'folke/which-key.nvim' }, -- Optional: integrates with which-key
    },
    -- Load Legendary when you press a specific key or command
    keys = {
      { '<leader>lc', ':Legendary<CR>', desc = 'Open Legendary' }, -- Keybinding for opening Legendary
    },
    -- Lazy-load Legendary.nvim when the command is called or on specific events
    cmd = 'Legendary', -- Load Legendary when :Legendary command is run
    event = 'VeryLazy', -- Alternatively, load it when Vim enters a lazy state
    config = function()
      require('legendary').setup {
        -- Add keymaps with descriptions to be managed by Legendary
        keymaps = {
          { '<leader>ff', ':Telescope find_files<CR>', description = 'Find Files' },
          { '<leader>fg', ':Telescope live_grep<CR>', description = 'Live Grep' },
          { '<leader>fb', ':Telescope buffers<CR>', description = 'List Buffers' },
        },

        -- Optional settings
        include_builtin = true, -- Automatically add Neovim's built-in keymaps
        include_legendary_cmds = true, -- Automatically add commands created by legendary
        auto_register_which_key = true, -- Automatically integrate with which-key

        -- Optionally sort keymaps, commands, and autocmds automatically by their description
        sort = {
          keymaps = true,
          commands = true,
          autocmds = true,
        },
      }
    end,
  },
}
