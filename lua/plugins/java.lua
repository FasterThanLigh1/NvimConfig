return {
  'nvim-java/nvim-java',
  lazy = false,
  config = function()
    require('java').setup()
    vim.lsp.config('jdtls', {
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "SdkmanJava",
            path = "$JAVA_HOME",
            default = true,
          }
        }
      }
    }
  }
})
    vim.lsp.enable('jdtls')
  end,
}
