M = {}

local eval = vim.api.nvim_eval
local km_set = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

local NT = {}


function NT.selected ()
  return eval('g:NERDTree.GetWinNum() ==# winnr()') == 1
end


function NT.toggle_focus ()
  if not NT.exists() then return end
  if NT.selected() then
    vim.cmd('wincmd p')
  else
    vim.cmd('silent NERDTreeFocus')
  end
end


function NT:exit_tabs ()
  curr_tab = eval('tabpagenr()')
  vim.cmd('tabdo NERDTreeClose')
  vim.cmd('tabnext ' .. curr_tab)
end


function NT.exists ()
  return eval('g:NERDTree.GetWinNum()') ~= -1
end


function NT:check_last_window ()
  nt_exists = NT.exists()
  selected = self.selected()
  windows_left = eval('len(gettabinfo(tabpagenr())[0]["windows"])')
  if nt_exists and not selected and windows_left == 2 then
    -- NOTE: It does not count the window as closed in the tabinfo yet...
    vim.cmd('tabclose')
  end
end

function M.setup ()

  -- Opening new projects.
  km_set('n', '<C-f>p', '<Cmd>tabdo NERDTreeVCS<Cr>',
         {desc='Focus on Nerd tree window in current tab'})
  km_set('n', '<C-f>o',
         '<Cmd>tabdo NERDTreeMirror | NERDTreeFocus<Cr>')


  -- Toggle nerd tree focus.
  km_set('n', '<C-f>f', NT.toggle_focus,
         {desc='Focus on Nerd tree window in current tab'})

  km_set('n', '<C-f>q', NT.exit_tabs,
         {desc='Close all nerd tree windows'})

  -- Open NERD Tree in new tabs.
  autocmd("BufWinEnter", { command = 'silent NERDTreeMirror' })

-- Close NERD Tree in all tabs.
  autocmd("WinClosed", { callback = NT.check_last_window })
  -- TODO: Make cursor position persistent across tabs.


end

return M
