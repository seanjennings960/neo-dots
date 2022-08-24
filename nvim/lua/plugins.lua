local M = {}

-- Plugins
local function plugins()
  use { "wbthomason/packer.nvim" }

  -- Colorscheme
  -- use {
  --   "arcticicestudio/nord-vim",
  --   config = function()
  --     vim.cmd "colorscheme nord"
  --   end,
  -- }

  use {
      "sainnhe/everforest",
      config = function()
          vim.cmd "colorscheme everforest"
          -- For some reason the theme increases the height of the command bar?
          vim.cmd "set cmdheight=1"
      end,
  }

  -- Startup screen
  use {
    "goolord/alpha-nvim",
    config = function()
        require("config.alpha").setup()
    end,
  }

  -- TODO: Make this persistent across tabs.
  use {
    "preservim/nerdtree",
    config = function ()
      require("config.nerdtree").setup()
    end,
  }

  -- Status line support
  use {
    "nvim-lualine/lualine.nvim",
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require("config.status").setup()
    end,
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function ()
      require("config.bufferline").setup()
    end,
  }


  -- Git
  use {
      "TimUntersberger/neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
  }

  -- Smart-completion
  use {
    "neoclide/coc.nvim",
    branch = "release"
  }

  -- Javascript syntax highlighting
  use {
    "pangloss/vim-javascript"
  }
        

end

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
  -- Autoreload and compile when this plugins file is written.
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

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
  -- require("packer").sync()
  if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
  end
end

return M
