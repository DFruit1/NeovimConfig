return {
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<C-f>',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,

      -- Define formatters by file type, no nested curly braces
      formatters_by_ft = {
        -- HTML: 2 spaces indentation
        html = { 'prettier', args = { '--tab-width', '2' }, allow_project_config = true, stop_after_first = true },

        -- CSS: 2 spaces indentation
        css = { 'prettier', args = { '--tab-width', '2' }, allow_project_config = true, stop_after_first = true },

        -- SCSS: 2 spaces indentation
        scss = { 'prettier', args = { '--tab-width', '2' }, allow_project_config = true, stop_after_first = true },

        -- JavaScript: 2 spaces indentation
        javascript = { 'prettier', args = { '--tab-width', '2' }, allow_project_config = true, stop_after_first = true },

        -- TypeScript: 2 spaces indentation
        typescript = { 'prettier', args = { '--tab-width', '2' }, allow_project_config = true, stop_after_first = true },

        -- JSON: 2 spaces indentation
        json = { 'prettier', args = { '--tab-width', '2' }, allow_project_config = true, stop_after_first = true },

        -- Rust: 4 spaces indentation
        rust = { 'rustfmt', args = { '--edition', '2018' }, allow_project_config = true },

        -- Lua: 2 spaces indentation
        lua = { 'stylua', args = { '--indent-type', 'Spaces', '--indent-width', '2' }, allow_project_config = true },

        -- Python: Black with default line length 88
        python = { 'black', args = { '--line-length', '88' }, allow_project_config = true },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
