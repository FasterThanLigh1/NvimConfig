local jdtls = require("jdtls")

-- Determine OS-specific config directory
local config = "linux"
if vim.fn.has("mac") == 1 then
	config = "mac"
elseif vim.fn.has("win32") == 1 then
	config = "win"
end

-- Paths (adjust these to your system)
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

-- Find jdtls installation (if using Mason)
local mason_registry = require("mason-registry")
local jdtls_path = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls")
local config_dir = jdtls_path .. "/config_" .. config
local jar_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		jar_path,
		"-configuration",
		config_dir,
		"-data",
		workspace_dir,
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
		},
	},
	init_options = {
		bundles = {},
	},
}

jdtls.start_or_attach(config)
