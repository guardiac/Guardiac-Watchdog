-- [AntiCheat] - Basic Anti-Cheat

local AntiCheat = {}

function AntiCheat:Init()
	self.Detections = {
		SpeedHack = true,
		Flying = true,
		Noclip = true,
		Teleport = true
	}

	game.Players.PlayerAdded:Connect(function(player)
		self:StartChecks(player)
	end)
end

function AntiCheat:StartChecks(player)
	spawn(function()
		while player.Parent do
			if self.Detections.SpeedHack then
				self:CheckSpeed(player)
			end
			if self.Detections.Flying then
				self:CheckFlying(player)
			end
			wait(0.1)
		end
	end)
end

return AntiCheat
