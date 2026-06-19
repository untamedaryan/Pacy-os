-- importing module/parts from lua/core/

require 'core.keymaps'
require 'core.options'

-- [[ Install `lazy.nvim` plugin manager ]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]] 

require("lazy").setup({
	require 'plugins.themes.dracula',
        require 'plugins.loadingscreen',
        require 'plugins.autopairs',
        require 'plugins.telescope',
        require 'plugins.treesitter',
        require 'plugins.bufferline',
        require 'plugins.lsp',
        require 'plugins.autocomplete',
    })


vim.cmd([[
highlight Normal guibg=NONE ctermbg=NONE
highlight NormalNC guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE
]])
