-- compile and run
local buffrunner = function()
	local get = {
		src = vim.fn.expand('%'),  --path of buffer file
		dest = vim.fn.expand('%:r'), --path buff without file ekstension
		type = vim.fn.expand('%:e'), --ekstension only
		name = vim.fn.expand('%:t:r'), --file name of buffer
		dir = vim.fn.expand('%:p:h') -- Direktori absolut tempat file berada
	}

	local Buffer = {
		-- HTML: Menjalankan server HTTP menggunakan Python
		html = { run = "cd " .. get.dir .. " && python3 -m http.server 2024" },

		-- Python: Menjalankan file Python
		py = { run = "python3 " .. get.src },

		--[[ BASH ]]
		sh = {
			run = "/usr/bin/bash " .. get.src
		},
		--[[ FISH ]]
		fish = {
			run = "fish " .. get.src
		},
		--[[ RUSTLANG ]]
		rs = {
			run = 'cd %:h && RUSTFLAGS=\\"-Awarnings\\" cargo run -q',
			-- pc
			-- run = 'cd %:h && cargo run -q',
			-- delTemp = " && sleep 0.1 && cargo clean",
		},
		--[[ C++ ]]
		cpp = {
			compile = string.format("g++ %s -o %s ", get.src, get.dest),
			run = string.format("&& %s ", get.dest),
			delTemp = string.format("&& rm -rf %s", get.dest)
		},
		--[[ JAVA ]]
		java = {
			compile = string.format("javac %s -d %s ", get.src, get.dest),
			run = string.format("&& cd %s && java %s ", get.dest, get.name),
			delTemp = string.format("&& cd $HOME && rm -rf %s", get.dest),
		},
		--[[ KOTLIN ]]
		kt = {
			compile = string.format("kotlinc %s -include-runtime -d %s.jar ", get.src, get.dest),
			run = string.format("&& java -jar %s.jar ", get.dest),
			delTemp = string.format("&& rm -rf %s.jar", get.dest),
		},
	}

	local cmd = ""
	if Buffer[get.type] then
		for _, action in ipairs({ "compile", "run", "delTemp" }) do
			if Buffer[get.type][action] then
				cmd = cmd .. Buffer[get.type][action]
			end
		end
	else
		vim.notify("\n[Err!] this file not setup!\n\nonly support for:\n{sh, fish, cpp, rush, java, kotlin}\n")
		return
	end

	if cmd ~= "" then
		-- save file
		vim.api.nvim_command(":w")
		-- compile, run, and delete binary temp
		vim.api.nvim_command("split term://" .. cmd)
	end

	-- Penanganan khusus untuk HTML
	if get.type == "html" then
		-- Menunggu beberapa saat untuk memastikan server berjalan
		vim.defer_fn(function()
			-- Membuka halaman web di browser default
			vim.fn.system("xdg-open http://localhost:2024/" .. get.name .. "." .. get.type)
		end, 1000) -- Menunggu 1 detik
	end
end

vim.keymap.set('n', '<leader>x', buffrunner)

-- Keymap untuk menjalankan `cargo run` di jendela terminal baru
vim.api.nvim_set_keymap(
	"n",
	"<Leader>cx",
	':term cd %:h && RUSTFLAGS=\"-Awarnings\" cargo run',
	{ noremap = true, silent = false }
)
