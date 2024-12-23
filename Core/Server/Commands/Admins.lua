local Admins = {
	Commands = setmetatable({
		kick = {
			Name = "kick",
			Args = "<player> [reason]",
			Function = function(self, player, args)
				local target = self.Functions:GetPlayer(args)
				if target then target:Kick(args) end
			end
		},
		freeze = {
			Name = "freeze",
			Args = "<player>",
			Function = function(self, player, args)
				local target = self.Functions:GetPlayer(args)
				if target and target.Character then
					for _, part in pairs(target.Character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.Anchored = true
						end
					end
				end
			end
		}
	}, {__index = require(script.Parent.Moderators).Commands, require(script.Parent.Fun).Commands})
}
return Admins
