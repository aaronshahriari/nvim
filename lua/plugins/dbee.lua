return function()
	vim.pack.add({
		{ src = "https://github.com/MunifTanjim/nui.nvim" },
		{ src = "https://github.com/kndndrj/nvim-dbee" },
	})

	local dbee = require("dbee")
	dbee.install()

	dbee.setup({
		result = {
			focus_result = false,
			page_size = 25,
			mappings = {
				{ key = "L", mode = "", action = "page_next" },
				{ key = "H", mode = "", action = "page_prev" },
				{ key = "E", mode = "", action = "page_last" },
				{ key = "F", mode = "", action = "page_first" },
				{ key = "yaj", mode = "n", action = "yank_current_json" },
				{ key = "yaj", mode = "v", action = "yank_selection_json" },
				{ key = "yaJ", mode = "", action = "yank_all_json" },
				{ key = "yac", mode = "n", action = "yank_current_csv" },
				{ key = "yac", mode = "v", action = "yank_selection_csv" },
				{ key = "yaC", mode = "", action = "yank_all_csv" },
				{ key = "<C-c>", mode = "", action = "cancel_call" },
			},
		},
		editor = {
			mappings = {
				{ key = "BB", mode = "v", action = "run_selection" },
				{ key = "BB", mode = "n", action = "run_file" },
				{ key = "<CR>", mode = "n", action = "run_under_cursor" },
			},
		},
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "dbee", "dbui" },
		callback = function()
			vim.wo.foldmethod = "manual"
			vim.wo.foldexpr = "0"
		end,
	})

	vim.keymap.set("n", "<leader>r", function()
		local valid_formats = {
			table = true,
			csv = true,
			json = true,
		}

		vim.ui.input({
			prompt = "DBee output format (table/csv/json): ",
			default = "table",
		}, function(format)
			if not format or format == "" then
				return
			end

			format = vim.trim(format):lower()

			if not valid_formats[format] then
				vim.notify("Invalid DBee format: " .. format .. "\nOptions: table, csv, json", vim.log.levels.ERROR)
				return
			end

			vim.cmd("tabnew")
			local buf = vim.api.nvim_get_current_buf()

			vim.bo[buf].buftype = "nofile"
			vim.bo[buf].bufhidden = "wipe"
			vim.bo[buf].swapfile = false
			vim.bo[buf].buflisted = false

			dbee.store(format, "buffer", {
				extra_arg = buf,
			})
		end)
	end, { desc = "DBee: results in new tab with chosen format" })
end
