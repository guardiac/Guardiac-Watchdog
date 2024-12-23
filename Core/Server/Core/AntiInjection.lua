-- [AntiInjection] - Doesn't allow for the exploiter to inject within your game.
local AntiInjection = {}

function AntiInjection:Init()
	self:ProtectProperties()
	self:MonitorScripts()
end


function AntiInjection:ProtectProperties()
	local protectedProps = {
		Workspace = {"Gravity", "StreamingEnabled"},
		Lighting = {"Ambient", "Brightness", "GlobalShadows"},
		StarterGui = {"ShowDevelopmentGui", "ScreenOrientation"}
	}

	for service, props in pairs(protectedProps) do
		for _, prop in ipairs(props) do
			self:LockProperty(game:GetService(service), prop)
		end
	end
end

function AntiInjection:LockProperty(instance, property)
	local original = instance[property]
	self.OriginalProperties[instance] = self.OriginalProperties[instance] or {}
	self.OriginalProperties[instance][property] = original

	pcall(function()
		instance:GetPropertyChangedSignal(property):Connect(function()
			if instance[property] ~= original then
				self:Flag("PropertyTampering", {
					instance = instance,
					property = property,
					value = instance[property]
				})
				instance[property] = original
			end
		end)
	end)
end

function AntiInjection:MonitorScripts()
	game.DescendantAdded:Connect(function(instance)
		if instance:IsA("LuaSourceContainer") then
			self:ValidateScript(instance)
		end
	end)
end

function AntiInjection:ValidateScript(script)
	local source = script.Source
	local hash = self:HashSource(source)

	if self:IsKnownMaliciousHash(hash) then
		self:Flag("MaliciousScript", {
			script = script,
			hash = hash
		})
		script:Destroy()
	end
end

return AntiInjection
