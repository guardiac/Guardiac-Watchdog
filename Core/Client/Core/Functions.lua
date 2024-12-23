local Functions = {}

function Functions:GetPlayer(name)
	for _, player in pairs(game.Players:GetPlayers()) do
		if player.Name:lower():sub(1, #name) == name:lower() then
			return player
		end
	end
end

return Functions
