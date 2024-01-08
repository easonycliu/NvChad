local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local lspcontainers = require "lspcontainers"

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  single_file_support = true,
  cmd = lspcontainers.command("pylsp", {
    image = "easonliu12138/mysql_doxygen:v1.3",
    entry = "pylsp"
  }),
  root_dir = require("lspconfig.util").root_pattern(".git", vim.fn.getcwd()),
  settings = {
    plugins = {
      -- formatter options
      black = { enabled = true },
      autopep8 = { enabled = false },
      yapf = { enabled = false },
      -- linter options
      pylint = { enabled = true, executable = "pylint" },
      ruff = { enabled = false },
      pyflakes = { enabled = false },
      pycodestyle = { enabled = false },
      -- type checker
      pylsp_mypy = {
        enabled = true,
        overrides = { "--python-executable", "/usr/bin/python3", true },
        report_progress = true,
        live_mode = false
      },
      -- auto-completion options
      jedi_completion = { fuzzy = true },
      -- import sorting
      isort = { enabled = true },
    }
  }
}
