M = {}

function M.setup ()
  -- FIXME: Tabline seams a bit wonky. Does not remove
  -- old files.
  vim.opt.termguicolors = true
  require("bufferline").setup()
end

return M
