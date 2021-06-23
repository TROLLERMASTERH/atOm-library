--[[
  Essentials Built-In Elements
]] --
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
            Bar.Size = UDim2.new(0, 200, 0, 200)
            Bar.Image = "http://www.roblox.com/asset/?id=6965496299"

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
                            Property = "Loading",
                            Value = false,
                            Occuring = true,
                            onChange = function(newValue)
                                if newValue == true then
                                    loadstring(
                                        [[
									while true do
										if element.Loading == true then
											if element.Progress == 100 then
												element.Progress = 0
											else
												element.Progress = element.Progress + 1
											end
										else
											break
										end
										if Destroyed == true then
											break
											end
											wait(0.1)
										end
									]]
                                    )()
                                end
                            end
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

            return element
        end
    }
}
for i, v in pairs(Elements) do
    print(v.Class .. " loaded!")
    _G.atOm:createNewElementClass(v)
end
