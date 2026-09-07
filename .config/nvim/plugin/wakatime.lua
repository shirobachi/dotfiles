local add, later = MiniDeps.add, MiniDeps.later

later(function()
	add("wakatime/vim-wakatime")
end)
