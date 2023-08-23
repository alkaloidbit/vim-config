local Job = require'plenary.job'

Job:new({
	command = 'dotbare',
	args = { 'ls-files', '--full-name' },
	cwd = '~/',
	env = { ['a'] = 'b' },
	on_exit = function (j, return_val)
		print(return_val)
		print(j:result())
	end,
}):sync()
