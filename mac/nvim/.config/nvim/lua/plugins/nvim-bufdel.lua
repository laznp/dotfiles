return {
    "ojroques/nvim-bufdel",
    config = function()
        require('bufdel').setup {
            next = 'cycle',
            quit = true,
        }
    end
}
