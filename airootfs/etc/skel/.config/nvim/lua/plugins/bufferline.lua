return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'moll/vim-bbye',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        themable = true,
        numbers = 'none',
        close_command = 'Bdelete! %d',
        buffer_close_icon = '✗',
        close_icon = '✗',
        path_components = 1,
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 21,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true,
        separator_style = { '│', '│' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        show_tab_indicators = false,
        indicator = {
          style = 'none',
        },
        icon_pinned = '󰐃',
        minimum_padding = 1,
        maximum_padding = 5,
        maximum_length = 15,
        sort_by = 'insert_at_end',
      },
      highlights = {
        fill = {
          bg = "#080808",
        },
        background = {
          fg = "#555555",
          bg = "#0d0d0d",
        },
        buffer_selected = {
          fg = "#ffffff",
          bg = "NONE",
          bold = true,
          italic = false,
        },
        buffer_visible = {
          fg = "#888888",
          bg = "#0d0d0d",
        },
        close_button = {
          fg = "#555555",
          bg = "#0d0d0d",
        },
        close_button_selected = {
          fg = "#ffffff",
          bg = "NONE",
        },
        close_button_visible = {
          fg = "#888888",
          bg = "#0d0d0d",
        },
        separator = {
          fg = "#2a0000",
          bg = "#0d0d0d",
        },
        separator_selected = {
          fg = "#2a0000",
          bg = "NONE",
        },
        modified = {
          fg = "#7a0000",
          bg = "#0d0d0d",
        },
        modified_selected = {
          fg = "#ffffff",
          bg = "#c80000",
        },
        indicator_selected = {
          fg = "#ff3333",
          bg = "NONE",
        },
        tab = {
          fg = "#555555",
          bg = "#0d0d0d",
        },
        tab_selected = {
          fg = "#ffffff",
          bg = "NONE",
          bold = true,
        },
        tab_close = {
          fg = "#555555",
          bg = "#080808",
        },
      },
    }
  end,
}
