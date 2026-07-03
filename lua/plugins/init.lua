-- return {
--   {
--     "stevearc/conform.nvim",
--     -- event = 'BufWritePre', -- uncomment for format on save
--     opts = require "configs.conform",
--   },
--
--   -- These are some examples, uncomment them if you want to see them work!
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       require "configs.lspconfig"
--     end,
--   },
--
--   -- {
--   -- 	"nvim-treesitter/nvim-treesitter",
--   -- 	opts = {
--   -- 		ensure_installed = {
--   -- 			"vim", "lua", "vimdoc",
--   --      "html", "css"
--   -- 		},
--   -- 	},
--   -- },
-- }
--
local function get_fortune()
  local handle = io.popen("fortune")
  if handle then
    local result = handle:read("*a")
    handle:close()
    return result
  else
    return "Failed to get fortune."
  end
end

return {
  {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    lazy = false,
    config = function()
      require("github-theme").setup({})
    end,
  },
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
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "python",
          "go",
          "hcl",
          "terraform",
          "json"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        incremental_selection = {
          enable = true,
        },
        refactor = {
          highlight_definitions = { enable = true },
          highlight_current_scope = { enable = true },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
        playground = {
          enable = true,
          keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            toggle_language_display = "I",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
          },
        },
      }
    end,

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
          width = 25,
          side = "left",
          preserve_window_proportions = false,
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
      vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { noremap = true, silent = true, desc = "File Explorer" })
      -- vim.keymap.set('n', '<leader>F', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
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
  },
  {
    "olexsmir/gopher.nvim",
    lazy = false,
    -- ft = "go",
    -- -- branch = "develop", -- if you want develop branch
    --                        -- keep in mind, it might break everything
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   "nvim-treesitter/nvim-treesitter",
    --   "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
    -- },
    -- -- (optional) will update plugin's deps on every update
    -- build = function()
    --   vim.cmd.GoInstallDeps()
    -- end,
    -- ---@type gopher.Config
    -- opts = {},
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    ---@class snacks.dashboard.Config
    ---@field enabled? boolean
    ---@field sections snacks.dashboard.Section
    ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
    opts = {
      bigfile = { enabled = true },
      scratch = {
        enabled = true,
        -- Scratch files are saved here
        root = vim.fn.stdpath("data") .. "/scratch",
        -- File type for scratch buffers
        ft = "markdown",
      },
      terminal = {
        win = {
          position = "bottom",
          height = 0.3,
        },
      },
      picker = {
        enable = true,
        hidden = true, -- for hidden files
        ignored = true, -- for .gitignore files
      },
      dashboard = { 
        enabled = true,
        -- formats = {
        --   key = function(item)
        --     return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
        --   end,
        -- },
        -- sections = {
        --   { section = "terminal", cmd = "fortune -s | cowsay", hl = "header" },
        --   -- { title = "MRU", padding = 1 },
        --   -- { section = "recent_files", limit = 8, padding = 1 },
        --   -- { title = "MRU ", file = vim.fn.fnamemodify(".", ":~"), padding = 1 },
        --   -- { section = "recent_files", cwd = true, limit = 8, padding = 1 },
        --   -- { title = "Sessions", padding = 1 },
        --   -- { section = "projects", padding = 1 },
        --   -- { title = "Bookmarks", padding = 1 },
        --   -- { section = "keys" },
        -- }
        --
        width = 50,
        row = nil, -- dashboard position. nil for center
        col = nil, -- dashboard position. nil for center
        pane_gap = 4, -- empty columns between vertical panes
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
        -- These settings are used by some built-in sections
        preset = {
          -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          -- Used by the `keys` section to show keymaps.
          -- Set your custom keymaps here.
          -- When using a function, the `items` argument are the default keymaps.
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          -- Used by the `header` section
      --     header = [[
      -- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      -- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      -- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      -- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      -- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      -- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
      -- ]],
--           header = [[
--
--     __    ______       _       ___________   ___    ____  ____ 
--    / /   /  _/ /      | |     / /  _/__  /  /   |  / __ \/ __ \
--   / /    / // /       | | /| / // /   / /  / /| | / /_/ / / / /
--  / /____/ // /___     | |/ |/ // /   / /__/ ___ |/ _, _/ /_/ / 
-- /_____/___/_____/     |__/|__/___/  /____/_/  |_/_/ |_/_____/  
--
--
--         ]]
          header = [[

    ███╗   ███╗███████╗██████╗  ██████╗ ██████╗ ██████╗ 
    ████╗ ████║██╔════╝██╔══██╗██╔════╝██╔═══██╗██╔══██╗
    ██╔████╔██║█████╗  ██████╔╝██║     ██║   ██║██████╔╝
    ██║╚██╔╝██║██╔══╝  ██╔══██╗██║     ██║   ██║██╔══██╗
    ██║ ╚═╝ ██║███████╗██║  ██║╚██████╗╚██████╔╝██║  ██║
    ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝

        ]]
        },
        -- item field formatters
        formats = {
          icon = function(item)
            if item.file and item.icon == "file" or item.icon == "directory" then
              return M.icon(item.file, item.icon)
            end
            return { item.icon, width = 2, hl = "icon" }
          end,
          footer = { "%s", align = "center" },
          header = { "%s", align = "center" },
          file = function(item, ctx)
            local fname = vim.fn.fnamemodify(item.file, ":~")
            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
            if #fname > ctx.width then
              local dir = vim.fn.fnamemodify(fname, ":h")
              local file = vim.fn.fnamemodify(fname, ":t")
              if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
              end
            end
            local dir, file = fname:match("^(.*)/(.+)$")
            return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
          end,
        },
        sections = {
          -- { section = "terminal", cmd = "fortune", hl = "header", height = 10, cwd= vim.fn.getcwd() },
            -- {
            --   section = "terminal",
            --   cmd = "chafa ~/.config/nvim/logo.png --format symbols --symbols block --size 30x20 --align center ; sleep .1",
            --   height = 20
            -- },
          { section = "header" },
          -- { section = "keys", gap = 1, padding = 1 },
          -- { section = "startup" },
        },
        -- sections = {
            -- {
            --   section = "terminal",
            --   cmd = "chafa ~/.config/nvim/logo.png --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
            --   height = 100,
            --   padding = 1,
            -- },
        --     {
        --       pane = 2,
        --       { section = "keys", gap = 1, padding = 1 },
        --       { section = "startup" },
        --     },
        -- },
        -- sections = {
        --   {
        --     section = "terminal",
        --     cmd = "chafa ~/.config/nvim/logo.png --format symbols --symbols block --size 30x20 --align center; sleep .1",
        --     height = 25,
        --     padding = 1,
        --   },
        --   {
        --     pane = 2,
        --     { section = "keys", gap = 1, padding = 1 },
        --     { section = "startup" },
        --   },
        -- }
      },
      explorer = { 
        enabled = true,
        replace_netrw = true,
        supports_live = true,
        tree = true,
        watch = true,
        diagnostics = true,
        diagnostics_open = false,
        git_status = true,
        git_status_open = false,
        git_untracked = true,
        follow_file = true,
        focus = "list",
        auto_close = false,
        hidden = true,
        ignored = true,
        dotfiles = true,
        show_empty = true,
        icon_sources = { "nerd_fonts", "emoji" },
        finder = "icons",
        format = "icon",
        layout = { preset = "vscode" },
        confirm = "put",
      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
        style = "fancy",
        top_down = true,
      },
      -- picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        },
        terminal = {
          position = "bottom",
          height = 0.3,
        },
      }
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<leader>E", function() Snacks.explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<leader>st",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      "folke/snacks.nvim"
    },
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig | {}
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
    -- 👇 if you use `open_for_directories=true`, this is recommended
    init = function()
      -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
     "m4xshen/hardtime.nvim",
     lazy = false,
     dependencies = { "MunifTanjim/nui.nvim" },
     opts = {},
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    lazy = false,
    config = function()
      require("claude-code").setup({
        -- Terminal window settings
        window = {
          split_ratio = 0.3,      -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
          position = "float",  -- Position of the window: "botright", "topleft", "vertical", "float", etc.
          enter_insert = true,    -- Whether to enter insert mode when opening Claude Code
          hide_numbers = true,    -- Hide line numbers in the terminal window
          hide_signcolumn = true, -- Hide the sign column in the terminal window
          
          -- Floating window configuration (only applies when position = "float")
          float = {
            width = "80%",        -- Width: number of columns or percentage string
            height = "80%",       -- Height: number of rows or percentage string
            row = "center",       -- Row position: number, "center", or percentage string
            col = "center",       -- Column position: number, "center", or percentage string
            relative = "editor",  -- Relative to: "editor" or "cursor"
            border = "rounded",   -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
          },
        },
        -- File refresh settings
        refresh = {
          enable = true,           -- Enable file change detection
          updatetime = 100,        -- updatetime when Claude Code is active (milliseconds)
          timer_interval = 1000,   -- How often to check for file changes (milliseconds)
          show_notifications = true, -- Show notification when files are reloaded
        },
        -- Git project settings
        git = {
          use_git_root = true,     -- Set CWD to git root when opening Claude Code (if in git project)
        },
        -- Shell-specific settings
        shell = {
          separator = '&&',        -- Command separator used in shell commands
          pushd_cmd = 'pushd',     -- Command to push directory onto stack (e.g., 'pushd' for bash/zsh, 'enter' for nushell)
          popd_cmd = 'popd',       -- Command to pop directory from stack (e.g., 'popd' for bash/zsh, 'exit' for nushell)
        },
        -- Command settings
        command = "claude",        -- Command used to launch Claude Code
        -- Command variants
        command_variants = {
          -- Conversation management
          continue = "--continue", -- Resume the most recent conversation
          resume = "--resume",     -- Display an interactive conversation picker

          -- Output options
          verbose = "--verbose",   -- Enable verbose logging with full turn-by-turn output
        },
        -- Keymaps
        keymaps = {
          toggle = {
            normal = "<C-,>",       -- Normal mode keymap for toggling Claude Code, false to disable
            terminal = "<C-,>",     -- Terminal mode keymap for toggling Claude Code, false to disable
            variants = {
              continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
              verbose = "<leader>cV",  -- Normal mode keymap for Claude Code with verbose flag
            },
          },
          window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
          scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
        }
      })
    end
  },
  -- Telescope: configure to open files in non-terminal windows
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",  -- Lazy load on command
    keys = { "<leader>ff", "<leader>fg", "<leader>fb", "<leader>fh" },  -- Lazy load on these keys
    config = function()
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      
      -- Custom action: open in first non-terminal window
      local function open_in_main_window(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        -- Find first window with a normal buffer (not terminal, not special)
        local target_win = nil
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local bt = vim.bo[buf].buftype
          local ft = vim.bo[buf].filetype
          -- Skip terminal, nofile, snacks explorer, etc.
          if bt == "" and ft ~= "snacks_dashboard" and ft ~= "snacks_explorer" then
            target_win = win
            break
          end
        end
        
        if target_win then
          vim.api.nvim_set_current_win(target_win)
        end
        
        -- Open the file
        if entry and entry.path then
          vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
        elseif entry and entry.filename then
          vim.cmd("edit " .. vim.fn.fnameescape(entry.filename))
        elseif entry and entry.value then
          vim.cmd("edit " .. vim.fn.fnameescape(entry.value))
        end
      end
      
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<CR>"] = open_in_main_window,
            },
            n = {
              ["<CR>"] = open_in_main_window,
            },
          },
        },
      })
    end,
  },
}

