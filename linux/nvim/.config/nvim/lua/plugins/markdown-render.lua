-- return {
    -- 'MeanderingProgrammer/render-markdown.nvim',
    -- lazy = false,
    -- dependencies = {
        -- "nvim-treesitter/nvim-treesitter",
        -- "nvim-tree/nvim-web-devicons"
    -- },
    -- opts = function()
        -- require("render-markdown").setup({
            -- -- render_modes = true,
            -- heading = {
                -- -- icons = {}
                -- position = 'inline',
            -- },
            -- code = {
                -- width = 'block',
                -- position = 'right',
                -- left_pad = 2,
                -- right_pad = 2,
            -- },
        -- });
    -- end,
-- }
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
}
