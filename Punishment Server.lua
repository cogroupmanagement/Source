local serverSettings = require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)
local databaseService = require(99763061998283)
local exploitInProgress = false

local function checkPlayerPermissions(player)
	return _G.Adonis.CheckAdmin(player)
end

local function sendPunishmentWebhook(player, data)
	if serverSettings.Webhook.Enabled == true then
		local payload = {
			embeds = {{
				title = "Thread Found",
				url = "https://roblox.com/users/"..player.UserId.."/profile",
				description = "**Username:** "..player.Name.."\n**UserID:** "..player.UserId.."\n**Account Age:** "..player.AccountAge.."\n**OS:** Windows",
				color = 0x000000, 
				thumbnail = {
					url = "https://cdn.discordapp.com/attachments/1297576294048993302/1302408351673618464/Screenshot_2023-04-29_at_16.jpg?ex=672801cc&is=6726b04c&hm=df386423925a35f6b54291b37eec3a7bcf21fdfbe79ac937531604ce591bbdcb&"  -- Replace with your actual thumbnail URL
				},
				footer = {
					text = "Powered by CoSecure.",
					icon_url = "https://cdn.discordapp.com/attachments/1297576294048993302/1302408351673618464/Screenshot_2023-04-29_at_16.jpg?ex=672801cc&is=6726b04c&hm=df386423925a35f6b54291b37eec3a7bcf21fdfbe79ac937531604ce591bbdcb&"  -- Replace with your actual icon URL
				},
				fields = {
					{
						name = "Detected",
						value = "`"..data.Type.."`",
						inline = false 
					},
					{
						name = "Object",
						value = "`"..data.Parent.."`",
						inline = false
					},
					{
						name = "Active Players",
						value = #game.Players:GetPlayers(),
						inline = true
					},
					{
						name = "Max Server Size",
						value = game.Players.MaxPlayers,
						inline = true 
					},
					{
						name = "Place ID",
						value = game.PlaceId,
						inline = true 
					}
				}
			}}
		}

		game.HttpService:PostAsync(serverSettings.Webhook["Webhook URL"], game.HttpService:JSONEncode(payload))
	end
end

local function kickPlayer(player, data)
	player:Kick("Exploits have been detected from your client\n \nYou have been kicked from this game.\n \nFailed to verify object. Server and Client values are different.\nObject to verify: "..data.Object.."\nProperty to verify: "..data.Property.."\nClient Value: "..data.ClientValue.."\nServer Value: "..data.ServerValue)
end

local function banPlayer(player, data)
	game.Players:BanAsync({
		UserIds = {player.UserId},
		Duration = 60,
		DisplayReason = "Exploits have been detected from your client\n \nYou have been banned from this game.\n \nFailed to verify object. Server and Client values are different.\nObject to verify: "..data.Object.."\nProperty to verify: "..data.Property.."\nClient Value: "..data.ClientValue.."\nServer Value: "..data.ServerValue,
		PrivateReason = "Put anything here that the user should not know but is helpful for your records",
		ExcludeAltAccounts = false,
		ApplyToUniverse = true
	})
end

local function databaseLogging(player, data)
	local logTime = os.time()
	local logDate = os.date()
	
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/otherOutput/exploitDate", logDate)
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/otherOutput/exploitTime", logTime)
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/otherOutput/activePlayers", #game.Players:GetPlayers())
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/otherOutput/maxPlayers", game.Players.MaxPlayers)
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/otherOutput/placeId", game.PlaceId)
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/clientOutput/exploitType", data.Type)
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/clientOutput/exploitParent", data.Parent)
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/clientOutput/exploitObject", data.Object)
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/clientOutput/exploitPropery", data.Property)
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/clientOutput/exploitClientValue", data.ClientValue)
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/serverOutput/exploitServerValue", data.ServerValue)
end

local function determinePunishment(player, data)
	if exploitInProgress == false then
		exploitInProgress = true
		if data.Type == "Console" or data.Type == "Invisibility" or data.Type == "Jump Power" then
			if serverSettings.Punishments.Other == "kick" then
				sendPunishmentWebhook(player, data)
				databaseLogging(player, data)
				banPlayer(player, data)
			elseif serverSettings.Punishments.Other == "pban" then
				sendPunishmentWebhook(player, data)
				databaseLogging(player, data)
				banPlayer(player, data)
			end
		end
		wait(2.5)
		exploitInProgress = false
	end
end

game.ReplicatedStorage:WaitForChild("CoSecure").OnServerEvent:Connect(function(player, data)
	--if checkPlayerPermissions(player) == false then
		determinePunishment(player, data)
	--end
end)

--[[local function givePunishment(player, serverValue)
	if serverSettings.Webhook.Enabled == true then
		if exploitInProgress == false then
			local logTime = os.time()
			local logDate = os.date()
			exploitInProgress = true

			--[[databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/exploitDate", logDate)
			databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/exploitTime", logTime)
			databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/activePlayers", #game.Players:GetPlayers())
			databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/maxPlayers", game.Players.MaxPlayers)
			databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/placeId", game.PlaceId)
			databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/exploitType", detectionData.Type)
			databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/exploitObject", "game.Workspace."..player.Name.."."..detectionData.Object)
			databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/exploitPropery", detectionData.Property)
			databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/exploitClientValue", detectionData.ClientValue)
			databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/exploitServerValue", serverValue)
	
			player:Kick("Exploits have been detected from your client\n \nYou have been kicked from this game.\n \nFailed to verify object. Server and Client values are different.\nObject to verify: game.Workspace."..player.Name.."."..detectionData.Object.."\nProperty to verify: "..detectionData.Property.."\nClient Value: "..detectionData.ClientValue.."\nServer Value: "..serverValue)
			wait(1)
			exploitInProgress = false
		end
	end
end
--]]
--[[local function checkPunishment(player)
	if detectionData.Object == "Humanoid.JumpPower" or detectionData.Object == "Humanoid.JumpHeight" then
		if detectionData.Object == "Humanoid.JumpPower" then
			if detectionData.ClientValue ~= game.Workspace[player.Name].Humanoid.JumpPower then
				givePunishment(player, game.Workspace[player.Name].Humanoid.JumpPower)
			end
		elseif detectionData.Object == "Humanoid.JumpHeight" then
			if detectionData.ClientValue ~= game.Workspace[player.Name].Humanoid.JumpHeight then
				givePunishment(player, game.Workspace[player.Name].Humanoid.JumpHeight)
			end
		end
	else
		if detectionData.ClientValue ~= game.Workspace[player.Name][detectionData.Object][detectionData.Property] then
			givePunishment(player, game.Workspace[player.Name][detectionData.Object][detectionData.Property])
		end
	end 
end--]]

--[[if checkPlayer(player.Name) == true then
	return
else
	if checkGroup(player) == false then
		if serverSettings.AdminWhitelist == true then
			if checkAdonis(player) == false then
				checkPunishment(player)
			else
				return
			end
		else
			checkPunishment(player)
		end
	else
		return
	end
end--]]

--[[local function checkPlayer(player)
	return table.find(serverSettings.Whitelist.Players, player)
end

local function checkGroup(player)
	if serverSettings.Whitelist.Group == nil then
		return false
	else
		if player:GetRankInGroup(serverSettings.Whitelist.Group) >= serverSettings.Whitelist.Rank then
			return true
		else
			return false
		end
	end
end

local function checkAdonis(player)
	return _G.Adonis.CheckAdmin(player)
end--]]
