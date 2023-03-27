local lsp = require("lsp-zero").preset({
	suggest_lsp_servers = true,
	setup_servers_on_start = true,
	set_lsp_keymaps = false,
	configure_diagnostics = false,
	cmp_capabilities = true,
	manage_nvim_cmp = true,
	call_servers = "local",
	sign_icons = {
		error = "✘",
		warn = "▲",
		hint = "⚑",
		info = "",
	},
})

-- Configure lua language server for neovim
lsp.nvim_workspace()
--- keymap setup

local builtin = require("telescope.builtin")
lsp.on_attach(function(client, bufnr)
	vim.diagnostic.config({
		virtual_text = false,
		float = { source = true },
	})
	local noremap = { buffer = bufnr, remap = false }
	local bind = vim.keymap.set
	bind("n", "<leader>qq", vim.lsp.buf.hover, noremap)
	bind({ "n", "v" }, "<leader>qa", vim.lsp.buf.code_action, noremap)
	bind("n", "<leader>qd", vim.lsp.buf.definition, noremap)
	bind("n", "<leader>qr", builtin.lsp_references, noremap)
	bind("n", "<leader>qc", vim.lsp.buf.rename, noremap)
	bind({ "i", "s" }, "<c-s>", vim.lsp.buf.signature_help, noremap)
	bind({ "n", "v" }, "<leader>qf", vim.lsp.buf.format, noremap)
	bind("n", "<leader>qn", vim.diagnostic.goto_next, noremap)
	bind("n", "<leader>qp", vim.diagnostic.goto_prev, noremap)
end)

lsp.configure('yamlls', {
    settings = {
        yaml = {
            validate = true,
            hover = true,
            completion = true,
            shemas = {
                "https://raw.githubusercontent.com/iterative/dvcyaml-schema/master/schema.json",
                "dvc.yaml"
            },
            keyOrdering = false,
        },
    }
})
lsp.configure('pyright', {
    settings = {
        pyright = { disableOrganizeImports = false },
        python = {
            analysis = {
                autoImportCompletions = false,
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
            }
        }
    }
})

lsp.setup()
