local Fun = {
	Commands = {
		sparkles = {
			Name = "sparkles",
			Args = "<player>",
			Function = function(self, player, args)
				local target = self.Functions:GetPlayer(args)
				if target and target.Character then
					local sparkles = Instance.new("Sparkles")
					sparkles.Parent = target.Character.PrimaryPart
				end
			end
		},
		fire = {
			Name = "fire",
			Args = "<player>",
			Function = function(self, player, args)
				local target = self.Functions:GetPlayer(args)
				if target and target.Character then
					local fire = Instance.new("Fire")
					fire.Parent = target.Character.PrimaryPart
				end
			end
		},
    Explode = {
		  Name = "explode",
			Args = "<player>",
			Function = function(self, player, args)
				local target = self.Functions:GetPlayer(args)
				if target and target.Character then
					local fire = Instance.new("Explosion")
					fire.Parent = target.Character.PrimaryPart
				end
			end
		}
	}
}
return Fun
