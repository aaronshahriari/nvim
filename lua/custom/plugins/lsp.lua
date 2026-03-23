return {
  "neovim/nvim-lspconfig",
  dependencies = {
    'saghen/blink.cmp',
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = function()
    -- local lspconfig = require("lspconfig")

    -- proper context for diagnostics
    vim.diagnostic.config({
      -- virtual_text = {
      --   prefix = '■ ', -- Could be '●', '▎', 'x', '■', , 
      -- },
      float = { border = "single" },
    })

    -- REMAPS
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(e)
        local opts = { buffer = e.buf }
        -- local builtin = require "telescope.builtin"
        -- vim.keymap.set("n", "gr", builtin.lsp_references, opts)
        vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'single' }) end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
      end,
    })

    -- TYPST
    vim.lsp.config["tinymist"] = {
      cmd = { "tinymist" },
      filetypes = { "typst" },
      settings = {
      }
    }
    vim.lsp.enable('tinymist')

    -- TYPESCRIPT
    vim.lsp.enable('ts_ls')

    -- RUBY
    vim.lsp.config("solargraph", {
      init_options = {
        formatting = false,
      },
      settings = {
        solargraph = {
          diagnostics = false,
        },
      },
    })
    vim.lsp.enable("solargraph")

    vim.lsp.config("ruby_lsp", {
      init_options = {
        formatting = false,
      },
    })
    vim.lsp.enable('ruby_lsp')

    -- TYPST
    vim.lsp.enable('typst_lsp')

    -- GO
    vim.lsp.enable("gopls")

    -- SQL
    -- vim.lsp.enable("sqls")

    -- RUST
    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = false,
          }
        }
      }
    })
    vim.lsp.enable('rust_analyzer')

    -- ELIXIR
    vim.lsp.config('elixirls', {
      cmd = { "elixir-ls" },
      filetypes = { "exs", "elixir", "eelixir", "heex", "surface" },
    })
    vim.lsp.enable('elixirls')

    -- PYTHON
    vim.lsp.enable('pylsp')

    -- ZIG
    vim.lsp.config('zls', {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
      settings = {
        zls = {
          enable_argument_placeholders = false,
        },
      }
    })
    vim.lsp.enable('zls')
    -- don't show parse errors in a separate window
    vim.g.zig_fmt_parse_errors = 0
    -- disable format-on-save
    vim.g.zig_fmt_autosave = 0

    -- BASH
    vim.lsp.enable('bashls')

    -- TAILWINDCSS
    vim.lsp.config('tailwindcss', {
      cmd = { 'tailwindcss-language-server', '--stdio' },
    })
    vim.lsp.enable('tailwindcss')

    -- HTMX
    vim.lsp.enable('htmx')

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- MARKDOWN
    vim.lsp.config('markdown_oxide', {
      -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
      -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
      capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        }
      ),
    })
    vim.lsp.enable('markdown_oxide')

    -- HTML
    vim.lsp.config('html', {
      capabilities = capabilities,
    })
    vim.lsp.enable('html')

    -- LUA
    vim.lsp.config('lua_ls', {
      settings = {
        ['Lua'] = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    })
    vim.lsp.enable('lua_ls')

    -- NIX
    vim.lsp.config('nil_ls', {
      settings = {
        ['nil'] = {
          formatting = {
            command = { "nixfmt" },
          },
          nix = {
            flake = {
              autoArchive = true,
            },
          },
        },
      }
    })
    vim.lsp.enable('nil_ls')

    -- MD
    vim.lsp.enable('markdown_oxide')
  end
}
