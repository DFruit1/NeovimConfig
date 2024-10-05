return {
  -- Add the Rust Tools plugin
  {
    'simrat39/rust-tools.nvim',
    dependencies = 'nvim-lspconfig',
    config = function()
      local rt = require 'rust-tools'

      -- Set up rust-tools with desired configurations
      rt.setup {
        server = {
          on_attach = function(_, bufnr)
            -- Enable inlay hints when the LSP attaches to the buffer
            require('rust-tools').inlay_hints.enable()

            -- You can also add keybindings specific to Rust here
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, opts)
            vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, opts)
          end,
        },
        tools = {
          -- Customize inlay hints options
          inlay_hints = {
            show_parameter_hints = true,
            auto = true,
            only_current_line = true,
            parameter_hints_prefix = '<- ',
            other_hints_prefix = '=> ',
          },
          -- Executor for running code, termopen is used here
          executor = require('rust-tools.executors').termopen,
        },

        -- Configure hover actions and virtual text
        hover_actions = {
          auto_focus = false,
          border = {
            { '╭', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '╮', 'FloatBorder' },
            { '│', 'FloatBorder' },
            { '╯', 'FloatBorder' },
            { '─', 'FloatBorder' },
            { '╰', 'FloatBorder' },
            { '│', 'FloatBorder' },
          },
        },
      }
    end,
  },
}
