local HeadAdmins = {
	Commands = setmetatable({
		ban = {
			Name = "ban",
			Args = "<player> [reason]",
			Function = function(self, player, args)
				local target = self.Functions:GetPlayer(args)
				if target then self.Anti:BanPlayer(target) end
			end
		},
		logs = {
			Name = "logs",
			Function = function(self, player)
				self.Logs:ShowTo(player)
			end
		}
	}, {__index = require(script.Parent.Admins).Commands, require(script.Parent.Moderators).Commands, require(script.Parent.Fun).Commands})
}
return HeadAdmins
