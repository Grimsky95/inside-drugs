cfg.Prefix.RegisterUsableItem(cfg.Phone.Item_Name, function(source)
    local src = source
	local Player = cfg.Prefix.GetPlayerFromId(src)

	if not Player.getInventoryItem(cfg.Phone.Item_Name) then return end

    TriggerClientEvent("SellDrugs:OpenPhone", src)
end)

cfg.Prefix.RegisterCommand('selldrugs-stats', 'admin', function(xPlayer, args)

    if Player["id"..args.playerID] then
        if args.action == "add" then
            addStatistic("id"..args.playerID, args.type, args.value)
            serverNotify(xPlayer.source, translate("server", "notify_selldrugs-stats_add", reformatInt(args.value), args.type, GetPlayerName(args.playerID)), "success", 5000)
            serverNotify(args.playerID, translate("server", "notify_selldrugs-stats_received", reformatInt(args.value), args.type, GetPlayerName(xPlayer.source)), "success", 5000)
        elseif args.action == "remove" then
            removeStatistic("id"..args.playerID, args.type, args.value)
            serverNotify(xPlayer.source, translate("server", "notify_selldrugs-stats_remove", reformatInt(args.value), args.type, GetPlayerName(args.playerID)), "error", 5000)
            serverNotify(args.playerID, translate("server", "notify_selldrugs-stats_taken", GetPlayerName(xPlayer.source), reformatInt(args.value), args.type), "error", 5000)
        end
    end
end, false, {help = translate("server", "command_selldrugs_description"), arguments = {{name = "playerID", help = translate("server", "command_selldrugs-stats_arg1_help"), type = "number"}, {name = "action", help = translate("server", "command_selldrugs-stats_arg2_help"), type = "string"}, {name = "type", help = translate("server", "command_selldrugs-stats_arg3_help"), type = "string"}, {name = "value", help = translate("server", "command_selldrugs-stats_arg4_help"), type = "number"}}})

cfg.Prefix.RegisterCommand('selldrugs', 'user', function(xPlayer, args)
    TriggerEvent("SellDrugs:Status_Selling_Drugs", xPlayer.source)
    -- Client-Side: TriggerServerEvent("SellDrugs:Status_Selling_Drugs")
    -- Server-Side: TriggerEvent("SellDrugs:Status_Selling_Drugs", source)
end, {help = translate("server", "command_selldrugs-stats_description")})

function Check_Item(id, itemName)
    local xPlayer = cfg.Prefix.GetPlayerFromId(id)

    if xPlayer then
        local item = xPlayer.getInventoryItem(itemName)

        if item ~= nil and item.count > 0 then
            return {name = itemName, amount = item.count, label = item.label}
        else
            return nil
        end
    end
end

function Check_Cash(id)
    local xPlayer = cfg.Prefix.GetPlayerFromId(id)

    if xPlayer then
        return xPlayer.getMoney()
    end
end

function Add_Cash(id, amount)
    local xPlayer = cfg.Prefix.GetPlayerFromId(id)

    if xPlayer then
        xPlayer.addMoney(amount)
    end
end

function Remove_Cash(id, amount)
    local xPlayer = cfg.Prefix.GetPlayerFromId(id)

    if xPlayer then
        xPlayer.removeMoney(amount)
    end
end

function Add_Item(id, itemName, amount)
    local xPlayer = cfg.Prefix.GetPlayerFromId(id)
    
    if xPlayer then
        xPlayer.addInventoryItem(itemName, amount)
    end
end

function Remove_Item(id, itemName, amount)
    local xPlayer = cfg.Prefix.GetPlayerFromId(id)
    
    if xPlayer then
        xPlayer.removeInventoryItem(itemName, amount)
    end
end
