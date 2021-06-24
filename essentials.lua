--[[
  Essentials Built-In Elements
]] --
local RunService = game:GetService("RunService")
local Elements = {
    {
        Class = "CircleLoader",
        onCreate = function(self, elementSettings)
            local Bar = Instance.new("ImageLabel")

            Bar.Name = self.Class
            Bar.AnchorPoint = Vector2.new(0.5, 0.5)
            Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Bar.BackgroundTransparency = 1.000
            Bar.Position = UDim2.new(0.5, 0, 0.5, 0)
            Bar.Size = UDim2.new(0, 75, 0, 75)
            Bar.Image = "http://www.roblox.com/asset/?id=6992425635"

            local Destroyed = false
            local stopLoop = false

            local element
            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Bar:Destroy()
                        Destroyed = true
                    end,
                    userSettings = {
                        {
                            Property = "Size",
                            Value = Bar.Size,
                            Occuring = true,
                            onChange = function(newValue)
                                Bar.Size = newValue
                            end
                        },
                        {
                            Property = "Position",
                            Value = Bar.Position,
                            Occuring = true,
                            onChange = function(newValue)
                                Bar.Position = newValue
                            end
                        },
                        {
                            Property = "AnchorPoint",
                            Value = Bar.AnchorPoint,
                            Occuring = true,
                            onChange = function(newValue)
                                Bar.AnchorPoint = newValue
                            end
                        },
                        {
                            Property = "Progress",
                            Value = 0,
                            Maximum = 100,
                            Minimum = 0,
                            Occuring = true,
                            onChange = function(newValue)
                                Bar.Rotation = (360 * (newValue / 100))
                            end
                        },
                        {
                            Property = "RotationSpeed",
                            Value = 1,
                            Maximum = 10,
                            Minimum = 0,
                            Occuring = true
                        },
                        {
                            Property = "Loading",
                            Value = false,
                            Occuring = true
                        },
                        {
                            Property = "Parent",
                            Value = Bar.Parent,
                            onChange = function(newValue)
                                Bar.Parent = newValue
                            end
                        }
                    }
                }
            )

            local loop
            loop = RunService.RenderStepped:Connect(function()
                    if element.Loading == true then
                        if element.Progress == 100 then
                            element.Progress = 0
                        else
                            element.Progress = element.Progress + element.RotationSpeed
                        end
                    end
                    if Destroyed == true then
                        loop:Disconnect()
                    end
            end)

            return element
        end
    },
    {
        Class = "ImageTileButton",
        onCreate = function(self, elementSettings)
            local Back = Instance.new("ImageButton")
            local Image = Instance.new("ImageLabel")

            --Properties:

            Back.Name = "Back"
            Back.AnchorPoint = Vector2.new(0.5, 0.5)
            Back.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Back.BackgroundTransparency = 1.000
            Back.BorderSizePixel = 0
            Back.Position = UDim2.new(0.5, 0, 0.5, 0)
            Back.Size = UDim2.new(0, 100, 0, 100)
            Back.Image = "http://www.roblox.com/asset/?id=6992732640"
            Back.ImageColor3 = Color3.fromRGB(255, 255, 255)
            Back.AutoButtonColor = false

            Image.Name = "Image"
            Image.Parent = Back
            Image.AnchorPoint = Vector2.new(0.5, 0.5)
            Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Image.BackgroundTransparency = 1.000
            Image.Position = UDim2.new(0.5, 0, 0.5, 0)
            Image.Size = UDim2.new(0.600000024, 0, 0.600000024, 0)
            Image.Image = ""

            local Destroyed = false
            local stopLoop = false

            local element
            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Back:Destroy()
                        Destroyed = true
                    end,
                    userSettings = {
                        {
                            Property = "Size",
                            Value = Back.Size,
                            Occuring = true,
                            onChange = function(newValue)
                                Back.Size = newValue
                            end
                        },
                        {
                            Property = "Parent",
                            Value = Back.Parent,
                            onChange = function(newValue)
                                Back.Parent = newValue
                            end
                        },
                        {
                            Property = "Image",
                            Value = Image.Image,
                            onChange = function(newValue)
                                Image.Image = newValue
                            end
                        },
                        {
                            Property = "onClick",
                            Value = function() end,
                            Type = "Function",
                            onChange = function(newValue)
                                Back.MouseButton1Click:Connect(newValue)
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = Back.ImageColor3,
                            onChange = function(newValue)
                                Back.ImageColor3 = newValue
                            end
                        }
                    }
                }
            )

            Back.MouseEnter:Connect(function()
                Back:TweenSize(
                    UDim2.new(0, (element.Size.X.Offset * 1.1), 0, (element.Size.Y.Offset * 1.1)),
                    Enum.EasingDirection.In,
                    Enum.EasingStyle.Sine,
                    0.125,
                    true
                )
            end)

            Back.MouseLeave:Connect(function()
                Back:TweenSize(
                    element.Size,
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Sine,
                    0.125,
                    true
                )
            end)
            

            
            return element
        end
    }
}
for i, v in pairs(Elements) do
    _G.atOm:createNewElementClass(v)
end