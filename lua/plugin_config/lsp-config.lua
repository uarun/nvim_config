local api    = vim.api
local keymap = vim.keymap.set

-- Language Servers
local servers = {
  "lua_ls",
  "rust_analyzer"
}

require("mason").setup({
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  }
})
require('mason-lspconfig').setup {
  ensure_installed = servers
}

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
  capabilities = capabilities,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Key Maps
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
  keymap("n", "gd", vim.lsp.buf.definition, bufopts)
  keymap("n", "K", vim.lsp.buf.hover, bufopts)
  keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
  keymap("n", "gr", require('telescope.builtin').lsp_references, bufopts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  keymap("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  keymap("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  keymap("n", "<leader>cl", vim.lsp.codelens.run)
  keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  keymap("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, bufopts)
end

-- Completions & Snippets setup
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {},
  mapping = cmp.mapping.preset.insert {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
}

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require('neodev').setup({})
for _, server in pairs(servers) do
  lspconfig[server].setup { on_attach = on_attach }
end

-- Scala Metals Config --
local lsp_group = api.nvim_create_augroup("lsp", { clear = true })
local metals_config = require("metals").bare_config()
metals_config.tvp = {
  icons = {
    enabled = true,
  },
}

metals_config.settings = {
  showImplicitArguments = true,
  showImplicitConversionsAndClasses = true,
  showInferredType = true,
  --enableSemanticHighlighting = true,
  --fallbackScalaVersion = "2.13.10",
  serverVersion = "latest.snapshot",
}

metals_config.init_options.statusBarProvider = "on"
metals_config.capabilities = capabilities

metals_config.on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  keymap("v", "K", require("metals").type_of_range)
  keymap("n", "<leader>ws", function()
    require("metals").hover_worksheet({ border = "single" })
  end)
  keymap("n", "<leader>tt", require("metals.tvp").toggle_tree_view)
  keymap("n", "<leader>tr", require("metals.tvp").reveal_in_tree)
  keymap("n", "<leader>mmc", require("metals").commands)
  keymap("n", "<leader>mts", function()
    require("metals").toggle_setting("showImplicitArguments")
  end)

  -- A lot of the servers won't support document_highlight or codelens,
  -- so we juse use them in Metals
  api.nvim_create_autocmd("CursorHold", {
    callback = vim.lsp.buf.document_highlight,
    buffer = bufnr,
    group = lsp_group,
  })
  api.nvim_create_autocmd("CursorMoved", {
    callback = vim.lsp.buf.clear_references,
    buffer = bufnr,
    group = lsp_group,
  })
  api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    callback = vim.lsp.codelens.refresh,
    buffer = bufnr,
    group = lsp_group,
  })
  api.nvim_create_autocmd("FileType", {
    pattern = { "dap-repl" },
    callback = function()
      require("dap.ext.autocompl").attach()
    end,
    group = lsp_group,
  })

  -- nvim-dap
  -- only use nvim-dap with Scala, so we keep it all in here
  local dap = require("dap")

  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "Run or test with input",
      metals = {
        runType = "runOrTestFile",
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " +")
        end,
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Run or Test",
      metals = {
        runType = "runOrTestFile",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test Target",
      metals = {
        runType = "testTarget",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Run minimal2 main",
      metals = {
        mainClass = "minimal2.Main",
        buildTarget = "minimal",
      },
    },
  }

  keymap("n", "<leader>dc", require("dap").continue)
  keymap("n", "<leader>dr", require("dap").repl.toggle)
  keymap("n", "<leader>dK", require("dap.ui.widgets").hover)
  keymap("n", "<leader>dt", require("dap").toggle_breakpoint)
  keymap("n", "<leader>dso", require("dap").step_over)
  keymap("n", "<leader>dsi", require("dap").step_into)
  keymap("n", "<leader>drl", require("dap").run_last)

  dap.listeners.after["event_terminated"]["nvim-metals"] = function()
    vim.notify("dap finished!")
    --dap.repl.open()
  end

  require("metals").setup_dap()
end

local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "gradle", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

