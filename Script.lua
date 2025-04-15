local Fluent = loadstring(game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Fluent:CreateWindow({
    Title = "Muscle Legend pro alpha",
    SubTitle = "by Zizu",
    TabWidth = 160,
    Size = UDim2.new(0, 500, 0, 400),
    Theme = "Dark",
    Acrylic = false
})

local Tab = Window:AddTab({ Title = "Auto", Icon = "zap" })

-- Variabili stato
local autoLiftEnabled = false
local autoRebirthEnabled = false
local autoChestEnabled = false

local autoLiftConnection
local autoRebirthConnection
local autoChestConnection

-- AUTO-LIFT
Tab:AddButton({
    Title = "Attiva/Disattiva Auto-Lift",
    Description = "Premi per avviare o fermare il sollevamento automatico",
    Callback = function()
        autoLiftEnabled = not autoLiftEnabled

        if autoLiftEnabled then
            autoLiftConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local args = { [1] = "rep" }
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))
            end)

            Fluent:Notify({
                Title = "Auto-Lift Attivato",
                Content = "Sollevamento automatico in corso.",
                Duration = 3
            })
        else
            if autoLiftConnection then
                autoLiftConnection:Disconnect()
                autoLiftConnection = nil
            end

            Fluent:Notify({
                Title = "Auto-Lift Disattivato",
                Content = "Sollevamento automatico fermato.",
                Duration = 3
            })
        end
    end
})

-- AUTO-REBIRTH
Tab:AddButton({
    Title = "Attiva/Disattiva Auto-Rebirth",
    Description = "Esegue automaticamente il rebirth se possibile",
    Callback = function()
        autoRebirthEnabled = not autoRebirthEnabled

        if autoRebirthEnabled then
            autoRebirthConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local args = { [1] = "rebirthRequest" }
                pcall(function()
                    game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer(unpack(args))
                end)
            end)

            Fluent:Notify({
                Title = "Auto-Rebirth Attivato",
                Content = "Rebirth automatico attivo.",
                Duration = 3
            })
        else
            if autoRebirthConnection then
                autoRebirthConnection:Disconnect()
                autoRebirthConnection = nil
            end

            Fluent:Notify({
                Title = "Auto-Rebirth Disattivato",
                Content = "Rebirth automatico fermato.",
                Duration = 3
            })
        end
    end
})

-- AUTO-CHEST
Tab:AddButton({
    Title = "Attiva/Disattiva Auto-Chest",
    Description = "Raccoglie automaticamente tutte le chest disponibili",
    Callback = function()
        autoChestEnabled = not autoChestEnabled

        if autoChestEnabled then
            autoChestConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local chests = {
                    "Magma Chest",
                    "Mythical Chest",
                    "Golden Chest",
                    "Enchanted Chest",
                    "Legends Chest",
                    "Jungle Chest1"
                }

                for _, chestName in ipairs(chests) do
                    pcall(function()
                        local args = { [1] = chestName }
                        game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(unpack(args))
                    end)
                end
            end)

            Fluent:Notify({
                Title = "Auto-Chest Attivato",
                Content = "Farm delle chest automatico attivo.",
                Duration = 3
            })
        else
            if autoChestConnection then
                autoChestConnection:Disconnect()
                autoChestConnection = nil
            end

            Fluent:Notify({
                Title = "Auto-Chest Disattivato",
                Content = "Farm delle chest fermato.",
                Duration = 3
            })
        end
    end
})
