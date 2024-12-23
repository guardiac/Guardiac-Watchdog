local Moderators = {
	Commands = setmetatable({
		respawn = {
			Name = "respawn",
			Args = "<player>",
			Function = function(self, player, args)
				local target = self.Functions:GetPlayer(args)
				if target then target:LoadCharacter() end
			end
		},
		view = {
			Name = "view",
			Args = "<player>",
			Function = function(self, player, args)
				local target = self.Functions:GetPlayer(args)
				if target then
					self.Remote:FireClient(player, "ViewPlayer", target)
				end
			end
		}
	}, {__index = require(script.Parent.Fun).Commands})
}
return Moderators
