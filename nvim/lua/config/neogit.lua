neogit = {}

local function setup ()
  require('neogit').setup {
    disable_commit_confirmation = true,
    disable_insert_on_commit = false,
  }
  vim.keymap.set('n', '<C-x>x', ':Neogit<Cr>')
end

neogit.setup = setup
return neogit
