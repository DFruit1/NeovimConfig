-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    callback = function()
      -- check if neovim was started without file arguments
      if #vim.fn.argv() == 0 and vim.fn.argc() == 0 then
        -- execute `telescope.oldfiles`
        vim.cmd 'Telescope oldfiles'
      end
    end,
  })
end

return M
