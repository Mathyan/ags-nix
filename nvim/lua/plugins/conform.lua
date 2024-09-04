return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sql-formatter" },
    },
    sql = {
      formatters = {
        exe = "sql-formatter",
        args = { "--indent", "2" },
      },
    },
  },
}
