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
    image = "easonliu12138/pylsp_container:v1.0",
    entry = "pylsp"
  }),
  root_dir = require("lspconfig.util").root_pattern(".git", vim.fn.getcwd()),
  settings = {
    plugins = {
      -- formatter options
      black = { enabled = false },
      autopep8 = { enabled = false },
      yapf = { enabled = true },
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

lspconfig.rust_analyzer.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes =  { "rust" },
	cmd = { "rust-analyzer" },
	root_dir = lspconfig.util.root_pattern("Cargo.toml")
}

-- Need clang >= 11 to be set up
lspconfig.clangd.setup {
	on_attach = on_attach, 
	capabilities = capabilities,
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
	cmd = lspcontainers.command("clangd", {
		image = "easonliu12138/mysql_llvm:v1.1",
		entry = "clangd"
	}),
	single_file_support = true,
	root_dir = lspconfig.util.root_pattern(
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git"
	)
}
