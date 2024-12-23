-- [CrossServer/Game] - Doesn't allow for the exploiter to enter games powered by Guardiac.

local CrossServer = {}

function CrossServer:Init()
	self.BanStore = game:GetService("DataStoreService"):GetDataStore("GuardiacBans")

	game.Players.PlayerAdded:Connect(function(player)
		self:CheckBans(player)
	end)
end

function CrossServer:CheckBans(player)
	local success, banned = pcall(function()
		return self.BanStore:GetAsync(player.UserId)
	end)

	if success and banned then
		player:Kick("You are banned from all games powered by Guardiac.")
	end
end

return CrossServer
