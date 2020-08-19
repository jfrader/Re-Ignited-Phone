ESX = nil

Citizen.CreateThread(function()
    while not ESX do
        ESX = exports.es_extended:getSharedObject()

        Citizen.Wait(100)
      ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
                    for k, bill in pairs(bills) do
                       Bills[k] = bill
                    end
                     SendNUIMessage({event = 'bills_bills', bills = Bills})
        end)
    end
end)

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

RegisterNetEvent("gcPhone:allBilling")
AddEventHandler("gcPhone:allBilling", function(allbillings)
  SendNUIMessage({event = 'updateBillings', messages = allbillings})
  billings = allbillings
end)
