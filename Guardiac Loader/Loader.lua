local Guardiac = {}

function Guardiac:Init(config)
	self.Config = config or require(script.DefaultConfig)

	for _, module in pairs(script.Core:GetChildren()) do
		self[module.Name] = require(module)
	end

	for _, plugin in pairs(script.Plugins:GetChildren()) do
		local success, result = pcall(require, plugin)
		if success then
			result:Init()
		end
	end

	self.Active = true
end

return Guardiac
