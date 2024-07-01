TriggerEvent('esx_society:registerSociety', Config.Job.Name, Config.Job.Label, Config.Job.SocietyName, Config.Job.SocietyName, Config.Job.SocietyName, {type = 'public'})

-- Register Stash

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        exports.ox_inventory:RegisterStash(Config.Job.SocietyName, Config.Job.Label, Config.Stash.Slots, Config.Stash.Weight, false, {[Config.Job.Name] = 0}, Config.Pos.Stash)
    end
end)