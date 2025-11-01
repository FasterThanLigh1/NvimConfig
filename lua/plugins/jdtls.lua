return {
	"mfussenegger/nvim-jdtls",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	ft = { "java" }, -- Only load for Java files
}
