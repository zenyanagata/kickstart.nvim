-- NOTE: Only enable either copilot.lua or codeium at the same time
return {
  -- Use native snippets from Neovim v0.10
  {
    'hrsh7th/nvim-cmp',
    optional = true,
    keys = function()
      return {}
    end,
  },

  -- Setup copilot.lua
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true, -- show suggestions automatically
          debounce = 75,
          keymap = {
            accept = "<C-y>",
            accept_word = "<C-w>",
            accept_line = "<C-i>",
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "<C-d>",
          },
        },
        filetypes = {
          TelescopePrompt = false,
          -- add other filetypes = false to disable
        },
      })
    end,
  },

  -- Add status line icon for copilot
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        sections = {
          lualine_x = {
            {
              function()
                return "copilot 🧠"  -- Copilot icon
              end,
              cond = function()
                local clients = vim.lsp.get_clients({ name = 'copilot', bufnr = 0 })
                return #clients > 0
              end,
              color = { fg = "#6CC644" }, -- GitHub green
            },
            'encoding',
            'fileformat',
            'filetype',
          },
        },
      }
    end,
  },
}
