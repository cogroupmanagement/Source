service.Events.CommandRan:Connect(function(player, data)
		service.Events.LogAdded:Fire("Command", {Text = "Player1: :ff me", Desc = "Player1 ran a command"}, server.Logs.Commands)
		local logTime = os.time()
		local logDate = os.date()
		print(data)
	
		for i,v in pairs(data.Options) do
			require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/commandOptions/"..i, v)
		end
		
		for i,v in pairs(data.Args) do
			require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/commandArgs/"..i, v)
		end
		
		for i,v in pairs(data.Command.Args) do
			require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/args/"..i, v)
		end
		
		for i,v in pairs(data.Command.Commands) do
			require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/commands/"..i, v)
		end
		
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/serverOutput/commandDate", logDate)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/serverOutput/commandTime", logTime)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/serverOutput/activePlayers", #game.Players:GetPlayers())
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/serverOutput/maxPlayers", game.Players.MaxPlayers)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/serverOutput/placeId", game.PlaceId)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/adminLevel", data.Command.AdminLevel)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/allowDonors", data.Command.AllowDonors)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/crossServerDenied", data.Command.CrossServerDenied)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/dangerous", data.Command.Dangerous)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/description", data.Command.Description)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/disabled", data.Command.Disabled)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/donors", data.Command.Donors)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/filter", data.Command.Filter)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/fun", data.Command.Fun)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/hidden", data.Command.Hidden)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/isCrossServer", data.Command.IsCrossServer)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/noLog", data.Command.NoLog)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/noStudio", data.Command.NoStudio)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/nonChattable", data.Command.NonChattable)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/command/prefix", data.Command.Prefix)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/commandIndex", data.Index)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/commandMatched", data.Matched)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/commandMessage", data.Message)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/playerData/level", data.PlayerData.Level)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/playerData/player", data.PlayerData.Player.Name)
		require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):SetAsync("serverLogs/"..game.PlaceId.."/commandLogs/"..player.Name.."/"..logTime.."/adonisOutput/success", data.Success)
		
		if WebhookEnabled == true then
			local function formatArgsForWebhook(args)
				if type(args) == "table" then
					if next(args) == nil then
						return "None"
					else
						return table.concat(args, ", ")
					end
				else
					return tostring(args)
				end
			end

			local function formatArgsForWebhook2(args)
				if type(args) == "table" then
					if next(args) == nil then
						return "None"
					else
						local formattedArgs = {}
						for key, value in pairs(args) do
							table.insert(formattedArgs, "`"..tostring(key) .. ":` `" .. tostring(value).."`")
						end
						return table.concat(formattedArgs, "\n")
					end
				else
					return tostring(args)
				end
			end
			
			local payload = {
				embeds = {{
					title = "Command Log",
					url = "https://roblox.com/users/"..player.UserId.."/profile",
					description = "**Username:** "..player.Name.."\n**UserID:** "..player.UserId.."\n**Account Age:** "..player.AccountAge.."\n**Group Rank:** "..player:GetRoleInGroup(require(99763061998283):GetDatabase(require(game.ServerScriptService["CoSecure Anti Exploit"].Settings)["License Key"]):GetAsync("groupId")),
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
							name = "",
							value = "**`Args:`** `"..formatArgsForWebhook(data.Args).."`",
							inline = false 
						},
						{
							name = "",
							value = "**`Admin Level:`** `"..tostring(data.Command.AdminLevel).."`\n**`AllowDonors:`** `"..tostring(data.Command.AllowDonors).."`\n**`Args:`** `"..formatArgsForWebhook(data.Command.Args).."`\n**`Commands:`** `"..formatArgsForWebhook(data.Command.Commands).."`\n**`CrossServerDenied:`** `"..tostring(data.Command.CrossServerDenied).."`\n**`Dangerous:`** `"..tostring(data.Command.Dangerous).."`\n**`Description:`** `"..tostring(data.Command.Description).."`\n**`Disabled:`** `"..tostring(data.Command.Disabled).."`\n**`Donors:`** `"..tostring(data.Command.Donors).."`\n**`Filter`** `"..tostring(data.Command.Filter).."`\n**`Fun:`** `"..tostring(data.Command.Fun).."`\n**`Function:`** `"..tostring(data.Command.Function).."`\n**`Hidden:`** `"..tostring(data.Command.Hidden).."`\n**`IsCrossServer:`** `"..tostring(data.Command.IsCrossServer).."`\n**`NoLog:`** `"..tostring(data.Command.NoLog).."`\n**`NoStudio:`** `"..tostring(data.Command.NoStudio).."`\n**`NonChattable:`** `"..tostring(data.Command.NonChattable).."`\n**`Prefix:`** `"..tostring(data.Command.Prefix).."`\n**`_crossCooldownCache:`** `"..formatArgsForWebhook(data.Command["_crossCooldownCache"]).."`\n**`_fullName:`** `"..tostring(data.Command["_fullName"]).."`\n**`_playerCooldownCache:`** `"..formatArgsForWebhook(data.Command["_playerCooldownCache"]).."`\n**`_serverCooldownCache`** `"..formatArgsForWebhook(data.Command["_serverCooldownCache"]).."`",
							inline = false 
						},
						{
							name = "",
							value = "**`Index:`** `"..tostring(data.Index).."`\n".."**`Matched:`** `"..tostring(data.Matched).."`\n".."**`Message:`** `"..tostring(data.Message).."`",
							inline = false 
						},
						{
							name = "",
							value = "**`Options:`** \n"..formatArgsForWebhook2(data.Options),
							inline = false 
						},
						{
							name = "",
							value = "**`PlayerData:`** \n"..formatArgsForWebhook2(data.PlayerData),
							inline = false 
						},
						{
							name = "",
							value = "**`Success:`** `"..tostring(data.Success).."`",
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

			game.HttpService:PostAsync(WebhookURL, game.HttpService:JSONEncode(payload))
		end
	end)
