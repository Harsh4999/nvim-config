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
    -- change autocomplete binding from <Tab> to <C-Space>
    -- config = function()
    --   vim.g.copilot_key = "<C-Space>"

    -- end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      enabled = true,
    },
    lazy = false,
    -- config = function()
    --   local cmp = require'cmp'
    --   cmp.setup({
    --     mapping = {
    --       -- These lines bind <C-Tab> and <C-S-Tab> for navigating completions
    --       -- ['<C-Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    --       -- ['<C-S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

    --       -- You might want to keep or adjust other key mappings as well
    --       ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Accept currently selected item with Enter key
    --       ['<C-e>'] = cmp.mapping.abort(),  -- Abort/close the completion popup
    --     },
    --     -- Ensure your source setup remains appropriate
    --     sources = cmp.config.sources({
    --       { name = 'nvim_lsp' },
    --       { name = 'buffer' },
    --       { name = 'path' }
    --       -- Add or remove sources as needed
    --     })
    --   })

    -- end,
  },
  {
    'tpope/vim-dadbod',
    lazy = false,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    lazy = false,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    lazy = false,
    depends = {
      'tpope/vim-dadbod',
    },
    cmd = {
      'DBUIToggle',
      'DBUI',
      'DBUIFindBuffer',
      'DBUIRenameBuffer',
      'DBUIUpsert',
      'DBUIExecute',
      'DBUIQuery',
      'DBUIVisualQuery',
      'DBUIQueryRange',
      'DBUIQueryRangeVisual',
      'DBUIQueryVisual'
    }

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
    
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,

  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
  },
  {
    "MunifTanjim/prettier.nvim",
    lazy = false,
    -- config = function()
    --   require("prettier").setup({
    --     filetypes = {
    --       javascript = "eslint",
    --       typescript = "eslint",
    --       typescriptreact = "eslint",
    --       javascriptreact = "eslint",
    --       vue = "eslint",
    --       html = "prettier",
    --       css = "prettier",
    --       json = "prettier",
    --       markdown = "prettier",
    --       scss = "prettier",
    --       less = "prettier",
    --       graphql = "prettier",
    --       yaml = "prettier",
    --       svelte = "prettier",
    --       vue = "prettier",
    --       lua = "stylua",
    --       python = "black",
    --       rust = "rustfmt",
    --       go = "gofmt",
    --       php = "phpcbf",
    --       ruby = "rubocop",
    --     },
    --     settings = {
    --       rootMarkers = { ".git/" },
    --     },
    --   })
    -- end,
  },
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")
  
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        python = { "pylint" },
      }
  
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
  
      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        -- open_on_setup = false,
        -- ignore_ft_on_setup = {},
        -- auto_close = false,
        open_on_tab = false,
        hijack_cursor = false,
        -- update_to_buf_dir = {
        --   enable = true,
        --   auto_open = true,
        -- },
        update_cwd = false,
        diagnostics = {
          enable = false,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = false,
          ignore_list = {},
        },
        system_open = {
          cmd = nil,
          args = {},
        },
        view = {
          width = 30,
          side = "left",
          -- auto_resize = false,
          -- mappings = {
          --   custom_only = false,
          --   list = {},
          -- },
        },
        filters = {
          dotfiles = false,
          custom = {},
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        }
      })
    end,
  },
  {
    "APZelos/blamer.nvim",
    lazy = false

  },
  {
    'nvim-lua/plenary.nvim',
    lazy = false,
  },
  {
    -- pin to 0.0.1 to avoid breaking changes
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true,
    lazy = false,
  },
  {
    "glepnir/lspsaga.nvim",
    lazy = false,

  },
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    lazy = false,
  }

}
