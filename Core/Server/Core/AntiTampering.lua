-- [AntiTampering] - Doesn't allow for the exploiter to tamper with you game's files.

local AntiTampering = {}

function AntiTampering:Init()
	self.ProtectedInstances = {}
	self:SetupInstanceProtection()
end

function AntiTampering:SetupInstanceProtection()
	local function protect(instance)
		if not self.ProtectedInstances[instance] then
			self.ProtectedInstances[instance] = true
			self:LockInstance(instance)
		end

		instance.DescendantAdded:Connect(function(child)
			protect(child)
		end)
	end

	protect(game:GetService("ReplicatedStorage"))
	protect(game:GetService("ServerScriptService"))
end

function AntiTampering:LockInstance(instance)
	local success, originalParent = pcall(function()
		return instance.Parent
	end)

	if success then
		instance:GetPropertyChangedSignal("Parent"):Connect(function()
			if instance.Parent ~= originalParent then
				self:Flag("InstanceTampering", {
					instance = instance,
					originalParent = originalParent,
					newParent = instance.Parent
				})
				instance.Parent = originalParent
			end
		end)
	end
end

return AntiTampering
