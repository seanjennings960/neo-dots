local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"
  local function header()
    return {
      [[   ,gggggggggggg,                                    ]],
      [[  dP"""88""""""Y8b,                                  ]],
      [[  Yb,  88       `8b,                                 ]],
      [[  `"  88        `8b                                  ]],
      [[    88         Y8                                    ]],
      [[    88         d8   ,ggggg,    gg,gggg,     ,ggg,    ]],
      [[    88        ,8P  dP"  "Y8ggg I8P"  "Yb   i8" "8i   ]],
      [[    88       ,8P' i8'    ,8I   I8'    ,8i  I8, ,8I   ]],
      [[    88______,dP' ,d8,   ,d8'  ,I8 _  ,d8'  `YbadP'   ]],
      [[    888888888P"   P"Y8888P"    PI8 YY88888P888P"Y888 ]],
      [[                               I8                   ]],
      [[                               I8                   ]],
      [[                               I8                   ]],
      [[                               I8                   ]],
      [[                               I8                   ]],
      [[                               I8                   ]],


    }
  end

  dashboard.section.header.val = header()

  local plugin_path = vim.fn.stdpath('config') .. '/lua/plugins.lua'
  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    -- dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("c", "  Configuration", ":e " .. plugin_path .. " <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    -- Number of plugins
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y  %H:%M:%S"
    local plugins_text = "\t" .. total_plugins .. " plugins  " .. datetime

    -- Quote
    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
