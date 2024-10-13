---@diagnostic disable: missing-fields
return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load {
                paths = { '~/.config/nvim/lua/snippets' }, -- Rust10x snippets
              }
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      { 'roobert/tailwindcss-colorizer-cmp.nvim', config = true },
      opts = function(_, opts)
        local format_kinds = opts.formatting.format
        opts.formatting.format = function(entry, item)
          format_kinds(entry, item) -- add icons
          return require('tailwindcss-colorizer-cmp').formatter(entry, item)
        end
      end,
      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      luasnip.config.setup {
        history = true, -- Enable history, so you can jump back into previous snippets.
        updateevents = 'TextChanged,TextChangedI', -- Automatically update snippets as you type.
        region_check_events = 'InsertEnter', -- Ensure snippets work when you enter insert mode.
        delete_check_events = 'InsertLeave', -- Check if a snippet needs to be deleted on leaving insert mode
        enable_autosnippets = true,
      }

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect',
          keyword_length = 5,
        },
        performance = {
          debounce = 60,
          throttle = 60,
        },
        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-PageUp>'] = cmp.mapping.scroll_docs(-4),
          ['<C-PageDown>'] = cmp.mapping.scroll_docs(4),
          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item() -- Select next item when Tab is pressed
            else
              fallback() -- If the completion menu is not visible, fallback to normal tabbing behavior
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item() -- Select previous item when Shift+Tab is pressed
            else
              fallback() -- If the completion menu is not visible, fallback to normal Shift+Tab behavior
            end
          end, { 'i', 's' }), -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-c>'] = cmp.mapping.complete {},
          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          -- ['<C-l>'] = cmp.mapping(function()
          --   if luasnip.expand_or_locally_jumpable() then
          --     luasnip.expand_or_jump()
          --   end
          -- end, { 'i', 's' }),
          -- ['<C-h>'] = cmp.mapping(function()
          --   if luasnip.locally_jumpable(-1) then
          --     luasnip.jump(-1)
          --   end
          -- end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
        enabled = true, -- enable the completion plugin (can be a boolean or function)
      }
    end,
  },

  {
    'litoj/colorizer.nvim',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        -- can be a boolean, or:
        -- table like {Name='#colorhex'},
        -- function returning such table (for colorscheme-dependant updates),
        -- "nvim": for all neovim "Name" codes like Blue ...,
        -- "tailwind" (_lsp/_both): for tailwind/css-like color names
        names = 'tailwind',
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        -- tailwind = true,
        mode = 'background', -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        -- parsers can contain values used in |user_default_options|
        virtualtext = '■',
        -- update color values even if buffer is not focused
        always_update = true,
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
