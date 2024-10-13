return {
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
        keymaps = {
          insert = false,
          insert_line = false,
          normal = '<leader>ys',
          normal_cur = '<leader>yss',
          normal_line = '<leader>yS',
          normal_cur_line = '<leader>ySS',
          visual = 's',
          visual_line = 'gs',
          delete = 'ds',
          change = 'cs',
          change_line = 'cS',
        },
      }
    end,
  },
}
