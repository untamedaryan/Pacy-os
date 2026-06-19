return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = false,
      contrast = "hard", -- "hard", "soft" or ""
      palette_overrides = {
        dark0_hard   = "#080808",
        dark0        = "#0d0d0d",
        dark0_soft   = "#111111",
        dark1        = "#141414",
        dark2        = "#1a1a1a",
        dark3        = "#222222",
        dark4        = "#2a2a2a",
        light0_hard  = "#e0e0e0",
        light0       = "#dddddd",
        light0_soft  = "#cccccc",
        light1       = "#bbbbbb",
        light2       = "#aaaaaa",
        light3       = "#999999",
        light4       = "#888888",
        bright_red   = "#ff3333",
        bright_green = "#55aa55",
        bright_yellow= "#ffaa00",
        bright_blue  = "#3333cc",
        bright_purple= "#cc0055",
        bright_aqua  = "#00aaaa",
        bright_orange= "#ff6600",
        neutral_red   = "#c80000",
        neutral_green = "#3a7a3a",
        neutral_yellow= "#c87800",
        neutral_blue  = "#1a1a8a",
        neutral_purple= "#8a003a",
        neutral_aqua  = "#007a7a",
        neutral_orange= "#c86000",
        faded_red    = "#7a0000",
        faded_green  = "#2a5a2a",
        faded_yellow = "#7a5a00",
        faded_blue   = "#0a0a5a",
        faded_purple = "#5a0020",
        faded_aqua   = "#004a4a",
        faded_orange = "#7a3a00",
        gray         = "#444444",
      },
      overrides = {
        -- General UI
        Normal          = { bg = "#080808", fg = "#e0e0e0" },
        NormalFloat     = { bg = "#0d0d0d", fg = "#e0e0e0" },
        NormalNC        = { bg = "#080808" },
        SignColumn      = { bg = "#080808" },
        LineNr          = { fg = "#444444", bg = "#080808" },
        CursorLineNr    = { fg = "#c80000", bold = true },
        CursorLine      = { bg = "#111111" },
        ColorColumn     = { bg = "#111111" },
        Visual          = { bg = "#2a0000" },
        VisualNOS       = { bg = "#2a0000" },
        Search          = { bg = "#7a0000", fg = "#ffffff" },
        IncSearch       = { bg = "#c80000", fg = "#ffffff" },
        MatchParen      = { bg = "#7a0000", fg = "#ff3333", bold = true },

        -- Popup/float menus
        Pmenu           = { bg = "#0d0d0d", fg = "#e0e0e0" },
        PmenuSel        = { bg = "#c80000", fg = "#ffffff" },
        PmenuSbar       = { bg = "#111111" },
        PmenuThumb      = { bg = "#c80000" },

        -- Status & tab line
        StatusLine      = { bg = "#0d0d0d", fg = "#e0e0e0" },
        StatusLineNC    = { bg = "#080808", fg = "#444444" },
        TabLine         = { bg = "#080808", fg = "#444444" },
        TabLineSel      = { bg = "#c80000", fg = "#ffffff" },
        TabLineFill     = { bg = "#080808" },

        -- Splits & borders
        VertSplit       = { fg = "#2a0000" },
        WinSeparator    = { fg = "#2a0000" },
        FloatBorder     = { fg = "#c80000", bg = "#0d0d0d" },

        -- Telescope
        TelescopeBorder         = { fg = "#c80000", bg = "#080808" },
        TelescopeNormal         = { bg = "#080808" },
        TelescopePromptBorder   = { fg = "#ff3333", bg = "#080808" },
        TelescopeResultsBorder  = { fg = "#c80000", bg = "#080808" },
        TelescopePreviewBorder  = { fg = "#7a0000", bg = "#080808" },
        TelescopeSelection      = { bg = "#2a0000", fg = "#ffffff" },
        TelescopeMatching       = { fg = "#ff3333", bold = true },

        -- Syntax
        Comment         = { fg = "#555555", italic = true },
        Todo            = { fg = "#ff3333", bold = true },
        Error           = { fg = "#ff3333", bold = true },
        Warning         = { fg = "#ffaa00" },

        -- Diagnostics
        DiagnosticError = { fg = "#ff3333" },
        DiagnosticWarn  = { fg = "#ffaa00" },
        DiagnosticInfo  = { fg = "#c80000" },
        DiagnosticHint  = { fg = "#7a0000" },

        -- LSP
        LspReferenceText  = { bg = "#2a0000" },
        LspReferenceRead  = { bg = "#2a0000" },
        LspReferenceWrite = { bg = "#3a0000" },
      },
    })
    vim.o.background = "dark"
    vim.cmd.colorscheme "gruvbox"
  end,
}
