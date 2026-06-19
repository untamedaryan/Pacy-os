return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',           -- Important: use the new main branch
  lazy = false,              -- Load early for better highlighting
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup({
      -- You can customize install_dir if needed, but default is usually fine
      -- install_dir = vim.fn.stdpath('data') .. '/site',
    })

    -- Install your parsers (this replaces ensure_installed + auto_install)
    local parsers = {
      'lua', 'python', 'javascript', 'rust',
      'vimdoc', 'vim', 'sql', 'dockerfile',
      'toml', 'json', 'go', 'gitignore',
      'yaml', 'bash', 'css', 'html',
    }
    require('nvim-treesitter').install(parsers)
  end,
}
