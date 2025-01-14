-- nvimtree
--TREESITTER
local M = { "nvim-tree/nvim-tree.lua" }
M.dependencies = { "nvim-tree/nvim-web-devicons", }
M.keys = { { '<leader>e', '<cmd>NvimTreeToggle<cr>' }, }
M.config = function()
	require('nvim-tree').setup({
		--root_dirs = {},
		auto_reload_on_write = true,
		disable_netrw = false,
		hijack_cursor = false,
		hijack_netrw = true,
		hijack_unnamed_buffer_when_opening = false,
		sort_by = "name",
		root_dirs = {},
		prefer_startup_root = false,
		sync_root_with_cwd = true,
		reload_on_bufenter = false,
		respect_buf_cwd = false,
		on_attach = "default",
		select_prompts = false,
		view = {
			adaptive_size = true,
			centralize_selection = true,
			width = 20,
			-- hide_root_folder = false,
			side = "left",
			preserve_window_proportions = true,
			number = false,
			relativenumber = false,
			signcolumn = "yes",
			float = {
				enable = false,
				quit_on_focus_loss = true,
				open_win_config = {
					relative = "editor",
					border = "rounded",
					width = 50,
					height = 20,
					row = 1,
					col = 1,
				},
			},
		},
		renderer = {
			add_trailing = false,
			group_empty = false,
			highlight_git = true,
			full_name = false,
			highlight_opened_files = "all",
			root_folder_label = ":t",
			indent_width = 2,
			indent_markers = {
				enable = true,
				inline_arrows = true,
				icons = {
					corner = "└",
					edge = "│",
					item = "│",
					none = " ",
				},
			},
			icons = {
				webdev_colors = true,
				git_placement = "before",
				padding = " ",
				symlink_arrow = " ➛ ",
				show = {
					file = true,
					folder = true,
					folder_arrow = true,
					git = true,
					modified = true,
				},
				glyphs = {
					default = "",
					symlink = "",
					bookmark = "󰆤",
					modified = "●",
					folder = {
						arrow_closed = "",
						arrow_open = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌",
					},
				},
			},
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
			symlink_destination = true,
		},
		hijack_directories = {
			enable = false,
			auto_open = true,
		},
		update_focused_file = {
			enable = true,
			debounce_delay = 15,
			update_root = true,
			ignore_list = {},
		},

		diagnostics = {
			enable = true,
			show_on_dirs = false,
			show_on_open_dirs = true,
			debounce_delay = 50,
			severity = {
				min = vim.diagnostic.severity.HINT,
				max = vim.diagnostic.severity.ERROR,
			},
			icons = {
				hint = "⚑",
				info = "",
				warning = "",
				error = "",
			},
		},
		filters = {
			dotfiles = true, --true,
			git_clean = false,
			no_buffer = false,
			custom = { "node_modules", "\\.cache" },
			exclude = { ".config" },
		},
		filesystem_watchers = {
			enable = true,
			debounce_delay = 50,
			ignore_dirs = {},
		},
		git = {
			enable = true,
			ignore = false,
			show_on_dirs = true,
			show_on_open_dirs = true,
			timeout = 200,
		},
		actions = {
			use_system_clipboard = true,
			change_dir = {
				enable = true,
				global = false,
				restrict_above_cwd = false,
			},
			expand_all = {
				max_folder_discovery = 300,
				exclude = {},
			},
			file_popup = {
				open_win_config = {
					col = 1,
					row = 1,
					relative = "cursor",
					border = "shadow",
					style = "minimal",
				},
			},
			open_file = {
				quit_on_open = false,
				resize_window = true,
				window_picker = {
					enable = true,
					picker = "default",
					chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
					exclude = {
						filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
						buftype = { "nofile", "terminal", "help" },
					},
				},
			},
			remove_file = {
				close_window = true,
			},
		},
		trash = {
			cmd = "trash",
			require_confirm = true,
		},
		live_filter = {
			prefix = "[FILTER]: ",
			always_show_folders = true,
		},
		tab = {
			sync = {
				open = false,
				close = false,
				ignore = {},
			},
		},
		notify = {
			threshold = vim.log.levels.INFO,
		},
		log = {
			enable = false,
			truncate = false,
			types = {
				all = false,
				config = false,
				copy_paste = false,
				dev = false,
				diagnostics = false,
				git = false,
				profile = false,
				watcher = false,
			},
		},
		system_open = {
			cmd = nil,
			args = {},
		},
	})
end

return M
