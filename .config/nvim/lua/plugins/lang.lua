return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        gopls = {},
        pyright = {},
        ruff_lsp = {},
        rust_analyzer = {},
        tailwindcss = {},
        terraformls = {},
        yamlls = {},

        -- These are all for TypeScript but we disable them because they are hella slow.
        -- Instead we opt to use typescript-tools: https://github.com/pmizio/typescript-tools.nvim
        tsserver = { enabled = false },
        ts_ls = { enabled = false },
        vtsls = { enabled = false },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        on_attach = function(client)
          -- Disable formatting from typescript-tools since lazyvim uses conform for
          -- formatting making this redundant: https://github.com/pmizio/typescript-tools.nvim/issues/288
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
        "hcl",
        "python",
        "rst",
        "terraform",
        "toml",
        "yaml",
      },
    },
  },
  {
    -- Need this to set up biome v2
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
      },
      formatters = {
        biome = {
          command = "./node_modules/.bin/biome",
          args = { "format", "--stdin-file-path", "$FILENAME" },
          stdin = true,
          require_cwd = true, -- Requires biome.json in project root
        },
      },
    },
  },
  {
    "apple/pkl-neovim",
    lazy = true,
    ft = "pkl",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        build = function(_)
          vim.cmd("TSUpdate")
        end,
      },
      "L3MON4D3/LuaSnip",
    },
    build = function()
      require("pkl-neovim").init()
      -- Set up syntax highlighting.
      vim.cmd("TSInstall! pkl")
    end,
    config = function()
      -- Set up snippets.
      require("luasnip.loaders.from_snipmate").lazy_load()

      -- Configure pkl-lsp
      vim.g.pkl_neovim = {
        start_command = { "pkl-lsp" },
        pkl_cli_path = "/Users/jasonwu/.local/share/aquaproj-aqua/bin/pkl",
      }
    end,
  },
}
