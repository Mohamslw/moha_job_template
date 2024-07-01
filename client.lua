ESX = exports["es_extended"]:getSharedObject()

-- Initialisation

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

-- Points

exports.ox_target:addBoxZone({
    coords = Config.Pos.BossActions,
    drawSprite = true,
    size = vec3(1, 1, 1),
    options = {
        {
            name = 'moha_template_job_'.. Config.Job.Name,
            icon = 'fa-solid fa-cube',
            label = 'Boss Actions',
            groups = Config.Job.Name,
            onSelect = function()
                if ESX.PlayerData.job.grade_name == 'boss' then
                    TriggerEvent('esx_society:openBossMenu', Config.Job.Name)
                else
                    ESX.ShowNotification('~r~Don\'t have access !')
                end
            end,
        }
    }
})

exports.ox_target:addBoxZone({
    coords = Config.Pos.Stash,
    drawSprite = true,
    size = vec3(1, 1, 1),
    options = {
        {
            name = 'moha_template_open_stash_'.. Config.Job.Name,
            icon = 'fa-solid fa-cube',
            label = 'Stash',
            groups = Config.Job.Name,
            onSelect = function()
                exports.ox_inventory:openInventory('stash', Config.Job.SocietyName)
            end,
        }
    }
})

exports.ox_target:addBoxZone({
    coords = Config.Pos.Cloakroom,
    drawSprite = true,
    size = vec3(1, 1, 1),
    options = {
        {
            name = 'moha_template_target_cloakroom_'.. Config.Job.Name,
            icon = 'fa-solid fa-cube',
            label = 'Cloakroom',
            groups = Config.Job.Name,
            onSelect = function()
                lib.showContext('moha_template_job_cloakroom_'.. Config.Job.Name)
            end,
        }
    }
})

exports.ox_target:addBoxZone({
    coords = Config.Pos.VehicleManagement,
    drawSprite = true,
    size = vec3(1, 1, 1),
    options = {
        {
            name = 'moha_template_target_garage_'.. Config.Job.Name,
            icon = 'fa-solid fa-cube',
            label = 'Garage',
            groups = Config.Job.Name,
            onSelect = function()
                lib.showContext('moha_template_job_garage_'.. Config.Job.Name)
            end,
        }
    }
})

-- Cloakroom

lib.registerContext({
    id = 'moha_template_job_cloakroom_'.. Config.Job.Name,
    title = 'Cloakroom',
    options = {
        {
            title = 'Civil',
            icon = 'circle',
            onSelect = function()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                end)
            end,
        },
        {
            title = 'Job',
            icon = 'circle',
            onSelect = function()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    if skin and ESX.PlayerData and ESX.PlayerData.job then
                        local playerGrade = ESX.PlayerData.job.grade
                
                        if Config.Clothes[playerGrade] then
                            local clothes = Config.Clothes[playerGrade]
                
                            if skin.sex == 0 then
                                TriggerEvent('skinchanger:loadClothes', skin, clothes.male)
                            else
                                TriggerEvent('skinchanger:loadClothes', skin, clothes.female)
                            end
                        else
                            print("No clothes data found for grade: " .. tostring(playerGrade))
                        end
                    else
                        print("Player skin data or job data is missing.")
                    end
                end)                
            end,
        },
    }
})

-- Garage

local options_garage = {}

for k, vehicles in pairs(Config.Vehicles) do
    table.insert(options_garage, {
        title = vehicles,
        icon = 'fa-solid fa-cube',
        onSelect = function()
            ESX.Game.SpawnVehicle(vehicles, Config.Pos.VehicleSpawn.xyz, Config.Pos.VehicleSpawn.heading)
        end,
    })
end

table.insert(options_garage, {
    title = 'Supprimer véhicule',
    icon = 'fa-solid fa-cube',
    onSelect = function()
        local vehicle = ESX.Game.GetVehiclesInArea(Config.Pos.VehicleSpawn.xyz, 5)
        for k, vehicles in pairs(vehicle) do
            ESX.Game.DeleteVehicle(vehicles)
        end
    end,
})

lib.registerContext({
    id = 'moha_template_job_garage_'.. Config.Job.Name,
    title = 'Garage',
    options = options_garage
})