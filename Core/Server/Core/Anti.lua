-- [Anti] - Basic Anti-Cheat. OUTDATED. WILL BE UPDATED.

local Anti = {}

function Anti:HandleFlag(player, flagType)
	self.Logs:Log(player.Name .. " was flagged for " .. flagType)

	if flagType == "SpeedHack" then
		self.Admin:Kick(player, "Speed hacking detected")
	elseif flagType == "Flying" then
		self.Admin:Kick(player, "Flying detected")
	end
end

return Anti
