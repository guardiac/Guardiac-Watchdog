local Creators = {
	Commands = setmetatable({
		shutdown = {
			Name = "shutdown",
			Args = "[reason]",
			Function = function(self, player, args)
				game:Shutdown()
			end
		},
		script = {
			Name = "script",
			Args = "<code>",
			Function = function(self, player, args)
				loadstring(args)()
			end
		}
	}, {__index = require(script.Parent.HeadAdmins).Commands, require(script.Parent.Admins).Commands, require(script.Parent.Moderators).Commands, require(script.Parent.Fun).Commands})
}
return Creators
