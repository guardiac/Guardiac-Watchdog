-- [AntiDex] - Doesn't allow for the exploiter to save your game.

local AntiDex = {}

function AntiDex:Init()
	self.SecurityTokens = {}
	self:PreventInstanceSaving()
	self:ObfuscateInstances()
	self:BlockDexMethods()
end

function AntiDex:PreventInstanceSaving()
	-- Block saveinstance()
	local function deepProtect(instance)
		instance.Name = self:GenerateRandomString(32)

		for _, child in pairs(instance:GetChildren()) do
			deepProtect(child)
		end

		instance.ChildAdded:Connect(deepProtect)
	end

	deepProtect(game)
end

function AntiDex:ObfuscateInstances()
	local blacklistedProps = {
		"ClassName",
		"Name",
		"Parent",
		"Source"
	}

	local function obfuscate(instance)
		for _, prop in ipairs(blacklistedProps) do
			pcall(function()
				local value = instance[prop]
				if typeof(value) == "string" then
					self.SecurityTokens[instance] = self.SecurityTokens[instance] or {}
					self.SecurityTokens[instance][prop] = value
					instance[prop] = self:GenerateRandomString(32)
				end
			end)
		end
	end

	for _, instance in pairs(game:GetDescendants()) do
		obfuscate(instance)
		instance.DescendantAdded:Connect(obfuscate)
	end
end

function AntiDex:BlockDexMethods()
	-- Detect and block common Dex methods
	local blockedMethods = {
		"DexSpy",
		"DexExplorer",
		"PropertiesViewer",
		"GetObjects",
		"HttpGet"
	}

	for _, methodName in ipairs(blockedMethods) do
		game:GetService("RunService").Heartbeat:Connect(function()
			if getgenv()[methodName] then
				self:Flag("DexAttempt", {method = methodName})
				getgenv()[methodName] = nil
			end
		end)
	end
end

function AntiDex:GenerateRandomString(length)
	local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local str = ""
	for i = 1, length do
		local rand = math.random(1, #chars)
		str = str .. string.sub(chars, rand, rand)
	end
	return str
end

function AntiDex:Flag(type, data)
	local player = game.Players:GetPlayerFromCharacter(data.instance)
	if player then
		self.Core:KickPlayer(player, "Attempted to use " .. type)
	end
end

return AntiDex
