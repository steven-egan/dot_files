return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local utils = require("utils")
		_Gopts = {
			position = "center",
			hl = "Type",
			wrap = "overflow",
		}

		local function get_all_files_in_dir(dir)
			local files = {}
			local scan = vim.fn.globpath(dir, "**/*.lua", true, true)
			for _, file in ipairs(scan) do
				table.insert(files, file)
			end
			return files
		end

		local function load_random_header()
			math.randomseed(os.time())
			local header_folder = vim.fn.stdpath("config") .. "/lua/custom/plugins/header_img/"
			local files = get_all_files_in_dir(header_folder)

			if #files == 0 then
				return nil
			end

			local random_file = files[math.random(#files)]
			local relative_path = random_file:sub(#header_folder + 1)
			local module_name = "custom.plugins.header_img."
				.. relative_path:gsub("/", "."):gsub("\\", "."):gsub("%.lua$", "")

			package.loaded[module_name] = nil

			local ok, module = pcall(require, module_name)
			if ok and module.header then
				return module.header
			else
				return nil
			end
		end

		local function change_header()
			local new_header = load_random_header()
			if new_header then
				dashboard.config.layout[2] = new_header
				vim.cmd("AlphaRedraw")
			else
				print("No images inside header_img folder.")
			end
		end

		local header = load_random_header()
		if header then
			dashboard.config.layout[2] = header
		else
			print("No images inside header_img folder.")
		end

		-- dashboard.section.tasks = {
		-- 	type = "text",
		-- 	val = utils.get_today_tasks(),
		-- 	opts = {
		-- 		position = "center",
		-- 		hl = "Comment",
		-- 		width = 50,
		-- 	},
		-- }

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
            dashboard.button("SPC b", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
            dashboard.button("<C-r>", "❓ Open random note", ":lua require('utils').open_random_note()<CR>"),
			dashboard.button("<C-t>", "✅ Toggle tasks", function()
				require("utils").show_interactive_tasks()
			end),
			dashboard.button("w", "🖌️ Change header image", function()
				change_header()
			end),
			dashboard.button("c", "🛠️ Settings", ":e $HOME/.config/nvim/init.lua<CR>"),
			dashboard.button("r", "⌛ Recent files", ":Telescope oldfiles <CR>"),
            dashboard.button("<C-p>", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
            dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
            dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
        }

        dashboard.config.layout = {
			{ type = "padding", val = 3 },
			header,
			{ type = "padding", val = 2 },
			{
				type = "group",
				val = {
					{
						type = "group",
						val = {
							{
								type = "text",
								val = "📅 Tasks for today",
								opts = { hl = "Keyword", position = "center" },
							},
							dashboard.section.tasks,
						},
						opts = { spacing = 1 },
					},
					{
						type = "group",
						val = dashboard.section.buttons.val,
						opts = { spacing = 1 },
					},
				},
				opts = {
					layout = "horizontal",
				},
			},
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			desc = "Add Alpha dashboard footer",
			once = true,
			callback = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
				dashboard.section.footer.val =
					{ " ", " ", " ", " Loaded " .. stats.count .. " plugins  in " .. ms .. " ms " }
				dashboard.section.header.opts.hl = "DashboardFooter"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)
	end,
}

