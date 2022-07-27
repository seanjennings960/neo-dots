neogit = {}

local function setup ()
  require('neogit').setup {
    disable_commit_confirmation = true,
    disable_insert_on_commit = false,
  }
end

neogit.setup = setup
return neogit
