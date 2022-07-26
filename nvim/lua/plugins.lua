local M = {}


-- Check if packer.nvim is installed
-- Run PackerCompile if there are changes in this file
local function packer_init()
  local bootstrapped = false
  local fn = vim.fn
  local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    bootstrapped = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
    }
    vim.cmd [[packadd packer.nvim]]
  end
  vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  return bootstrapped
end


function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  packer_bootstrap = packer_init()
    -- Plugins
    local function plugins()
        use { "wbthomason/packer.nvim" }

        -- Colorscheme
        -- use {
        --     "sainnhe/everforest",
        --     config = function()
        --         vim.cmd "colorscheme everforest"
        --     end,
        -- }

        -- Startup screen
        use {
            "goolord/alpha-nvim",
            config = function()
                require("config.alpha").setup()
            end,
        }

        -- Git
        -- use {
        --     "TimUntersberger/neogit",
        --     requires = "nvim-lua/plenary.nvim",
        --     config = function()
        --         require("config.neogit").setup()
        --     end,
        -- }

    end

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
    if packer_bootstrap then
        print "Restart Neovim required after installation!"
        require("packer").sync()
    end
end

return M
