local Remap = require("core.utils")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap


local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = function()
      nnoremap("gd", function() vim.lsp.buf.definition() end)
      nnoremap("gi", function() vim.lsp.buf.implementation() end)
      nnoremap("gr", function() require("telescope.builtin").lsp_references() end)
      nnoremap("<leader>ds", function() require("telescope.builtin").lsp_document_symbols() end)
      nnoremap("<leader>ds", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end)

      -- See `:help K` for why this keymap
      nnoremap("K", function() vim.lsp.buf.hover() end)
      nnoremap("<C-k>", function() vim.lsp.buf.signature_help() end)

      -- lesser used LSP functionality
      nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
      nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
      nnoremap("[d", function() vim.diagnostic.goto_next() end)
      nnoremap("]d", function() vim.diagnostic.goto_prev() end)
      nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
      nnoremap("<leader>vco", function() vim.lsp.buf.code_action({
	filter = function(code_action)
	  if not code_action or not code_action.data then
	      return false
	  end

	  local data = code_action.data.id
	  return string.sub(data, #data - 1, #data) == ":0"
	end,
	apply = true
      }) end)
      nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
      nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
      inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(_config, 'Format', function(_)
	if vim.lsp.buf.format then
	  vim.lsp.buf.format()
	elseif vim.lsp.buf.formatting then
	  vim.lsp.buf.formatting()
	end
      end, { desc = 'Format current buffer with LSP' })

    end,
  }, _config or {})
end


-- Lua
require('lspconfig')['sumneko_lua'].setup {
  config,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Rust
require("lspconfig")["rust_analyzer"].setup {config}

-- Python
require("lspconfig")["pyright"].setup {config}

-- Typescript
require("lspconfig")["tsserver"].setup {config}

-- HTML and css
require('lspconfig')["emmet_ls"].setup {config}

-- local on_attach = function(_, bufnr)
--   -- NOTE: Remember that lua is a real programming language, and as such it is possible
--   -- to define small helper and utility functions so you don't have to repeat yourself
--   -- many times.
--   --
--   -- In this case, we create a function that lets us more easily define mappings specific
--   -- for LSP related items. It sets the mode, buffer and description for us each time.
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
--
--   nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--   nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--   nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--   nmap('gr', require('telescope.builtin').lsp_references)
--   nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--   nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--   -- See `:help K` for why this keymap
--   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--   -- Lesser used LSP functionality
--   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--   nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--   nmap('<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, '[W]orkspace [L]ist Folders')
--
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     if vim.lsp.buf.format then
--       vim.lsp.buf.format()
--     elseif vim.lsp.buf.formatting then
--       vim.lsp.buf.formatting()
--     end
--   end, { desc = 'Format current buffer with LSP' })
-- end

-- -- Setup mason so it can manage external tooling
-- require('mason').setup({
--   ui = {
--         icons = {
--             package_installed = "✓",
--             package_pending = "➜",
--             package_uninstalled = "✗"
--         }
--     }
-- })
--
-- -- Enable the following language servers
-- local servers = { 'rust_analyzer', 'pyright', 'tsserver', 'sumneko_lua', 'css-lsp', 'html-lsp', 'emmet-lsp', 'eslint-lsp'}
--
-- -- Ensure the servers above are installed
-- require('mason-lspconfig').setup {
--   ensure_installed = servers,
-- }
--
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--
-- for _, lsp in ipairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end
