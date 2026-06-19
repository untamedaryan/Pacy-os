return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local function footer()
      local datetime = os.date(" %d-%m-%Y  %H:%M")
      return "⚡ Neovim loaded | " .. datetime
    end

dashboard.section.header.val = {
  [[                                    ██████                                    ]],
  [[                                ████▒▒▒▒▒▒████                                ]],
  [[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
  [[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
  [[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
  [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
  [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
  [[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
  [[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
  [[                        ██      ██      ████      ████                        ]],
  [[]],
}

dashboard.section.buttons.val = {
  dashboard.button(
        "f",
        "󰈞  Find file",
        ":Telescope find_files<CR>"
      ),


      dashboard.button(
        "e",
        "  New file",
        ":ene <CR>"
      ),


      dashboard.button(
        "r",
        "󰄉  Recent files",
        ":Telescope oldfiles<CR>"
      ),

      dashboard.button(
        "g",
        "󰊢  Git status",
        ":LazyGit<CR>"
      ),

      dashboard.button(
        "c",
        "  Config",
        ":e ~/.config/nvim/init.lua<CR>"
      ),

      dashboard.button(
        "q",
        "󰅚  Quit",
        ":qa<CR>"
      ),

    }


    dashboard.section.footer.val = footer()


    dashboard.config.layout = {
      { type = "padding", val = 3 },

      dashboard.section.header,

      { type = "padding", val = 2 },

      dashboard.section.buttons,

      { type = "padding", val = 2 },

      dashboard.section.footer,
    }


    alpha.setup(dashboard.config)


    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      callback = function()
        vim.opt.showtabline = 0
        vim.opt.laststatus = 0
      end,
    })


    vim.api.nvim_create_autocmd("BufUnload", {
      callback = function()
        vim.opt.showtabline = 2
        vim.opt.laststatus = 3
      end,
    })
  end,
}
