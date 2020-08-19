ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function BillsGetBilling (accountId, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll([===[
      SELECT * FROM billing WHERE identifier = @identifier
      ]===], { ['@identifier'] = xPlayer.identifier }, cb)
end 

function getUserBills(phone_number, firstname, cb)
  MySQL.Async.fetchAll("SELECT firstname, phone_number FROM users WHERE users.firstname = @firstname AND users.phone_number = @phone_number", {
    ['@phone_number'] = phone_number,
	['@firstname'] = firstname
  }, function (data)
    cb(data[1])
  end)
end

RegisterServerEvent('gcPhone:Bills_getBilling')
AddEventHandler('gcPhone:Bills_getBilling', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
  if phone_number ~= nil and phone_number ~= "" and firstname ~= nil and firstname ~= "" then
    getUserBills(phone_number, firstname, function (user)
      local accountId = user and user.id
      BillsGetBilling(accountId, function (billingg)
        TriggerClientEvent('gcPhone:Bills_getBilling', sourcePlayer, billingg)
      end)
    end)
  else
    BillsGetBilling(nil, function (billingg)
      TriggerClientEvent('gcPhone:Bills_getBilling', sourcePlayer, billingg)
    end)
  end
end)


RegisterServerEvent("gcPhone:BillspayBill")
AddEventHandler("gcPhone:BillspayBill", function(id, sender, amount, target, sharedAccountName, cb)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE id = @id', {
		['@id'] = id
	}, function(data)

	
	local target = data[1].target
	local target_type = data[1].target_type
	local amount     = data[1].amount
	
	local xTarget = ESX.GetPlayerFromIdentifier(sender)
	
	if target_type=='player' then
    if xTarget ~= nil then	
        if xPlayer.getBank() >= amount then	

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeAccountMoney('bank', amount)
						xTarget.addAccountMoney('bank',amount)

						TriggerClientEvent("esx:showNotification", src, "Billsyı Ödedin $" .. amount)
						TriggerClientEvent("esx:showNotification", xTarget.source, "Bir Billsn Ödendi $" .. amount)

					end)
					
				else
				
					TriggerClientEvent("esx:showNotification", xTarget.source, "Müşterin Bankasında Para Yok.")
					TriggerClientEvent("esx:showNotification", src, "Bankada Para Yok")

				end
				else
	        TriggerClientEvent('esx:showNotification', src, "Oyunda Değil")
    end
	
	else
	
	
TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)	


 
        if xPlayer.getBank() >= amount then	

					MySQL.Async.execute('DELETE from billing WHERE id = @id', {
						['@id'] = id
					}, function(rowsChanged)
						xPlayer.removeAccountMoney('bank', amount)
						account.addMoney(amount)
                      
					  
					  if xPlayer ~= nil then
						TriggerClientEvent("esx:showNotification", xPlayer.source, "Bills ödendi $" .. amount)
					   end
                        if xTarget ~= nil then
						TriggerClientEvent("esx:showNotification", xTarget.source, "Bills Ödendi $" .. amount)
                        end

					end)
					
				else
				if xPlayer ~= nil then
					TriggerClientEvent("esx:showNotification", xPlayer.source, "Yeterli paran yok.")
				end	
					if xTarget ~= nil then
						TriggerClientEvent('esx:showNotification', xTarget.source, "Para yok")
					end


				end
	
end)

end

end)
end)
