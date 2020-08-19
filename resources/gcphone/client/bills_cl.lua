RegisterNetEvent("kidz:bills_getBilling")
AddEventHandler("kidz:bills_getBilling", function(billingg)
  SendNUIMessage({event = 'bills_billingg', billingg = billingg})
end)

RegisterNUICallback('bills_getBilling', function(data, cb)
  TriggerServerEvent('kidz:bills_getBilling', data.label, data.amount, data.sender)
end)

RegisterNUICallback('bills_payBill', function(data)
  TriggerServerEvent('kidz:billspayBill', data.id, data.sender, data.amount, data.target)
end)
