local Process = {}

function Process:Start()
	self.Running = true

	while self.Running do
		for _, player in pairs(game.Players:GetPlayers()) do
			self.Anti:DetectSpeed(player)
			self.Anti:DetectFly(player)
		end
		wait(0.1)
	end
end

return Process
