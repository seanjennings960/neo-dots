M = {}

function M.setup ()
  local eval = vim.api.nvim_eval
  local km_set = vim.keymap.set
  local autocmd = vim.api.nvim_create_autocmd

  -- Opening new projects.
  km_set('n', '<C-f>p', '<Cmd>tabdo NERDTreeVCS<Cr>',
         {desc='Focus on Nerd tree window in current tab'})
  km_set('n', '<C-f>o',
         '<Cmd>tabdo NERDTreeMirror | NERDTreeFocus<Cr>')

  local function nt_selected ()
    return eval('g:NERDTree.GetWinNum() ==# winnr()') == 1
  end
  -- Toggle nerd tree focus.
  local function toggle_focus ()
    if nt_selected() then
      vim.cmd('wincmd p')
    else
      vim.cmd('silent NERDTreeFocus')
    end
  end


  km_set('n', '<C-f>f', toggle_focus,
         {desc='Focus on Nerd tree window in current tab'})

  -- Close NERD Tree in all tabs.
  local function exit_tabs ()
    curr_tab = eval('tabpagenr()')
    vim.cmd('tabdo NERDTreeClose')
    vim.cmd('tabnext ' .. curr_tab)
  end

  km_set('n', '<C-f>q', exit_tabs,
         {desc='Close all nerd tree windows'})

  -- Open NERD Tree in new tabs.
  autocmd("BufWinEnter", { command = 'silent NERDTreeMirror' })

  local function check_last_window ()
    nt_exists = eval('g:NERDTree.GetWinNum()') ~= -1
    selected = nt_selected()
    windows_left = eval('len(gettabinfo(tabpagenr())[0]["windows"])')
    if nt_exists and not selected and windows_left == 2 then
      -- NOTE: It does not count the window as closed in the tabinfo yet...
      vim.cmd('tabclose')
    end
  end
  autocmd("WinClosed", { callback = check_last_window })
  -- TODO: Make cursor position persistent across tabs.


end

return M
