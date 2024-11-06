local serverSettings = require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)
local databaseService = require(99763061998283)
local exploitInProgress = false

local function sendPunishmentWebhook(player, data)
	if serverSettings.Webhook.Enabled == true then
		local payload = {
			embeds = {{
				title = "Thread Found",
				url = "https://roblox.com/users/"..player.UserId.."/profile",
				description = "**Username:** "..player.Name.."\n**UserID:** "..player.UserId.."\n**Account Age:** "..player.AccountAge.."\n**OS:** "..data.Executor,
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
						value = "`DarkHub`",
						inline = false 
					},
					{
						name = "Object",
						value = "`Player!DarkHub`",
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

local function banPlayer(player, data)
	game.Players:BanAsync({
		UserIds = {player.UserId},
		Duration = 10000,
		DisplayReason = "Exploits have been detected from your client\n \nYou have been banned from this game.\n \nDarkHub Detected",
		PrivateReason = "",
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
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/clientOutput/exploitType", "DarkHub")
	databaseService:GetDatabase(serverSettings["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/exploitLogs/"..player.Name.."/"..logTime.."/clientOutput/executor", data.Executor)
	databaseService:GetDatabase("Bans"):SetAsync(player.Name, "true")
end

if game.ReplicatedStorage:FindFirstChild("0f92267f-95c3-4775-b0c2-6fc46a4cdc5a") then
	game.ReplicatedStorage:WaitForChild("0f92267f-95c3-4775-b0c2-6fc46a4cdc5a").OnServerEvent:Connect(function(player, key, data)
		sendPunishmentWebhook(player, data)
		databaseLogging(player, data)
		banPlayer(player, data)
	end)
end
