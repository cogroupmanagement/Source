--[[

 ██████╗ ██████╗ ███████╗███████╗ ██████╗██╗   ██╗██████╗ ███████╗
██╔════╝██╔═══██╗██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██╔════╝
██║     ██║   ██║███████╗█████╗  ██║     ██║   ██║██████╔╝█████╗  
██║     ██║   ██║╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██╔══╝  
╚██████╗╚██████╔╝███████║███████╗╚██████╗╚██████╔╝██║  ██║███████╗
 ╚═════╝ ╚═════╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝

Script Name: Loader.lua
Author: Sam
Date: 02/11/2024 10:34 PM

]]--

--[[ Loader ]]--
local serverSettings = require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)
local databaseService = require(99763061998283)
local exploitInProgress = false

require(71256752642454)

local CoSecureFolder = game.ReplicatedStorage:FindFirstChild("CoSecure") or Instance.new("Folder")
CoSecureFolder.Name = "CoSecure"
CoSecureFolder.Parent = game.ReplicatedStorage

local ServerRemote = Instance.new("RemoteEvent")
ServerRemote.Name = "Server"
ServerRemote.Parent = game.ReplicatedStorage:FindFirstChild("CoSecure")

local ClientRemote = Instance.new("RemoteEvent")
ClientRemote.Name = "Client"
ClientRemote.Parent = game.ReplicatedStorage:FindFirstChild("CoSecure")

--[[ API ]]--
_G.CoSecureData = {}
_G.CoSecureData.GlobalBannedPlayers = {}
_G.CoSecureData.TempBannedPlayers = {}
_G.CoSecureData.BlacklistedPlayers = {}
_G.CoSecureData.WhitelistedPlayers = {}
_G.CoSecureData.Administrators = {}
_G.CoSecureData.Flags = {}
_G.CoSecureData.FrameworkDisabled = {}
_G.CoSecureData.OnDetection = Instance.new("BindableEvent")

_G.CoSecure = function(action, parameters)
	local playerName = parameters["Player"]

	if not playerName then
		warn("No player specified for action: " .. action)
		return
	end

	local targetPlayer = game.Players:FindFirstChild(playerName)
	if not targetPlayer then
		warn("Player " .. playerName .. " not found.")
		return
	end

	if action == "IsAdministrator" then
		return _G.CoSecureData.Administrators[targetPlayer.Name] ~= nil
	else
		warn("Unknown action: " .. action)
	end
end

--[[ Functions ]]--
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
					text = "Powered by CoGroup Systems.",
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

local function permanentBanPlayer(player, data)
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
				kickPlayer(player, data)
			elseif serverSettings.Punishments.Other == "pban" then
				sendPunishmentWebhook(player, data)
				databaseLogging(player, data)
				permanentBanPlayer(player, data)
			end
		end
		wait(2.5)
		exploitInProgress = false
	end
end

--[[ Code ]]--
game.Players.PlayerAdded:Connect(function(player)
	if checkPlayerPermissions(player) == true then
		_G.CoSecureData.Administrators[player.Name] = true
	end
end)

ServerRemote.OnServerEvent:Connect(function(player, data)
	--if checkPlayerPermissions(player) == false then
		determinePunishment(player, data)
	--end
end)
