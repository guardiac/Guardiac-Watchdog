local Anti = {}

function Anti:DetectSpeed(player)
	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
	if humanoid and humanoid.WalkSpeed > 50 then
		self:Flag("SpeedHack", player)
	end
end

function Anti:DetectFly(player)
	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
	local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	if humanoid and rootPart then
		if rootPart.Position.Y > workspace.FallPartsMaxHeight then
			self:Flag("Flying", player)
		end
	end
end

function Anti:Flag(type, player)
	self.Remote:FireServer("Flag", type, player)
end

return Anti
