-- [Logs] - Logs what Guardiac thinks is suspicious. Let's the admin decide.

local Logs = {}

function Logs:Log(message)
	print("[Guardiac]", message)

	local logTable = self.Variables:Get("Logs") or {}
	table.insert(logTable, {
		Time = os.time(),
		Message = message
	})
	self.Variables:Set("Logs", logTable)
end

return Logs
