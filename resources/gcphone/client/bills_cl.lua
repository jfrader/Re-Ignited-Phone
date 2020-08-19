RegisterNetEvent("gcPhone:bills_getBilling")
AddEventHandler("gcPhone:bills_getBilling", function(billingg)
  SendNUIMessage({event = 'bills_billingg', billingg = billingg})
end)

RegisterNUICallback('bills_getBilling', function(data, cb)
  TriggerServerEvent('gcPhone:bills_getBilling', data.label, data.amount, data.sender)
end)

RegisterNUICallback('bills_payBill', function(data)
  TriggerServerEvent('gcPhone:billspayBill', data.id, data.sender, data.amount, data.target)
end)
