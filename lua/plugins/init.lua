return {
  {
    "stevearc/conform.nvim",

    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "github/copilot.vim", 
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      enabled = false,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    version = "*",
    config = function()
      require("toggleterm").setup{
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.4)
          end
          return 50  -- default size if none of the conditions above are met
        end,
        open_mapping = [[<c-\>]],
        on_create = function(t) end,  -- empty function as placeholder
        on_open = function(t) end,
        on_close = function(t) end,
        on_stdout = function(t, job, data, name) end,
        on_stderr = function(t, job, data, name) end,
        on_exit = function(t, job, exit_code, name) end,
        hide_numbers = true,
        shade_filetypes = {},
        autochdir = false,
        -- highlights = {
        --   Normal = {
        --     guibg = "Black",  -- replace YOUR_COLOR_HERE with actual color value
        --   },
        --   NormalFloat = {
        --     link = 'Normal'
        --   },
        --   FloatBorder = {
        --     guifg = "Grey",
        --     guibg = "Grey",
        --   },
        -- },
        shade_terminals = true,
        shading_factor = -3,  -- adjust this number according to your preference
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",  -- set this to 'vertical', 'horizontal', 'tab', or 'float'
        close_on_exit = true,
        shell = vim.o.shell,
        auto_scroll = true,
        float_opts = {
          border = 'single',
          width = 180,
          height = 40,
          winblend = 3,
          zindex = 50,
          title_pos = 'center',
        },
        winbar = {
          enabled = false,
          name_formatter = function(term)
            return term.name
          end
        },
      }
    end
  },
  {
    "NvChad/nvterm",
    lazy=false,
    -- setup key mappings
    config = function()
      require("nvterm").setup({
        terminals = {
          shell = vim.o.shell,
          list = {},
          type_opts = {
            float = {
              relative = 'editor',
              row = 0.3,
              col = 0.25,
              width = 0.5,
              height = 0.4,
              border = "single",
            },
            horizontal = { location = "rightbelow", split_ratio = .3, },
            vertical = { location = "rightbelow", split_ratio = .5 },
          }
        },
        behavior = {
          autoclose_on_quit = {
            enabled = false,
            confirm = true,
          },
          close_on_exit = true,
          auto_insert = true,
        },
      })
      
    end,
    
  }
  -- {
  --   'barrett-ruth/live-server.nvim',
  --   build = 'npm i -g live-server',
  --   cmd = { 'LiveServerStart', 'LiveServerStop' },
  --   config = true
  -- }
    -- {
    --   'wolandark/vim-live-server',

    -- }

  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  -- },
  --
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
