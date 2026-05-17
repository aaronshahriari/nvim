return function()
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			local name, kind = ev.data.spec.name, ev.data.kind
			if name == "dblite" and (kind == "install" or kind == "update") then
				if not ev.data.active then
					vim.cmd.packadd("dblite")
				end
				require("dblite.download").download_or_build()
			end
		end,
	})

	vim.pack.add({
		{ src = "https://github.com/aaronshahriari/dblite.nvim" },
	})

	pcall(function()
		require("dblite.download").ensure_binary()
	end)

	local dblite = require("dblite")
	dblite.setup({
		split_dir = "horizontal", -- 'vertical' | 'horizontal' | 'tab'
		split_size = { width = 80, height = 17 },
		page_size = 100, -- rows per page in the result buffer
		max_rows = 10000, -- hard cap on rows returned
		max_col_width = 50, -- truncate cells wider than this; 0 = no limit
		filetype = "", -- filetype for the result buffer ('' = no highlighting)
		flash_timeout = 1500, -- ms to hold the query highlight; 0 = hold until results
		json_view = "tab", -- where inspect opens: 'tab' | 'vertical' | 'horizontal' | 'float'
		inspect_format = "json", -- default inspect format: 'json' | 'table' | 'csv'
		panel = {
			width = 30, -- side panel width in columns
		},
		binds_split = {
			split_dir = "vertical", -- "vertical" | "horizontal"
			width = 40, -- columns; used when split_dir = "vertical". 0 = let nvim decide.
			height = 20, -- rows; used when split_dir = "horizontal". 0 = let nvim decide.
		},
		style = {
			dbout = {
				cursorline = false, -- highlight the line under the cursor
				-- Status line sections. Each entry: { "item", sep = "…", hl = "HlGroup" }
				-- Available items: "pagination" | "query_time" | "connection"
				-- sep   — separator printed before this item (default "  ·  ")
				-- hl    — highlight group applied to this item's text (optional)
				sections = {
					{ "pagination" },
					{ "query_time", sep = "  —  " },
					{ "connection", sep = "  ·  ", hl = "LineNr" },
				},
			},
		},
		keymaps = {
			dbout = {
				next = "L", -- next page
				prev = "H", -- previous page
				cancel = "<C-c>", -- cancel in-flight query
				inspect = "gi", -- open inspector for current page
			},
			panel = { select = "<CR>", edit = "cw", close = "q" },
		},
	})

	vim.keymap.set("n", "<leader>s", dblite.execute, { desc = "dblite: run query" })
	vim.keymap.set("n", "<CR>", dblite.execute_at_cursor, { desc = "dblite: run at cursor" })
	vim.keymap.set("n", "<leader>e", dblite.toggle_panel, { desc = "dblite: toggle panel" })
	vim.keymap.set("n", "<leader>h", dblite.toggle_dbout, { desc = "dblite: toggle dbout" })
	vim.keymap.set("n", "<leader>b", dblite.edit_binds, { desc = "dblite: edit binds" })
end
