return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/lubrary", words = { "vim%.uv" } },
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true },
    },

    config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        local lspconfig = require("lspconfig").lua_ls.setup { capabilities = capabilities }
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")


        local default_capabilities = vim.lsp.protocol.make_client_capabilities()

        local server_configs = {
            	-- place language server names and their configuration here as a key-value pair
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						disable = {
							"missing-fields"
						}
					},
				},
			},
		},
        }

        mason.setup()

        local mason_ensure_installed = vim.tbl_keys(server_configs or {})
        vim.list_extend(
            mason_ensure_installed,
	        -- place other packages you want to install but not configure with mason here
            -- e.g. language servers not configured with nvim-lspconfig, linters, formatters, etc.
            {
                "stylua",
                "pyright",
                "pylint",
                "black",
                "debugpy",
                "flake8",
                "isort",
                "mypy",
            }
        )
        mason_tool_installer.setup({
            ensure_installed = mason_ensure_installed
        })

        mason_lspconfig.setup({
            handlers = {
                function(server_name)
                    local server_config = server_configs[server_name] or {}
                    server_config.capabilities = vim.tbl_deep_extend(
                        "force",
                        default_capabilities,
                        server_config.capabilities or {}
                    )
                    lspconfig[server_name].setup(server_config)
                end
            },
            ensure_installed = {
                'pyright',
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach-keybinds", { clear = true }),
            callback = function(e)
                local keymap = function(keys, func)
                    vim.keymap.set("n", keys, func, { buffer = e.buf })
                end
                local builtin = require("telescope.builtin")

                keymap("gd", builtin.lsp_definitions)
                keymap("gD", vim.lsp.buf.declaration)
                keymap("gr", builtin.lsp_references)
                keymap("gI", builtin.lsp_implementations)
                keymap("<leader>D", builtin.lsp_type_definitions)
                keymap("<leader>ds", builtin.lsp_document_symbols)
                keymap("<leader>ws", builtin.lsp_dynamic_workspace_symbols)
                keymap("<leader>rn", vim.lsp.buf.rename)
                keymap("<leader>ca", vim.lsp.buf.code_action)
                keymap("K", vim.lsp.buf.hover)
            end
        })
    end
}
