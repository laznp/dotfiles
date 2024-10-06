return {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
        require("auto-session").setup {
            enabled = true,
            root_dir = vim.fn.stdpath "data" .. "/sessions/",
            auto_save = true,
            auto_restore = true,
            auto_create = true,
            suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
            auto_restore_last_session = false,
            use_git_branch = false,
            lazy_support = true,
            bypass_save_filetypes = nil,
            close_unsupported_windows = true,
            args_allow_single_directory = true,
            args_allow_files_auto_save = false,
            continue_restore_on_error = true,
            cwd_change_handling = false,
            log_level = "error",
    }
    end
}
