return function()
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			local name, kind = ev.data.spec.name, ev.data.kind
			if name == "dblite" and (kind == "install" or kind == "update") then
				if not ev.data.active then vim.cmd.packadd("dblite") end
				require("dblite.download").download_or_build()
			end
		end,
	})

	vim.pack.add({
		-- { src = "https://github.com/aaronshahriari/dblite" },
		{ src = "git@git_personal:aaronshahriari/dblite" },
	})

	pcall(function()
		require("dblite.download").ensure_binary()
	end)

	local dblite = require("dblite")
	dblite.setup({
		split_dir = "horizontal",
		split_size = { width = 80, height = 20 },
		page_size = 100,
		max_rows = 10000,
		max_col_width = 50,
		keymaps = {
			dbout = { next = "L", prev = "H", cancel = "<C-c>" },
		},
	})
end
