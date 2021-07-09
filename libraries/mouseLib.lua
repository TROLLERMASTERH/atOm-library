--[[
    Mouse Library v0.1
    By: TROLLERMASTERH
    A mini libary used for gui mouse events
]]--
local MouseLibrary = {}

MouseLibrary.bindMouseEvents = function(gui, onHover, onLeave)
    local isHovering = false
    local isRunning = false
    UserInputService.InputChanged:Connect(
        function(input, gameProcessed)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local pos = input.Position
                local guisAtPosition = game.CoreGui:GetGuiObjectsAtPosition(pos.X, pos.Y)
                local hasFound = false

                for _, v in pairs(guisAtPosition) do
                    if v == gui then
                        isRunning = true
                        onHover()
                        isHovering = true
                        hasFound = true
                        isRunning = false
                    end
                end
                if hasFound == false and isHovering == true and isRunning == false then
                    onLeave()
                    isHovering = false
                end
            end
        end
    )
end

return MouseLibrary