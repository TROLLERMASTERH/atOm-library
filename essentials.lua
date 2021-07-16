--[[
  Essentials Built-In Elements
]] --

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local GuiLocation = game.CoreGui
local HttpService = game:GetService("HttpService")

--[[
    Mouse Library
]]--
local MouseLibrary = loadstring(game:HttpGet('https://raw.githubusercontent.com/TROLLERMASTERH/atOm-library/main/libraries/mouseLib.lua?flush_cache=True'))()

--[[
    Theme
]]--

local Package = {
    Name = "Essentials",
    Creator = "TROLLERMASTERH",
    Theme = {
        windows = {
            primaryColor = Color3.fromRGB(23, 23, 23),
            secondaryColor = Color3.fromRGB(38, 38, 38),
            titleColor = Color3.fromRGB(255, 255, 255),
            buttonColor = Color3.fromRGB(255, 255, 255),
            iconColor = Color3.fromRGB(255, 255, 255)
        },
        imageTileButtons = {
            primaryColor = Color3.fromRGB(23, 23, 23),
            hoverImageColor = Color3.fromRGB(255, 193, 37),
            imageColor = Color3.fromRGB(255, 255, 255),
            icon = "http://www.roblox.com/asset/?id=7005536545"
        },
        loaders = {
            primaryColor = Color3.fromRGB(255, 255, 255)
        },
        sections = {
            titleColor = Color3.fromRGB(255, 255, 255)
        },
        lines = {
            primaryColor = Color3.fromRGB(38, 38, 38)
        },
        textboxes = {
            primaryColor = Color3.fromRGB(23, 23, 23),
            secondaryColor = Color3.fromRGB(38, 38, 38),
            focusColor = Color3.fromRGB(255, 193, 37),
            textColor = Color3.fromRGB(255, 255, 255)
        },
        switches = {
            textColor = Color3.fromRGB(255, 255, 255),
            primaryColor = Color3.fromRGB(38, 38, 38),
            secondaryColor = Color3.fromRGB(255, 193, 37),
            ballPrimaryColor = Color3.fromRGB(255, 255, 255),
            ballSecondaryColor = Color3.fromRGB(38, 38, 38)
        },
        sliders = {
            textColor = Color3.fromRGB(255, 255, 255),
            primaryColor = Color3.fromRGB(38, 38, 38),
            secondaryColor = Color3.fromRGB(255, 193, 37)
        },
        buttons = {
            primaryColor = Color3.fromRGB(255, 193, 37),
            textColor = Color3.fromRGB(0, 0, 0)
        },
        dropdowns = {
            primaryColor = Color3.fromRGB(38, 38, 38),
            secondaryColor = Color3.fromRGB(23, 23, 23),
            focusColor = Color3.fromRGB(255, 193, 37),
            textColor = Color3.fromRGB(255, 255, 255),
            hoverTextColor = Color3.fromRGB(0, 0, 0)
        },
        checkboxes = {
            primaryColor = Color3.fromRGB(23, 23, 23),
            secondaryColor = Color3.fromRGB(38, 38, 38),
            focusColor = Color3.fromRGB(255, 193, 37)
        },
        tabs = {
            primaryColor = Color3.fromRGB(255, 193, 37),
            textColor = Color3.fromRGB(255, 255, 255)
        }
    }
}

--[[
    Mouse Library
]]



Package.Elements = {
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
                            Property = "primaryColor",
                            Value = (_G.atOm.theme.loaders.primaryColor or Bar.BackgroundColor3),
                            Occuring = true,
                            onChange = function(newValue)
                                Bar.BackgroundColor3 = newValue
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
            loop =
                RunService.RenderStepped:Connect(
                function()
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
                end
            )

            return element
        end
    },
    {
        Class = "Section",
        onCreate = function(self, elementSettings)
            local Section = Instance.new("Frame")
            local Content = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")
            local Title = Instance.new("TextLabel")

            Section.Name = "Section"
            Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Section.BackgroundTransparency = 1.000
            Section.Size = UDim2.new(0, 200, 0, 185)

            Content.Name = "Content"
            Content.Parent = Section
            Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Content.BackgroundTransparency = 1.000
            Content.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Content.Position = UDim2.new(0, 10, 0, 10)
            Content.Size = UDim2.new(0, 632, 0, 153)

            UIListLayout.Parent = Content
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 10)

            Title.Name = "Title"
            Title.Parent = Content
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Size = UDim2.new(0, 200, 0, 30)
            Title.Font = Enum.Font.Roboto
            Title.Text = ""
            Title.TextColor3 = (_G.atOm.theme.sections.titleColor or Color3.fromRGB(255, 255, 255))
            Title.TextSize = 25.000
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.TextYAlignment = Enum.TextYAlignment.Top

            local Destroyed = false
            local stopLoop = false

            local element
            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Section:Destroy()
                        Destroyed = true
                    end,
                    Content = Content,
                    userSettings = {
                        {
                            Property = "Parent",
                            Value = Section.Parent,
                            onChange = function(newValue)
                                Section.Parent = newValue
                            end
                        },
                        {
                            Property = "Title",
                            Value = Title.Text,
                            onChange = function(newValue)
                                Title.Text = newValue
                            end
                        },
                        {
                            Property = "titleColor",
                            Value = Title.TextColor3,
                            onChange = function(newValue)
                                Title.TextColor3 = newValue
                            end
                        }
                    }
                }
            )

            local updateSection = function()
                local ContentSize = UIListLayout.AbsoluteContentSize
                local addX = ContentSize.X
                if addX < 0 then
                    addX = 0
                end
                Section.Size = UDim2.new(0, ContentSize.X, 0, ContentSize.Y + 10)
            end
            UIListLayout.Changed:Connect(updateSection)

            return element
        end
    },
    {
        Class = "Seperator",
        onCreate = function(self, elementSettings)
            local Seperator = Instance.new("Frame")
            local Line = Instance.new("Frame")

            Seperator.Name = "Seperator"
            Seperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Seperator.BackgroundTransparency = 1.000
            Seperator.Size = UDim2.new(0, 0, 0, 20)

            Line.Name = "Line"
            Line.Parent = Seperator
            Line.AnchorPoint = Vector2.new(0, 0.5)
            Line.BackgroundColor3 = (_G.atOm.theme.lines.primaryColor or Color3.fromRGB(38, 38, 38))
            Line.BorderSizePixel = 0
            Line.Position = UDim2.new(0, 10, 0.5, 0)
            Line.Size = UDim2.new(0, 0, 0, 2)

            local Destroyed = false
            local stopLoop = false

            local element
            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Seperator:Destroy()
                        Destroyed = true
                    end,
                    userSettings = {
                        {
                            Property = "Parent",
                            Value = Seperator.Parent,
                            onChange = function(newValue)
                                Seperator.Parent = newValue
                                local List = Seperator.Parent:FindFirstChild("UIListLayout")
                                if List and Seperator.Parent:IsA("ScrollingFrame") then
                                    local refresh = function()
                                        if List.AbsoluteContentSize.X < Seperator.Parent.AbsoluteWindowSize.X then
                                            Line.Size = UDim2.new(0, Seperator.Parent.AbsoluteWindowSize.X - 20, 0, 2)
                                        else
                                            Line.Size = UDim2.new(0, List.AbsoluteContentSize.X -20, 0, 2)
                                        end
                                    end
                                    List.Changed:Connect(function()
                                        refresh()
                                    end)
                                end
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = Line.BackgroundColor3,
                            onChange = function(newValue)
                                Line.BackgroundColor3 = newValue
                            end
                        }
                    }
                }
            )

            return element
        end
    },
    {
        Class = "TextBox",
        onCreate = function(self, elementSettings)
            local TextBox = Instance.new("Frame")
            local Label = Instance.new("TextLabel")
            local UIListLayout = Instance.new("UIListLayout")
            local TextBox_2 = Instance.new("Frame")
            local TextBox_3 = Instance.new("TextBox")
            local Placeholder = Instance.new("TextLabel")
            local Line = Instance.new("Frame")
            local Highlight = Instance.new("Frame")


            TextBox.Name = "TextBox"
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.BorderColor3 = Color3.fromRGB(27, 42, 53)
            TextBox.Size = UDim2.new(0, 200, 0, 54)
            TextBox.SizeConstraint = Enum.SizeConstraint.RelativeXX

            Label.Name = "Label"
            Label.Parent = TextBox
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.Position = UDim2.new(1, 10, 0, 0)
            Label.Size = UDim2.new(1, 0, 0, 18)
            Label.Font = Enum.Font.Roboto
            Label.Text = ""
            Label.Visible = false
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 18.000
            Label.TextWrapped = false
            Label.TextXAlignment = Enum.TextXAlignment.Left

            UIListLayout.Parent = TextBox
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 6)

            TextBox_2.Name = "TextBox"
            TextBox_2.Parent = TextBox
            TextBox_2.BackgroundColor3 = (_G.atOm.theme.textboxes.primaryColor or Color3.fromRGB(23, 23, 23))
            TextBox_2.BorderColor3 = (_G.atOm.theme.textboxes.secondaryColor or Color3.fromRGB(38, 38, 38))
            TextBox_2.BorderSizePixel = 0
            TextBox_2.Size = UDim2.new(0, 200, 0, 30)

            TextBox_3.Parent = TextBox_2
            TextBox_3.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox_3.BackgroundTransparency = 1.000
            TextBox_3.BorderSizePixel = 0
            TextBox_3.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox_3.Size = UDim2.new(1, -20, 1, -5)
            TextBox_3.ClearTextOnFocus = false
            TextBox_3.Font = Enum.Font.Roboto
            TextBox_3.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
            TextBox_3.Text = ""
            TextBox_3.TextColor3 = (_G.atOm.theme.textboxes.textColor or Color3.fromRGB(255, 255, 255))
            TextBox_3.TextSize = 11.000
            TextBox_3.TextWrapped = true
            TextBox_3.TextXAlignment = Enum.TextXAlignment.Left

            Placeholder.Name = "Placeholder"
            Placeholder.Parent = TextBox_3
            Placeholder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Placeholder.BackgroundTransparency = 1.000
            Placeholder.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Placeholder.Size = UDim2.new(1, 0, 1, 0)
            Placeholder.Font = Enum.Font.Roboto
            Placeholder.Text = ""
            Placeholder.TextColor3 = (_G.atOm.theme.textboxes.textColor or Color3.fromRGB(255, 255, 255))
            Placeholder.TextSize = 11.000
            Placeholder.TextTransparency = 0.380
            Placeholder.TextXAlignment = Enum.TextXAlignment.Left

            Line.Name = "Line"
            Line.Parent = TextBox_2
            Line.AnchorPoint = Vector2.new(0.5, 1)
            Line.BackgroundColor3 = (_G.atOm.theme.textboxes.secondaryColor or Color3.fromRGB(38, 38, 38))
            Line.BorderSizePixel = 0
            Line.Position = UDim2.new(0.5, 0, 1, 0)
            Line.Size = UDim2.new(1, 0, 0, 2)

            Highlight.Name = "Highlight"
            Highlight.Parent = TextBox_2
            Highlight.AnchorPoint = Vector2.new(0.5, 1)
            Highlight.BackgroundColor3 = (_G.atOm.theme.textboxes.focusColor or Color3.fromRGB(255, 193, 37))
            Highlight.BorderSizePixel = 0
            Highlight.Position = UDim2.new(0.5, 0, 1, 0)
            Highlight.Size = UDim2.new(0, 0, 0, 2)

            local Destroyed = false
            local stopLoop = false

            local onChanges = function()
            end

            local element
            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        TextBox:Destroy()
                        Destroyed = true
                    end,
                    userSettings = {
                        {
                            Property = "Parent",
                            Value = TextBox.Parent,
                            onChange = function(newValue)
                                TextBox.Parent = newValue
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = TextBox_2.BackgroundColor3,
                            onChange = function(newValue)
                                TextBox_2.BackgroundColor3 = newValue
                            end
                        },
                        {
                            Property = "secondaryColor",
                            Value = TextBox_2.BorderColor3,
                            onChange = function(newValue)
                                TextBox_2.BorderColor3 = newValue
                            end
                        },
                        {
                            Property = "focusColor",
                            Occuring = true,
                            Value = Highlight.BackgroundColor3,
                            onChange = function(newValue)
                                Highlight.BackgroundColor3 = newValue
                            end
                        },
                        {
                            Property = "Text",
                            Occuring = true,
                            Value = TextBox_3.Text,
                            onChange = function(newValue)
                                TextBox_3.Text = newValue
                            end
                        },
                        {
                            Property = "textColor",
                            Value = TextBox_3.TextColor3,
                            onChange = function(newValue)
                                TextBox_3.TextColor3 = newValue
                                Placeholder.TextColor3 = newValue
                            end
                        },
                        {
                            Property = "placeholder",
                            Value = Placeholder.Text,
                            Occuring = true,
                            onChange = function(newValue)
                                if newValue ~= "" then
                                    Placeholder.Visible = true
                                    Placeholder.Text = newValue
                                else
                                    Placeholder.Visible = false
                                end
                            end
                        },
                        {
                            Property = "onChange",
                            Value = function()
                            end,
                            Type = "Function",
                            onChange = function(newValue)
                                onChanges = newValue
                            end
                        },
                        {
                            Property = "label",
                            Value = Label.Text,
                            Occuring = true,
                            onChange = function(newValue)
                                if newValue ~= "" then
                                    Label.Visible = true
                                    Label.Text = newValue
                                else
                                    Label.Visible = false
                                end

                            end
                        }
                    }
                }
            )

            local isInputed = false
	        local Tween

            TextBox_3.Focused:Connect(function()
                if isInputed == false then
                    Tween =
                        TweenService:Create(
                            Highlight,
                            TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0),
                            {
                                Size = UDim2.new(1, 0, 0, 2)
                            }
                        )
                    Tween:Play()
                end
                TextBox_2.BackgroundColor3 = element.secondaryColor
            end)
            TextBox_3.FocusLost:Connect(function()
                onChanges(TextBox_3.Text)
                if isInputed == false then
                    Tween =
                        TweenService:Create(
                            Highlight,
                            TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0),
                            {
                                Size = UDim2.new(0, 0, 0, 2)
                            }
                        )
                    Tween:Play()
                end
                TextBox_2.BackgroundColor3 = element.primaryColor
            end)
            TextBox_3.Changed:Connect(function(Property)
                if Property == "Text" then
                    if TextBox_3.Text ~= "" then
                        isInputed = true
                        Placeholder.Visible = false
                    else
                        isInputed = false
                        Placeholder.Visible = true
                    end
                end
            end)

            UIListLayout.Changed:Connect(
                function()
                    TextBox.Size =
                        UDim2.new(0, UIListLayout.AbsoluteContentSize.X, 0, UIListLayout.AbsoluteContentSize.Y)
                end
            )

            return element
        end
    },
    {
        Class = "Switch",
        onCreate = function(self, elementSettings)
            local Switch = Instance.new("Frame")
            local Label = Instance.new("TextLabel")
            local UIListLayout = Instance.new("UIListLayout")
            local Switch_2 = Instance.new("TextButton")
            local Ball = Instance.new("Frame")

            Switch.Name = "Switch"
            Switch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Switch.BackgroundTransparency = 1.000
            Switch.Size = UDim2.new(0, 55, 0, 49)

            Label.Name = "Label"
            Label.Parent = Switch
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.Position = UDim2.new(1, 10, 0, 0)
            Label.Size = UDim2.new(1, 0, 0, 18)
            Label.Font = Enum.Font.Roboto
            Label.Text = ""
            Label.TextColor3 = (_G.atOm.theme.switches.textColor or Color3.fromRGB(255, 255, 255))
            Label.TextSize = 18.000
            Label.TextXAlignment = Enum.TextXAlignment.Left

            UIListLayout.Parent = Switch
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 6)

            Switch_2.Name = "Switch"
            Switch_2.Parent = Switch
            Switch_2.BackgroundColor3 = (_G.atOm.theme.switches.primaryColor or Color3.fromRGB(38, 38, 38))
            Switch_2.Size = UDim2.new(0, 55, 0, 25)
            Switch_2.AutoButtonColor = false
            Switch_2.Font = Enum.Font.SourceSans
            Switch_2.TextColor3 = Color3.fromRGB(0, 0, 0)
            Switch_2.TextSize = 14.000
            Switch_2.TextTransparency = 1.000

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 15)
            UICorner.Parent = Switch_2

            Ball.Name = "Ball"
            Ball.Parent = Switch_2
            Ball.AnchorPoint = Vector2.new(0, 0.5)
            Ball.BackgroundColor3 = (_G.atOm.theme.switches.ballPrimaryColor or Color3.fromRGB(255, 255, 255))
            Ball.Position = UDim2.new(0, 4, 0.5, 0)
            Ball.Size = UDim2.new(0, 21, 1, -4)

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 15)
            UICorner_2.Parent = Ball

            local Destroyed = false
            local stopLoop = false

            local onChanges = function()
            end

            local refreshSwitch
            local element
            local Padding = 4

            local Tween
            local Tween2

            local refreshSwitch = function()
                if element.Value == true then
                    Tween =
                        TweenService:Create(
                        Ball,
                        TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            Position = UDim2.new(1, -(Ball.Size.X.Offset + Padding), 0.5, 0),
                            BackgroundColor3 = element.ballSecondaryColor
                        }
                    )
                    Tween2 =
                        TweenService:Create(
                        Switch_2,
                        TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
                        {BackgroundColor3 = element.secondaryColor}
                    )
                    Tween:Play()
                    Tween2:Play()
                else
                    Tween =
                        TweenService:Create(
                        Ball,
                        TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
                        {
                            Position = UDim2.new(0, Padding, 0.5, 0),
                            BackgroundColor3 = element.ballPrimaryColor
                        }
                    )
                    Tween2 =
                        TweenService:Create(
                        Switch_2,
                        TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
                        {BackgroundColor3 = element.primaryColor}
                    )
                    Tween:Play()
                    Tween2:Play()
                end
            end

            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Switch:Destroy()
                        Destroyed = true
                    end,
                    userSettings = {
                        {
                            Property = "Parent",
                            Value = Switch.Parent,
                            onChange = function(newValue)
                                Switch.Parent = newValue
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = Switch_2.BackgroundColor3,
                            onChange = function(newValue)
                                if element.Value == false then
                                    Switch_2.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "secondaryColor",
                            Value = (_G.atOm.theme.switches.secondaryColor or Color3.fromRGB(255, 193, 37)),
                            onChange = function(newValue)
                                if element.Value == true then
                                    Switch_2.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "ballPrimaryColor",
                            Value = Ball.BackgroundColor3,
                            onChange = function(newValue)
                                if element.Value == false then
                                    Ball.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "ballSecondaryColor",
                            Value = (_G.atOm.theme.switches.ballSecondaryColor or Color3.fromRGB(38, 38, 38)),
                            onChange = function(newValue)
                                if element.Value == true then
                                    Ball.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "textColor",
                            Occuring = true,
                            Value = Label.TextColor3,
                            onChange = function(newValue)
                                Label.TextColor3 = newValue
                            end
                        },
                        {
                            Property = "Value",
                            Occuring = true,
                            Value = false,
                            onChange = function(newValue)
                                refreshSwitch()
                            end
                        },
                        {
                            Property = "onChange",
                            Value = function()
                            end,
                            Type = "Function",
                            onChange = function(newValue)
                                onChanges = newValue
                            end
                        },
                        {
                            Property = "label",
                            Value = Label.Text,
                            Occuring = true,
                            onChange = function(newValue)
                                if newValue ~= "" then
                                    Label.Visible = true
                                    Label.Text = newValue
                                else
                                    Label.Visible = false
                                end
                            end
                        }
                    }
                }
            )

            Switch_2.MouseButton1Click:Connect(
                function()
                    element.Value = not element.Value
                    onChanges(element.Value)
                    refreshSwitch()
                end
            )

            return element
        end
    },
    {
        Class = "Checkbox",
        onCreate = function(self, elementSettings)
            local Checkbox = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")
            local Trigger = Instance.new("TextButton")
            local Border = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Background = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local Check = Instance.new("Frame")
            local ImageLabel = Instance.new("ImageLabel")
            local Label = Instance.new("TextLabel")


            Checkbox.Name = "Checkbox"
            Checkbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Checkbox.BackgroundTransparency = 1.000
            Checkbox.Size = UDim2.new(0, 95, 0, 20)

            UIListLayout.Parent = Checkbox
            UIListLayout.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            UIListLayout.Padding = UDim.new(0, 20)

            Trigger.Name = "Trigger"
            Trigger.Parent = Checkbox
            Trigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Trigger.BackgroundTransparency = 1.000
            Trigger.Size = UDim2.new(0, 20, 0, 20)
            Trigger.Font = Enum.Font.SourceSans
            Trigger.Text = ""
            Trigger.TextColor3 = Color3.fromRGB(0, 0, 0)
            Trigger.TextSize = 14.000

            Border.Name = "Border"
            Border.Parent = Trigger
            Border.AnchorPoint = Vector2.new(0.5, 0.5)
            Border.BackgroundColor3 = (_G.atOm.theme.secondaryColor or Color3.fromRGB(38, 38, 38))
            Border.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Border.Position = UDim2.new(0.5, 0, 0.5, 0)
            Border.Size = UDim2.new(1, 0, 1, 0)

            UICorner.CornerRadius = UDim.new(0, 1)
            UICorner.Parent = Border

            Background.Name = "Background"
            Background.Parent = Trigger
            Background.AnchorPoint = Vector2.new(0.5, 0.5)
            Background.BackgroundColor3 = (_G.atOm.theme.primaryColor or Color3.fromRGB(23, 23, 23))
            Background.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Background.Position = UDim2.new(0.5, 0, 0.5, 0)
            Background.Size = UDim2.new(1, -4, 1, -4)

            UICorner_2.CornerRadius = UDim.new(0, 1)
            UICorner_2.Parent = Background

            Check.Name = "Check"
            Check.Parent = Background
            Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Check.BackgroundTransparency = 1.000
            Check.BorderSizePixel = 0
            Check.ClipsDescendants = true
            Check.Size = UDim2.new(0, 0, 1, 0)

            ImageLabel.Parent = Check
            ImageLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            ImageLabel.BackgroundTransparency = 1.000
            ImageLabel.BorderSizePixel = 0
            ImageLabel.Size = UDim2.new(0, 16, 0, 16)
            ImageLabel.Image = "http://www.roblox.com/asset/?id=7039766584"
            ImageLabel.ImageColor3 = (_G.atOm.theme.primaryColor or Color3.fromRGB(23, 23, 23))

            Label.Name = "Label"
            Label.Parent = Checkbox
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.Position = UDim2.new(1, 10, 0, 0)
            Label.Size = UDim2.new(1, 0, 0, 20)
            Label.Font = Enum.Font.Roboto
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 18.000
            Label.TextWrapped = false
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local Destroyed = false
            local stopLoop = false
            local Tween

            local onChanges = function()
            end

            local element

            local refreshCheckbox = function()
                if element.Value == true then
                    Tween = TweenService:Create(Check, TweenInfo.new(
                        0.25,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                        ), {Size = UDim2.new(1, 0,1, 0)})
                    Background.BackgroundColor3 = element.focusColor
                    Border.BackgroundColor3 = element.focusColor
                else
                    Tween = TweenService:Create(Check, TweenInfo.new(
                        0,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                        ), {Size = UDim2.new(0, 0,1, 0)})
                    Background.BackgroundColor3 = element.primaryColor
                    Border.BackgroundColor3 = element.secondaryColor
                end
                Tween:Play()
            end

            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Checkbox:Destroy()
                        Destroyed = true
                    end,
                    userSettings = {
                        {
                            Property = "Parent",
                            Value = Checkbox.Parent,
                            onChange = function(newValue)
                                Checkbox.Parent = newValue
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = Background.BackgroundColor3,
                            onChange = function(newValue)
                                if element.Value == false then
                                    Background.BackgroundColor3 = newValue
                                end
                                ImageLabel.ImageColor3 = newValue
                            end
                        },
                        {
                            Property = "secondaryColor",
                            Value = Border.BackgroundColor3,
                            onChange = function(newValue)
                                if element.Value == false then
                                    Border.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "focusColor",
                            Value = (_G.atOm.theme.switches.focusColor or Color3.fromRGB(255, 193, 37)),
                            onChange = function(newValue)
                                if element.Value == true then
                                    Background.BackgroundColor3 = newValue
                                    Border.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "Value",
                            Occuring = true,
                            Value = false,
                            onChange = function(newValue)
                                Selected = newValue
                                refreshCheckbox()
                            end
                        },
                        {
                            Property = "onChange",
                            Value = function()
                            end,
                            Type = "Function",
                            onChange = function(newValue)
                                onChanges = newValue
                            end
                        },
                        {
                            Property = "label",
                            Value = Label.Text,
                            Occuring = true,
                            onChange = function(newValue)
                                if newValue ~= "" then
                                    Label.Visible = true
                                    Label.Text = newValue
                                else
                                    Label.Visible = false
                                end
                                Label.Size = UDim2.new(0, Label.TextBounds.X, 0, 20)
                            end
                        }
                    }
                }
            )

            Trigger.MouseButton1Click:Connect(
                function()
                    element.Value = not element.Value
                    onChanges(element.Value)
                    refreshCheckbox()
                end
            )

            UIListLayout.Changed:Connect(function()
                Checkbox.Size = UDim2.new(0, UIListLayout.AbsoluteContentSize.X, 0, UIListLayout.AbsoluteContentSize.Y)
            end)

            return element
        end
    },
    {
        Class = "Slider",
        onCreate = function(self, elementSettings)
            local Slider_M = Instance.new("Frame")
            local Label = Instance.new("TextLabel")
            local UIListLayout = Instance.new("UIListLayout")
            Slider_M.Name = "Slider"
            Slider_M.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider_M.BackgroundTransparency = 1.000
            Slider_M.Size = UDim2.new(0, 200, 0, 25)

            Label.Name = "Label"
            Label.Parent = Slider_M
            Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Label.BackgroundTransparency = 1.000
            Label.Position = UDim2.new(1, 10, 0, 0)
            Label.Size = UDim2.new(1, 0, 0, 18)
            Label.Font = Enum.Font.Roboto
            Label.Text = ""
            Label.TextColor3 = (_G.atOm.theme.sliders.textColor or Color3.fromRGB(255, 255, 255))
            Label.TextSize = 18.000
            Label.TextXAlignment = Enum.TextXAlignment.Left

            UIListLayout.Parent = Slider_M
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local Slider = Instance.new("Frame")
            local Ball = Instance.new("TextButton")
            local Line = Instance.new("Frame")
            local Filled = Instance.new("Frame")

            Slider.Name = "Slider"
            Slider.Parent = Slider_M
            Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider.BackgroundTransparency = 1.000
            Slider.Size = UDim2.new(0, 200, 0, 25)

            Ball.Name = "Ball"
            Ball.Parent = Slider
            Ball.AnchorPoint = Vector2.new(0.5, 0.5)
            Ball.BackgroundColor3 = (_G.atOm.theme.sliders.primaryColor or Color3.fromRGB(38, 38, 38))
            Ball.Position = UDim2.new(0, 0, 0.5, 0)
            Ball.Size = UDim2.new(0, 15, 0, 15)
            Ball.ZIndex = 2
            Ball.AutoButtonColor = false
            Ball.Font = Enum.Font.SourceSans
            Ball.Text = ""
            Ball.TextColor3 = Color3.fromRGB(0, 0, 0)
            Ball.TextSize = 14.000
            Ball.TextTransparency = 1.000

            Line.Name = "Line"
            Line.Parent = Slider
            Line.AnchorPoint = Vector2.new(0, 0.5)
            Line.BackgroundColor3 = (_G.atOm.theme.sliders.primaryColor or Color3.fromRGB(38, 38, 38))
            Line.BorderSizePixel = 0
            Line.Position = UDim2.new(0, 0, 0.5, 0)
            Line.Size = UDim2.new(1, 0, 0, 5)

            Filled.Name = "Filled"
            Filled.Parent = Line
            Filled.BackgroundColor3 = (_G.atOm.theme.sliders.secondaryColor or Color3.fromRGB(255, 193, 37))
            Filled.BorderSizePixel = 0
            Filled.Size = UDim2.new(0, 0, 1, 0)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Line

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(1, 0)
            UICorner_2.Parent = Ball

            local Destroyed = false
            local stopLoop = false

            local onChanges = function()
            end
            local isDragging = false

            local element
            local refreshBar = function()
                local x = (element.Value * (Slider.AbsoluteSize.X / element.Max))
                Ball.Position = UDim2.new(0, x, 0.5, 0)
                Filled.Size = UDim2.new(0, x, 1, 0)
            end

            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Slider_M:Destroy()
                        Destroyed = true
                    end,
                    userSettings = {
                        {
                            Property = "Parent",
                            Value = Slider_M.Parent,
                            onChange = function(newValue)
                                Slider_M.Parent = newValue
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = Ball.BackgroundColor3,
                            onChange = function(newValue)
                                Line.BackgroundColor3 = newValue
                                if isDragging == false then
                                    Ball.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "secondaryColor",
                            Value = Filled.BackgroundColor3,
                            onChange = function(newValue)
                                Filled.BackgroundColor3 = newValue
                                if isDragging == true then
                                    Switch_2.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "textColor",
                            Occuring = true,
                            Value = Label.TextColor3,
                            onChange = function(newValue)
                                Label.TextColor3 = newValue
                            end
                        },
                        {
                            Property = "Value",
                            Occuring = true,
                            Value = 1,
                            onChange = function(newValue)
                                onChanges(newValue)
                                refreshBar()
                            end
                        },
                        {
                            Property = "Max",
                            Occuring = true,
                            Value = 100,
                            onChange = function(newValue)
                                if element.Value > newValue then
                                    element.Value = newValue
                                end
                            end
                        },
                        {
                            Property = "Min",
                            Occuring = true,
                            Value = 0,
                            onChange = function(newValue)
                                if element.Value < newValue then
                                    element.Value = newValue
                                end
                            end
                        },
                        {
                            Property = "onChange",
                            Value = function()
                            end,
                            Type = "Function",
                            onChange = function(newValue)
                                onChanges = newValue
                            end
                        },
                        {
                            Property = "label",
                            Value = Label.Text,
                            Occuring = true,
                            onChange = function(newValue)
                                if newValue ~= "" then
                                    Label.Visible = true
                                    Label.Text = newValue
                                else
                                    Label.Visible = false
                                end
                            end
                        }
                    }
                }
            )

            UIListLayout.Changed:Connect(
                function()
                    Slider_M.Size =
                        UDim2.new(0, UIListLayout.AbsoluteContentSize.X, 0, UIListLayout.AbsoluteContentSize.Y)
                end
            )

            Ball.MouseButton1Down:Connect(
                function()
                    isDragging = true
                    Ball.BackgroundColor3 = element.secondaryColor
                    Ball.Size = UDim2.new(0, 20, 0, 20)
                end
            )

            UserInputService.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDragging = false
                        Ball.Size = UDim2.new(0, 15, 0, 15)
                        Ball.BackgroundColor3 = element.primaryColor
                    end
                end
            )

            UserInputService.InputChanged:Connect(
                function(input, gameProcessed)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if isDragging then
                            local x = (Mouse.X - Slider.AbsolutePosition.X)
                            if x > Slider.AbsoluteSize.X then
                                x = Slider.AbsoluteSize.X
                            end
                            if x < 0 then
                                x = 0
                            end
                            local newValue = ((x / Slider.AbsoluteSize.X) * element.Max)
                            element.Value = newValue
                            onChanges(newValue)
                            Ball.Position = UDim2.new(0, x, 0.5, 0)
                            Filled.Size = UDim2.new(0, x, 1, 0)
                        end
                    end
                end
            )

            refreshBar()

            return element
        end
    },
    {
        Class = "Button",
        onCreate = function(self, elementSettings)
            local Button = Instance.new("Frame")
            local TextButton = Instance.new("TextButton")

            Button.Name = "Button"
            Button.BackgroundColor3 = (_G.atOm.theme.buttons.primaryColor or Color3.fromRGB(255, 193, 37))
            Button.Size = UDim2.new(0, 10, 0, 25)

            TextButton.Parent = Button
            TextButton.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            TextButton.BackgroundTransparency = 1.000
            TextButton.Size = UDim2.new(1, 0, 1, 0)
            TextButton.Font = Enum.Font.Roboto
            TextButton.Text = ""
            TextButton.TextColor3 = (_G.atOm.theme.buttons.textColor or Color3.fromRGB(0, 0, 0))
            TextButton.TextSize = 16.000

            local Destroyed = false
            local stopLoop = false

            local element
            local refreshBar = function()
                local x = (element.Value * (Slider.AbsoluteSize.X / element.Max))
                Ball.Position = UDim2.new(0, x, 0.5, 0)
                Filled.Size = UDim2.new(0, x, 1, 0)
            end

            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Slider_M:Destroy()
                        Destroyed = true
                    end,
                    userSettings = {
                        {
                            Property = "Parent",
                            Value = Button.Parent,
                            onChange = function(newValue)
                                Button.Parent = newValue
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = Button.BackgroundColor3,
                            onChange = function(newValue)
                                Line.BackgroundColor3 = newValue
                                if isDragging == false then
                                    Ball.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "textColor",
                            Occuring = true,
                            Value = TextButton.TextColor3,
                            onChange = function(newValue)
                                TextButton.TextColor3 = newValue
                            end
                        },
                        {
                            Property = "Text",
                            Occuring = true,
                            Value = TextButton.Text,
                            onChange = function(newValue)
                                TextButton.Text = newValue
                            end
                        },
                        {
                            Property = "onClick",
                            Occuring = true,
                            Value = function()
                            end,
                            onChange = function(newValue)
                                TextButton.MouseButton1Click:Connect(newValue)
                            end
                        }
                    }
                }
            )

            local refreshButton = function()
                Button.Size = UDim2.new(0, (TextButton.TextBounds.X + 30), 0, 25)
            end
            TextButton.Changed:Connect(refreshButton)
            refreshButton()

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

            local ToolTip = Instance.new("TextLabel")
            local ToolCorner = Instance.new("UICorner")

            ToolTip.Name = "ToolTip"
            ToolTip.Parent = Back
            ToolTip.AnchorPoint = Vector2.new(0, 0.5)
            ToolTip.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
            ToolTip.Position = UDim2.new(1, 0, 0.5, 0)
            ToolTip.Size = UDim2.new(2, 0, 0.600000024, 0)
            ToolTip.Font = Enum.Font.RobotoCondensed
            ToolTip.Text = ""
            ToolTip.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToolTip.TextSize = 14.000
            ToolTip.Visible = false
            ToolTip.BackgroundTransparency = 1
            ToolTip.TextTransparency = 1

            ToolCorner.CornerRadius = UDim.new(0, 10)
            ToolCorner.Parent = ToolTip

            ToolTip.Changed:Connect(
                function()
                    ToolTip.Size = UDim2.new(0, (ToolTip.TextBounds.X + 40), 0, (ToolTip.TextBounds.Y + 10))
                end
            )

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
                            Value = function()
                            end,
                            Type = "Function",
                            onChange = function(newValue)
                                Back.MouseButton1Click:Connect(newValue)
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = (_G.atOm.theme.imageTileButtons.primaryColor or Back.ImageColor3),
                            onChange = function(newValue)
                                Back.ImageColor3 = newValue
                            end
                        },
                        {
                            Property = "imageColor",
                            Value = (_G.atOm.theme.imageTileButtons.imageColor or Image.ImageColor3),
                            Occuring = true,
                            onChange = function(newValue)
                                Image.ImageColor3 = newValue
                            end
                        },
                        {
                            Property = "hoverSize",
                            Value = true,
                            Occuring = true
                        },
                        {
                            Property = "onHoverImageColor",
                            Occuring = true,
                            Value = false
                        },
                        {
                            Property = "hoverImageColor",
                            Occuring = true,
                            Value = (_G.atOm.theme.imageTileButtons.hoverImageColor or Color3.new(200, 200, 200))
                        },
                        {
                            Property = "toolTip",
                            Value = false,
                            Occuring = true,
                            onChange = function(newValue)
                                if newValue == true then
                                    ToolTip.Visible = true
                                else
                                    ToolTip.Visible = false
                                end
                            end
                        },
                        {
                            Property = "toolTipText",
                            Value = ToolTip.Text,
                            Occuring = true,
                            onChange = function(newValue)
                                ToolTip.Text = newValue
                            end
                        }
                    }
                }
            )

            local Tween

            local Tween2

            local isHovering = false

            local onHover = function()
                if element.toolTip then
                    Tween =
                        TweenService:Create(
                        ToolTip,
                        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
                        {BackgroundTransparency = 0, TextTransparency = 0}
                    )
                    Tween:Play()
                end
                if element.hoverSize then
                    Tween2 =
                        Back:TweenSize(
                        UDim2.new(0, (element.Size.X.Offset * 1.1), 0, (element.Size.Y.Offset * 1.1)),
                        Enum.EasingDirection.In,
                        Enum.EasingStyle.Sine,
                        0.125,
                        true
                    )
                    Tween2:Play()
                end
                if element.onHoverImageColor then
                    Image.ImageColor3 = element.hoverImageColor
                end
            end

            local onLeave = function()
                if element.toolTip then
                    Tween =
                        TweenService:Create(
                        ToolTip,
                        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
                        {BackgroundTransparency = 1, TextTransparency = 1}
                    )
                    Tween:Play()
                end
                if element.hoverSize then
                    Tween2 = Back:TweenSize(element.Size, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.125, true)
                    Tween2:Play()
                end
                if element.onHoverImageColor then
                    Image.ImageColor3 = element.imageColor
                end
            end

            MouseLibrary.bindMouseEvents(Back, onHover, onLeave)

            return element
        end
    },
    {
        Class = "Dropdown",
        onCreate = function(self, elementSettings)

            local Main = Instance.new("Frame")
            local Dropdown = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local Border = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local Background = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")
            local Button = Instance.new("TextButton")
            local ImageLabel = Instance.new("ImageLabel")
            local PlaceHolder = Instance.new("TextLabel")
            local List = Instance.new("Frame")
            local UICorner_4 = Instance.new("UICorner")
            local Content = Instance.new("Frame")
            local Content_2 = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")
            local ScrollBarX = Instance.new("Frame")
            local Bar = Instance.new("TextButton")
            local ScrollBarY = Instance.new("Frame")
            local Bar_2 = Instance.new("TextButton")
            local SearchBar = Instance.new("TextBox")
            local Line = Instance.new("Frame")
            local Selected = Instance.new("TextLabel")

            Main.Name = "Dropdown"
            Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Main.BackgroundTransparency = 1.000
            Main.BorderSizePixel = 0
            Main.Size = UDim2.new(0, 125, 0, 37)

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Main
            Dropdown.AnchorPoint = Vector2.new(0, 0.5)
            Dropdown.Position = UDim2.new(0, 0, 0.5, 0)
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1.000
            Dropdown.BorderSizePixel = 0
            Dropdown.Size = UDim2.new(0, 125, 0, 37)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Dropdown

            Border.Name = "Border"
            Border.Parent = Dropdown
            Border.AnchorPoint = Vector2.new(0.5, 0)
            Border.BackgroundColor3 = Color3.fromRGB(255, 193, 37)
            Border.BorderSizePixel = 0
            Border.Position = UDim2.new(0.5, 0, 0, -1)
            Border.Size = UDim2.new(1, 2, 1, 125)

            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = Border

            Background.Name = "Background"
            Background.Parent = Dropdown
            Background.AnchorPoint = Vector2.new(0.5, 0)
            Background.BackgroundColor3 = (_G.atOm.theme.dropdowns.secondaryColor or Color3.fromRGB(23, 23, 23))
            Background.BorderSizePixel = 0
            Background.Position = UDim2.new(0.5, 0, 0, 0)
            Background.Size = UDim2.new(1, 0, 1, 123)

            UICorner_3.CornerRadius = UDim.new(0, 4)
            UICorner_3.Parent = Background

            Button.Name = "Button"
            Button.Parent = Dropdown
            Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Button.BackgroundTransparency = 1.000
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000
            Button.TextTransparency = 1.000

            ImageLabel.Parent = Button
            ImageLabel.AnchorPoint = Vector2.new(1, 0.5)
            ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ImageLabel.BackgroundTransparency = 1.000
            ImageLabel.Position = UDim2.new(1, -5, 0.5, 0)
            ImageLabel.Size = UDim2.new(0, 25, 0, 25)
            ImageLabel.Image = "http://www.roblox.com/asset/?id=4978038300"

            PlaceHolder.Name = "Place Holder"
            PlaceHolder.Parent = Dropdown
            PlaceHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            PlaceHolder.BackgroundTransparency = 1.000
            PlaceHolder.BorderSizePixel = 0
            PlaceHolder.Position = UDim2.new(0, 15, 0, 0)
            PlaceHolder.Size = UDim2.new(1, -15, 1, 0)
            PlaceHolder.Font = Enum.Font.Roboto
            PlaceHolder.RichText = true
            PlaceHolder.Text = "<b></b>"
            PlaceHolder.TextColor3 = (_G.atOm.theme.dropdowns.textColor or Color3.fromRGB(255, 255, 255))
            PlaceHolder.TextSize = 12.000
            PlaceHolder.TextXAlignment = Enum.TextXAlignment.Left

            List.Name = "List"
            List.Parent = Dropdown
            List.BackgroundColor3 = (_G.atOm.theme.dropdowns.secondaryColor or Color3.fromRGB(23, 23, 23))
            List.BackgroundTransparency = 1.000
            List.BorderSizePixel = 0
            List.Position = UDim2.new(0, 0, 1, 0)
            List.Size = UDim2.new(1, 0, 0, 155)

            UICorner_4.CornerRadius = UDim.new(0, 4)
            UICorner_4.Parent = List

            Content.Name = "Content"
            Content.Parent = List
            Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Content.BackgroundTransparency = 1.000
            Content.BorderSizePixel = 0
            Content.Position = UDim2.new(0, 0, 0, 30)
            Content.Size = UDim2.new(1, 0, 1, -30)

            Content_2.Name = "Content"
            Content_2.Parent = Content
            Content_2.Active = true
            Content_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Content_2.BackgroundTransparency = 1.000
            Content_2.Size = UDim2.new(1, 0, 1, 0)
            Content_2.CanvasSize = UDim2.new(0, 0, 0, 0)
            Content_2.ScrollBarThickness = 8
            Content_2.ScrollBarImageTransparency = 1

            UIListLayout.Parent = Content_2
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            ScrollBarX.Name = "ScrollBarX"
            ScrollBarX.Parent = Content
            ScrollBarX.AnchorPoint = Vector2.new(0, 1)
            ScrollBarX.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            ScrollBarX.BorderSizePixel = 0
            ScrollBarX.Position = UDim2.new(0, 0, 1, 0)
            ScrollBarX.Size = UDim2.new(1, 0, 0, 8)
            ScrollBarX.Visible = false

            Bar.Name = "Bar"
            Bar.Parent = ScrollBarX
            Bar.AnchorPoint = Vector2.new(0, 0.5)
            Bar.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
            Bar.BorderSizePixel = 0
            Bar.Position = UDim2.new(0, 0, 0.5, 0)
            Bar.Size = UDim2.new(0, 100, 0, 10)
            Bar.AutoButtonColor = false
            Bar.Font = Enum.Font.SourceSans
            Bar.Text = "0"
            Bar.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bar.TextSize = 14.000
            Bar.TextTransparency = 1.000

            ScrollBarY.Name = "ScrollBarY"
            ScrollBarY.Parent = Content
            ScrollBarY.AnchorPoint = Vector2.new(1, 0)
            ScrollBarY.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            ScrollBarY.BorderSizePixel = 0
            ScrollBarY.Position = UDim2.new(1, 0, 0, 0)
            ScrollBarY.Size = UDim2.new(0, 8, 1, 0)
            ScrollBarY.Visible = false

            Bar_2.Name = "Bar"
            Bar_2.Parent = ScrollBarY
            Bar_2.AnchorPoint = Vector2.new(0.5, 0)
            Bar_2.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
            Bar_2.BorderSizePixel = 0
            Bar_2.Position = UDim2.new(0.5, 0, 0, 0)
            Bar_2.Size = UDim2.new(0, 10, 0, 100)
            Bar_2.AutoButtonColor = false
            Bar_2.Font = Enum.Font.SourceSans
            Bar_2.Text = "0"
            Bar_2.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bar_2.TextSize = 14.000
            Bar_2.TextTransparency = 1.000

            SearchBar.Name = "Search Bar"
            SearchBar.Parent = List
            SearchBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SearchBar.BackgroundTransparency = 1.000
            SearchBar.BorderSizePixel = 0
            SearchBar.Size = UDim2.new(1, 0, 0, 31)
            SearchBar.Font = Enum.Font.SourceSans
            SearchBar.PlaceholderText = "Search..."
            SearchBar.Text = ""
            SearchBar.TextColor3 = (_G.atOm.theme.dropdowns.textColor or Color3.fromRGB(255, 255, 255))
            SearchBar.TextSize = 14.000
            SearchBar.TextWrapped = true

            Line.Name = "Line"
            Line.Parent = SearchBar
            Line.BackgroundColor3 = (_G.atOm.theme.dropdowns.primaryColor or Color3.fromRGB(38, 38, 38))
            Line.BorderSizePixel = 0
            Line.Size = UDim2.new(1, 0, 0, 1)

            Selected.Name = "Selected"
            Selected.Parent = Dropdown
            Selected.BackgroundTransparency = 1.000
            Selected.BorderSizePixel = 0
            Selected.Position = UDim2.new(0, 15, 0, 0)
            Selected.Size = UDim2.new(1, -15, 1, 0)
            Selected.Visible = false
            Selected.Font = Enum.Font.Roboto
            Selected.Text = "<b></b>"
            Selected.RichText = true
            Selected.TextColor3 = (_G.atOm.theme.dropdowns.focusColor or Color3.fromRGB(255, 193, 37))
            Selected.TextSize = 12.000
            Selected.TextWrapped = true
            Selected.TextXAlignment = Enum.TextXAlignment.Left

            local Destroyed = false

            local isDraggingY = false
            local isDraggingX = false
            local LastMouseMove = Vector2.new(0, 0)
            local Thickness = 8
            local lastPosition = Vector2.new(0, 0)
            local isFocused = false
            local searchEnabled = false
            local selected = nil
            local maxYSize = 155

            local onChanges = function(newValue)

            end
            local refreshDropdown = function()

            end
            local refreshList = function()

            end
            local refreshScrollBars = function()

            end


            local element
            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Main:Destroy()
                        Destroyed = true
                    end,
                    userSettings = {
                        {
                            Property = "Parent",
                            Value = Main.Parent,
                            onChange = function(newValue)
                                Main.Parent = newValue
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = (_G.atOm.theme.dropdowns.primaryColor or Color3.fromRGB(38, 38, 38)),
                            onChange = function(newValue)
                                Line.BackgroundColor3 = newValue
                                for i,v in pairs(Dropdown:GetDescendants()) do
                                    if v.Name == "Line" then
                                        v.BackgroundColor3 = newValue
                                    end
                                end
                            end
                        },
                        {
                            Property = "secondaryColor",
                            Value = Background.BackgroundColor3,
                            onChange = function(newValue)
                                Background.BackgroundColor3 = newValue
                                List.BackgroundColor3 = newValue
                            end
                        },
                        {
                            Property = "focusColor",
                            Value = Selected.TextColor3,
                            onChange = function(newValue)
                                Selected.TextColor3 = newValue
                                for i,v in pairs(Content_2:GetChildren()) do
                                    if v.TextLabel then
                                        v.BackgroundColor3 = newValue
                                    end
                                end
                            end
                        },
                        {
                            Property = "textColor",
                            Value = PlaceHolder.TextColor3,
                            onChange = function(newValue)
                                PlaceHolder.TextColor3 = newValue
                                SearchBar.TextColor3 = newValue
                                for i,v in pairs(Content_2:GetChildren()) do
                                    if v.TextLabel then
                                        v.TextLabel.TextColor3 = newValue
                                    end
                                end
                            end
                        },
                        {
                            Property = "hoverTextColor",
                            Value = (_G.atOm.theme.dropdowns.hoverTextColor or Color3.fromRGB(0, 0, 0))
                        },
                        {
                            Property = "placeholder",
                            Value = "",
                            onChange = function(newValue)
                                PlaceHolder.Text = "<b>"..newValue.."</b>"
                            end
                        },
                        {
                            Property = "searchEnabled",
                            Value = false,
                            onChange = function(newValue)
                                searchEnabled = newValue
                                refreshList()
                            end
                        },
                        {
                            Property = "Value",
                            Value = "",
                            onChange = function(newValue)
                                onChanges(newValue)
                            end
                        },
                        {
                            Property = "onChange",
                            Value = onChanges,
                            onChange = function(newValue)
                                onChanges = newValue
                            end
                        },
                        {
                            Property = "Alignment",
                            Value = "Bottom",
                            Occuring = true,
                            onChange = function(newValue)
                                refreshDropdown()
                            end
                        },
                        {
                            Property = "items",
                            Value = {},
                            onChange = function(newValue)
                                selected = nil
                                for i,v in pairs(Content_2:GetChildren()) do
                                    if v:IsA("TextButton") then
                                        v:Destroy()
                                    end
                                end
                                for i,v in pairs(newValue) do

                                    local TextButton = Instance.new("TextButton")
                                    local TextLabel = Instance.new("TextLabel")
                                    local Line = Instance.new("Frame")

                                    TextButton.Parent = Content_2
                                    TextButton.BackgroundColor3 = element.focusColor
                                    TextButton.BackgroundTransparency = 1.000
                                    TextButton.BorderSizePixel = 0
                                    TextButton.Size = UDim2.new(1, 0, 0, 31)
                                    TextButton.AutoButtonColor = false
                                    TextButton.Font = Enum.Font.SourceSans
                                    TextButton.Text = ""
                                    TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                                    TextButton.TextSize = 14.000
                                    TextButton.TextTransparency = 1.000

                                    TextLabel.Parent = TextButton
                                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                    TextLabel.BackgroundTransparency = 1.000
                                    TextLabel.Position = UDim2.new(0, 15, 0, 0)
                                    TextLabel.Size = UDim2.new(1, -15, 1, -1)
                                    TextLabel.Font = Enum.Font.Roboto
                                    TextLabel.Text = v
                                    TextLabel.TextColor3 = element.textColor
                                    TextLabel.TextSize = 12.000
                                    TextLabel.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
                                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

                                    Line.Name = "Line"
                                    Line.Parent = TextButton
                                    Line.BackgroundColor3 = element.primaryColor
                                    Line.BorderSizePixel = 0
                                    if element.Alignment == "Top" then
                                        Line.Position = UDim2.new(0, 0, 1, -1)
                                    end
                                    Line.Size = UDim2.new(1, 0, 0, 1)
                                end
                                refreshDropdown()
                            end
                        }
                    }
                }
            )

            local resizeBorder = function(Size)
                if element.Alignment == "Top" then
                    Background.Size = UDim2.new(1, 0, 0, Size.Y)
                    Border.Size = UDim2.new(1, 2, 0, (Size.Y + 2))
                elseif element.Alignment == "Bottom" then
                    Background.Size = UDim2.new(1, 0, 0, Size.Y)
                    Border.Size = UDim2.new(1, 2, 0, (Size.Y + 2))
                end
                for i,v in pairs(Content_2:GetChildren()) do
                    if v:IsA("TextButton") and v:FindFirstChild("Line") then
                        if element.Alignment == "Top" then
                            v.Line.Position = UDim2.new(0, 0, 1, -1)
                        else
                            v.Line.Position = UDim2.new(0, 0, 0, 0)
                        end
                    end
                end
                if element.Alignment == "Top" then
                    Line.Position = UDim2.new(0, 0, 1, -1)
                else
                    Line.Position = UDim2.new(0, 0, 0, 0)
                end
            end
            
            local filterList = function(text)
                for i,v in pairs(Content_2:GetChildren()) do
                    if v:IsA("TextButton") then
                        local str = string.lower(v.TextLabel.Text)
                        if string.find(str, string.lower(text)) then
                            v.Visible = true
                        else
                            v.Visible = false
                        end
                    end
                end
            end
            
            SearchBar.Changed:Connect(function(Property)
                if Property == "Text" then
                    filterList(SearchBar.Text)
                    refreshList()
                end
            end)
            
            local refreshDropdown = function()
                if isFocused then
                    Selected.Visible = false
                    PlaceHolder.Visible = true
                    PlaceHolder.TextColor3 = element.focusColor
                    Border.Visible = true
                    Background.BackgroundColor3 = element.secondaryColor
                    ImageLabel.ImageColor3 = element.focusColor
                    ImageLabel.Image = "http://www.roblox.com/asset/?id=4978037290"
                    List.Visible = true
                    Dropdown.ZIndex = 2
                    for i,v in pairs(Dropdown:GetDescendants()) do
                        if v:IsA("GuiObject") then
                            v.ZIndex = 2
                        end
                    end
                    resizeBorder(Vector2.new(Dropdown.AbsoluteSize.X, (Dropdown.AbsoluteSize.Y + List.AbsoluteSize.Y)))
                else
                    if selected ~= nil then
                        Selected.Text = "<b>"..selected.TextLabel.Text.."</b>"
                        Selected.Visible = true
                        PlaceHolder.Visible = false
                        selected.BackgroundColor3 = element.focusColor
                        Dropdown.Size = UDim2.new(0, (Selected.TextBounds.X + 70), 0, 35)
                    else
                        Selected.Visible = false
                        PlaceHolder.Visible = true
                        Dropdown.Size = UDim2.new(0, (PlaceHolder.TextBounds.X + 70), 0, 35)
                    end
                    PlaceHolder.TextColor3 = element.textColor
                    Border.Visible = false
                    Background.BackgroundColor3 = element.primaryColor
                    ImageLabel.ImageColor3 = element.textColor
                    ImageLabel.Image = "http://www.roblox.com/asset/?id=4978038300"
                    List.Visible = false
                    Dropdown.ZIndex = 1
                    for i,v in pairs(Dropdown:GetDescendants()) do
                        if v:IsA("GuiObject") then
                            v.ZIndex = 1
                        end
                    end
                    resizeBorder(Vector2.new(Dropdown.AbsoluteSize.X, (Dropdown.AbsoluteSize.Y)))
                end
            end
            
            local refreshList = function()
                local Y = UIListLayout.AbsoluteContentSize.Y
                if element.Alignment == "Bottom" then
                    Background.AnchorPoint = Vector2.new(0.5, 0)
                    Background.Position = UDim2.new(0.5, 0, 0, 0)
                    Border.Position = UDim2.new(0.5, 0,0, -1)
                    Border.AnchorPoint = Vector2.new(0.5, 0)
                    List.AnchorPoint = Vector2.new(0, 0)
                    List.Position = UDim2.new(0, 0, 1, 0)
                elseif element.Alignment == "Top" then
                    Background.AnchorPoint = Vector2.new(0.5, 1)
                    Background.Position = UDim2.new(0.5, 0, 1, 0)
                    Border.Position = UDim2.new(0.5, 0, 1, 1)
                    Border.AnchorPoint = Vector2.new(0.5, 1)
                    List.AnchorPoint = Vector2.new(0, 1)
                    List.Position = UDim2.new(0, 0, 0, 0)
                end
                if searchEnabled then
                    SearchBar.Visible = true
                    if element.Alignment == "Bottom" then
                        Content.Position = UDim2.new(0, 0, 0, SearchBar.AbsoluteSize.Y)
                        Content.Size = UDim2.new(1, 0, 1, -(SearchBar.AbsoluteSize.Y))
                    elseif element.Alignment == "Top" then
                        Content.Position = UDim2.new(0, 0, 0, 0)
                        Content.Size = UDim2.new(1, 0, 1, -(SearchBar.AbsoluteSize.Y))
                        {0, 0},{0, -30}
                    end
                    refreshDropdown(alignment)
                    Y = Y + SearchBar.AbsoluteSize.Y
                else
                    SearchBar.Visible = false
                    Content.Position = UDim2.new(0, 0, 0, 0)
                    Content.Size = UDim2.new(1, 0, 1, 0)
                    refreshDropdown(alignment)
                end
                if Y > maxYSize then
                    Y = maxYSize
                end
                List.Size = UDim2.new(1, 0, 0, Y)
            end
            
            Button.MouseButton1Click:Connect(function()
                isFocused = not isFocused
                refreshDropdown()
            end)
            
            refreshDropdown()
            
            local animateButton = function(instance)
                MouseLibrary.bindMouseEvents(instance, function()
                    instance.BackgroundTransparency = 0
                    instance.TextLabel.TextColor3 = element.hoverTextColor
                end, function()
                    if instance ~= selected then
                        instance.BackgroundTransparency = 1
                        instance.TextLabel.TextColor3 = element.textColor
                    end
                end)
                instance.MouseButton1Click:Connect(function()
                    isFocused = false
                    selected = instance
                    element.Value = instance.TextLabel.Text
                    refreshDropdown()
                end)
                
            end
            
            local refreshScrollBars = function()
                Content_2.CanvasSize =
                    UDim2.new(0, (UIListLayout.AbsoluteContentSize.X), 0, UIListLayout.AbsoluteContentSize.Y)
            
                local canvas_scaleY =
                Content_2.CanvasPosition.Y / (Content_2.CanvasSize.Y.Offset - Content_2.AbsoluteWindowSize.Y)
                local Y = (1 - Bar_2.Size.Y.Scale) * canvas_scaleY
            
                local canvas_scaleX =
                Content_2.CanvasPosition.X / (Content_2.CanvasSize.X.Offset - Content_2.AbsoluteWindowSize.X)
                local X = (1 - Bar.Size.X.Scale) * canvas_scaleX
            
                local isXScroll = (UIListLayout.AbsoluteContentSize.X > Content_2.AbsoluteWindowSize.X)
                local isYScroll = (UIListLayout.AbsoluteContentSize.Y > Content_2.AbsoluteWindowSize.Y)
            
                if isXScroll and isYScroll then
                    ScrollBarY.Size = UDim2.new(0, Thickness, 1, -(Thickness))
                    ScrollBarX.Size = UDim2.new(1, -(Thickness), 0, Thickness)
                else
                    ScrollBarY.Size = UDim2.new(0, Thickness, 1, 0)
                    ScrollBarX.Size = UDim2.new(1, 0, 0, Thickness)
                end
                if isXScroll then
                    ScrollBarX.Visible = true
                    Bar.Size =
                        UDim2.new(
                            (Content_2.AbsoluteWindowSize.X / Content_2.CanvasSize.X.Offset),
                            0,
                            0,
                            (Thickness - 4)
                        )
                    Bar.Position = UDim2.new(X, 0, Bar.Position.Y.Scale, 0)
                else
                    Bar.Size = UDim2.new(0, 0, 0, (Thickness - 4))
                    ScrollBarX.Visible = false
                end
                if isYScroll then
                    ScrollBarY.Visible = true
                    Bar_2.Size =
                        UDim2.new(
                            0,
                            (Thickness - 4),
                            (Content_2.AbsoluteWindowSize.Y / Content_2.CanvasSize.Y.Offset),
                            0
                        )
                    Bar_2.Position = UDim2.new(Bar_2.Position.X.Scale, 0, Y, 0)
                else
                    Bar_2.Size = UDim2.new(0, (Thickness - 4), 0, 0)
                    ScrollBarY.Visible = false
                end
            end
            
            refreshScrollBars()
            
            Bar_2.MouseButton1Down:Connect(
                function(x, y)
                    LastMouseMove = Vector2.new(x, y)
                    isDraggingY = true
                    Bar_2.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
                end
            )
            Bar.MouseButton1Down:Connect(
                function(x, y)
                    LastMouseMove = Vector2.new(x, y)
                    isDraggingX = true
                    Bar.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
                end
            )
            
            UserInputService.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDraggingY = false
                        isDraggingX = false
                        LastMouseMove = Vector2.new(0, 0)
                        Bar_2.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                        Bar.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                    end
                end
            )
            UserInputService.InputChanged:Connect(
                function(input, gameProcessed)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        local x = Mouse.X
                        local y = Mouse.Y
                        if
                            isDraggingY == true and
                                UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        then
                            local DragY = (y - LastMouseMove.Y)
                            LastMouseMove = Vector2.new(x, y)
                            local scaleY = Content_2.CanvasSize.Y.Offset / (Content.AbsoluteSize.Y)
                            local newY = (Content_2.CanvasPosition.Y + (DragY * scaleY))
                            Content_2.CanvasPosition = Vector2.new(Content_2.CanvasPosition.X, newY)
                        elseif
                            isDraggingX == true and
                                UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        then
                            local DragX = (x - LastMouseMove.X)
                            LastMouseMove = Vector2.new(x, y)
                            local scaleX = Content_2.CanvasSize.X.Offset / (Content.AbsoluteSize.X)
                            local newX = (Content_2.CanvasPosition.X + (DragX * scaleX))
                            Content_2.CanvasPosition = Vector2.new(newX, Content_2.CanvasPosition.Y)
                        elseif
                            (isDraggingY == true or isDraggingX == true) and
                                not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        then
                            isDraggingY = false
                            isDraggingY = false
                            LastMouseMove = Vector2.new(0, 0)
                            Bar_2.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                            Bar.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                        end
                    end
                end
            )
            UIListLayout.Changed:Connect(
                function()
                    Content_2.CanvasSize =
                        UDim2.new(0, (UIListLayout.AbsoluteContentSize.X - Thickness), 0, UIListLayout.AbsoluteContentSize.Y - Thickness)
                    refreshList()
                end
            )
            Content_2.Changed:Connect(
                function()
                    refreshScrollBars()
                end
            )
            Content_2.CanvasSize =
                UDim2.new(0, (UIListLayout.AbsoluteContentSize.X - Thickness), 0, UIListLayout.AbsoluteContentSize.Y - Thickness)
            for i,v in pairs(Content_2:GetChildren()) do
                if v:IsA("TextButton") then
                    animateButton(v)
                end
            end
            Content_2.ChildAdded:Connect(function(instance)
                if instance:IsA("TextButton") then
                    animateButton(instance)
                end
            end)
            refreshList()            

            return element
        end
    },
    {
        Class = "Tabs",
        onCreate = function(self, elementSettings)

            local Tabs = Instance.new("Frame")
            local Top = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")
            local Content = Instance.new("Frame")
            local Contents = Instance.new("ScrollingFrame")
            local UIListLayout_2 = Instance.new("UIListLayout")
            local UIListLayout_3 = Instance.new("UIListLayout")


            Tabs.Name = "Tabs"
            Tabs.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            Tabs.BackgroundTransparency = 1.000
            Tabs.BorderSizePixel = 0
            Tabs.Size = UDim2.new(1, 0, 1, 0)

            Top.Name = "Top"
            Top.Parent = Tabs
            Top.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            Top.BorderSizePixel = 0
            Top.Size = UDim2.new(1, 0, 0, 40)
            Top.LayoutOrder = 1

            UIListLayout.Parent = Top
            UIListLayout.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom

            Content.Name = "Content"
            Content.Parent = Tabs
            Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Content.BackgroundTransparency = 1.000
            Content.Size = UDim2.new(1, 0, 1, -40)
            Content.LayoutOrder = 2

            Contents.Name = "Contents"
            Contents.Parent = Content
            Contents.Active = true
            Contents.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Contents.BackgroundTransparency = 1.000
            Contents.BorderSizePixel = 0
            Contents.Size = UDim2.new(1, 0, 1, 0)

            UIListLayout_2.Parent = Contents
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

            UIListLayout_3.Parent = Tabs
            UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

            local ScrollBarX = Instance.new("Frame")
            local Bar = Instance.new("TextButton")
            local ScrollBarY = Instance.new("Frame")
            local Bar_2 = Instance.new("TextButton")

            ScrollBarX.Name = "ScrollBarX"
            ScrollBarX.Parent = Content
            ScrollBarX.AnchorPoint = Vector2.new(0, 1)
            ScrollBarX.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            ScrollBarX.BorderSizePixel = 0
            ScrollBarX.Position = UDim2.new(0, 0, 1, 0)
            ScrollBarX.Size = UDim2.new(1, 0, 0, 12)
            ScrollBarX.Visible = false

            Bar.Name = "Bar"
            Bar.Parent = ScrollBarX
            Bar.AnchorPoint = Vector2.new(0, 0.5)
            Bar.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
            Bar.BorderSizePixel = 0
            Bar.Position = UDim2.new(0, 0, 0.5, 0)
            Bar.Size = UDim2.new(0, 100, 0, 14)
            Bar.AutoButtonColor = false
            Bar.Font = Enum.Font.SourceSans
            Bar.Text = ""
            Bar.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bar.TextSize = 14.000
            Bar.TextTransparency = 1.000

            ScrollBarY.Name = "ScrollBarY"
            ScrollBarY.Parent = Content
            ScrollBarY.AnchorPoint = Vector2.new(1, 0)
            ScrollBarY.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            ScrollBarY.BorderSizePixel = 0
            ScrollBarY.Position = UDim2.new(1, 0, 0, 0)
            ScrollBarY.Size = UDim2.new(0, 12, 1, 0)
            ScrollBarY.Visible = false

            Bar_2.Name = "Bar"
            Bar_2.Parent = ScrollBarY
            Bar_2.AnchorPoint = Vector2.new(0.5, 0)
            Bar_2.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
            Bar_2.BorderSizePixel = 0
            Bar_2.Position = UDim2.new(0.5, 0, 0, 0)
            Bar_2.Size = UDim2.new(0, 14, 0, 100)
            Bar_2.AutoButtonColor = false
            Bar_2.Font = Enum.Font.SourceSans
            Bar_2.Text = ""
            Bar_2.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bar_2.TextSize = 14.000
            Bar_2.TextTransparency = 1.000

            local Destroyed = false

            local isDraggingY = false
            local isDraggingX = false
            local LastMouseMove = Vector2.new(0, 0)
            local Thickness = 12



            local refreshScrollBars = function()

            end


            local element
            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Tabs:Destroy()
                        Destroyed = true
                    end,
                    userFunctions = {
                        {
                            Index = "createTab",
                            Function = function(tab)
                                --[[
                                    Tab Button
                                ]]--
                                local Tab = Instance.new("TextButton")
                                local Line = Instance.new("Frame")
                
                                Tab.Name = "Tab"
                                Tab.Parent = Top
                                Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                Tab.BackgroundTransparency = 1.000
                                Tab.BorderSizePixel = 0
                                Tab.Size = UDim2.new(0, 100, 1, -10)
                                Tab.Font = Enum.Font.RobotoCondensed
                                Tab.RichText = true
                                Tab.Text = "<b>"..tab.."</b>"
                                Tab.TextColor3 = element.textColor
                                Tab.TextSize = 16
                                Tab.TextYAlignment = Enum.TextYAlignment.Top
                                Tab.Size = UDim2.new(0, Tab.TextBounds.X + 38, 0, 30)
                
                                Line.Name = "Line"
                                Line.Parent = Tab
                                Line.BackgroundColor3 = element.primaryColor
                                Line.Position = UDim2.new(0, 0, 1, -2)
                                Line.Size = UDim2.new(1, 0, 0, 2)
                                Line.Visible = false
                                
                                
                                --[[
                                    Tab Content
                                ]]--		
                                local TabContent = Instance.new("Frame")
                                local _UIListLayout = Instance.new("UIListLayout")
                
                                TabContent.Name = "TabContent"
                                TabContent.Parent = Contents
                                TabContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                TabContent.BackgroundTransparency = 1.000
                                TabContent.Visible = false
                
                                _UIListLayout.Parent = TabContent
                                _UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                                _UIListLayout.Padding = UDim.new(0, 10)
                                
                                _UIListLayout.Changed:Connect(function(Property)
                                    if Property == "AbsoluteContentSize" then
                                        local newSize = _UIListLayout.AbsoluteContentSize
                                        TabContent.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
                                    end
                                end)
                                
                                local id = HttpService:GenerateGUID(false)
                                
                                local iTab = {
                                    Content = TabContent,
                                    Tab = Tab
                                }
                                local rTab = {
                                    Content = TabContent,
                                    destroyTab = function(self)
                                        element.tabs[id] = nil
                                        Tab:Destroy()
                                        TabContent:Destroy()
                                        self = nil
                                    end,
                                    selectTab = function(self)
                                        for i,v in pairs(element.tabs) do
                                            v.Content.Visible = false
                                            v.Tab.TextColor3 = element.textColor
                                            v.Tab.Line.Visible = false
                                        end
                                        TabContent.Visible = true
                                        Tab.TextColor3 = element.primaryColor
                                        Line.Visible = true
                                    end
                                }
                                
                                element.tabs[id] = iTab
                                
                                Tab.MouseButton1Click:Connect(function()
                                    for i,v in pairs(element.tabs) do
                                        v.Content.Visible = false
                                        v.Tab.TextColor3 = element.textColor
                                        v.Tab.Line.Visible = false
                                    end
                                    TabContent.Visible = true
                                    Tab.TextColor3 = element.primaryColor
                                    Line.Visible = true
                                end)
                                
                                return rTab
                            end
                        }
                    },
                    userSettings = {
                        {
                            Property = "Parent",
                            Value = Tabs.Parent,
                            onChange = function(newValue)
                                Tabs.Parent = newValue
                                Tabs.Size = UDim2.new(1, -1, 0, newValue.AbsoluteSize.Y)
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = (_G.atOm.theme.tabs.primaryColor or Color3.fromRGB(38, 38, 38)),
                            onChange = function(newValue)
                                for i,v in pairs(element.Tabs) do
                                    v.Tab.Line.BackgroundColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "textColor",
                            Value = (_G.atOm.theme.tabs.textColor or Color3.fromRGB(255, 255, 255)),
                            onChange = function(newValue)
                                for i,v in pairs(element.Tabs) do
                                    v.Tab.TextColor3 = newValue
                                end
                            end
                        },
                        {
                            Property = "tabs",
                            Value = {},
                            Occuring = true
                        }
                    }
                }
            )

            local refreshScrollBars = function()
                Contents.CanvasSize =
                    UDim2.new(0, (Contents.UIListLayout.AbsoluteContentSize.X), 0, Contents.UIListLayout.AbsoluteContentSize.Y)
            
                local canvas_scaleY =
                    Contents.CanvasPosition.Y / (Contents.CanvasSize.Y.Offset - Contents.AbsoluteWindowSize.Y)
                local Y = (1 - Bar_2.Size.Y.Scale) * canvas_scaleY
            
                local canvas_scaleX =
                    Contents.CanvasPosition.X / (Contents.CanvasSize.X.Offset - Contents.AbsoluteWindowSize.X)
                local X = (1 - Bar.Size.X.Scale) * canvas_scaleX
            
                local isXScroll = (Contents.UIListLayout.AbsoluteContentSize.X > Contents.AbsoluteWindowSize.X)
                local isYScroll = (Contents.UIListLayout.AbsoluteContentSize.Y > Contents.AbsoluteWindowSize.Y)
            
                if isXScroll and isYScroll then
                    ScrollBarY.Size = UDim2.new(0, Thickness, 1, -(Thickness))
                    ScrollBarX.Size = UDim2.new(1, -(Thickness), 0, Thickness)
                else
                    ScrollBarY.Size = UDim2.new(0, Thickness, 1, 0)
                    ScrollBarX.Size = UDim2.new(1, 0, 0, Thickness)
                end
                if isXScroll then
                    ScrollBarX.Visible = true
                    Bar.Size =
                        UDim2.new(
                            (Contents.AbsoluteWindowSize.X / Contents.CanvasSize.X.Offset),
                            0,
                            0,
                            (Thickness - 4)
                        )
                    Bar.Position = UDim2.new(X, 0, Bar.Position.Y.Scale, 0)
                else
                    Bar.Size = UDim2.new(0, 0, 0, (Thickness - 4))
                    ScrollBarX.Visible = false
                end
                if isYScroll then
                    ScrollBarY.Visible = true
                    Bar_2.Size =
                        UDim2.new(
                            0,
                            (Thickness - 4),
                            (Contents.AbsoluteWindowSize.Y / Contents.CanvasSize.Y.Offset),
                            0
                        )
                    Bar_2.Position = UDim2.new(Bar_2.Position.X.Scale, 0, Y, 0)
                else
                    Bar_2.Size = UDim2.new(0, (Thickness - 4), 0, 0)
                    ScrollBarY.Visible = false
                end
            end
            
            refreshScrollBars()
            
            Bar_2.MouseButton1Down:Connect(
                function(x, y)
                    LastMouseMove = Vector2.new(x, y)
                    isDraggingY = true
                    Bar_2.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
                end
            )
            Bar.MouseButton1Down:Connect(
                function(x, y)
                    LastMouseMove = Vector2.new(x, y)
                    isDraggingX = true
                    Bar.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
                end
            )
            
            UserInputService.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDraggingY = false
                        isDraggingX = false
                        LastMouseMove = Vector2.new(0, 0)
                        Bar_2.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                        Bar.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                    end
                end
            )
            UserInputService.InputChanged:Connect(
                function(input, gameProcessed)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        local x = Mouse.X
                        local y = Mouse.Y
                        if
                            isDraggingY == true and
                                UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        then
                            local DragY = (y - LastMouseMove.Y)
                            LastMouseMove = Vector2.new(x, y)
                            local scaleY = Contents.CanvasSize.Y.Offset / (Content.AbsoluteSize.Y)
                            local newY = (Contents.CanvasPosition.Y + (DragY * scaleY))
                            Contents.CanvasPosition = Vector2.new(Contents.CanvasPosition.X, newY)
                        elseif
                            isDraggingX == true and
                                UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        then
                            local DragX = (x - LastMouseMove.X)
                            LastMouseMove = Vector2.new(x, y)
                            local scaleX = Contents.CanvasSize.X.Offset / (Content.AbsoluteSize.X)
                            local newX = (Contents.CanvasPosition.X + (DragX * scaleX))
                            Contents.CanvasPosition = Vector2.new(newX, Contents.CanvasPosition.Y)
                        elseif
                            (isDraggingY == true or isDraggingX == true) and
                                not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                        then
                            isDraggingY = false
                            isDraggingY = false
                            LastMouseMove = Vector2.new(0, 0)
                            Bar_2.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                            Bar.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                        end
                    end
                end
            )
            
            Contents.UIListLayout.Changed:Connect(
                function()
                    print("change")
                    Contents.CanvasSize =
                        UDim2.new(0, (Contents.UIListLayout.AbsoluteContentSize.X - Thickness), 0, Contents.UIListLayout.AbsoluteContentSize.Y - Thickness)
                end
            )
            
            Contents.Changed:Connect(
                function()
                    refreshScrollBars()
                end
            )
            Contents.CanvasSize =
                UDim2.new(0, (Contents.UIListLayout.AbsoluteContentSize.X - Thickness), 0, Contents.UIListLayout.AbsoluteContentSize.Y - Thickness)
                       

            return element
        end
    },
    {
        Class = "Window",
        onCreate = function(self, elementSettings)
            local Window = Instance.new("ImageLabel")
            local Content = Instance.new("Frame")
            local Top = Instance.new("Frame")
            local Control = Instance.new("Frame")
            local UIListLayout = Instance.new("UIListLayout")
            local TextButton = Instance.new("TextButton")
            local ImageLabel = Instance.new("ImageLabel")
            local TextButton_2 = Instance.new("TextButton")
            local ImageLabel_2 = Instance.new("ImageLabel")
            local Info = Instance.new("Frame")
            local UIListLayout_2 = Instance.new("UIListLayout")
            local Logo = Instance.new("Frame")
            local ImageLabel_3 = Instance.new("ImageLabel")
            local WindowTitle = Instance.new("TextLabel")

            --Properties:

            Window.Name = "Window"
            Window.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Window.BackgroundTransparency = 1.000
            Window.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Window.BorderSizePixel = 0
            Window.Position = UDim2.new(0.5, 0, 0.5, 0)
            Window.Size = UDim2.new(0, 700, 0, 472)
            Window.Image = "http://www.roblox.com/asset/?id=7005393664"
            Window.ImageColor3 = Color3.fromRGB(38, 38, 38)
            Window.AnchorPoint = Vector2.new(0.5, 0.5)

            Content.Name = "Content"
            Content.Parent = Window
            Content.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
            Content.BorderColor3 = Color3.fromRGB(23, 23, 23)
            Content.BorderSizePixel = 0
            Content.Position = UDim2.new(0.0410000011, 0, 0.0390000008, 26)
            Content.Size = UDim2.new(0.917999983, 0, 0.921000004, -25)

            Top.Name = "Top"
            Top.Parent = Window
            Top.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            Top.BorderSizePixel = 0
            Top.Position = UDim2.new(0.0410000011, 0, 0.0390000008, 1)
            Top.Size = UDim2.new(0.917999983, 0, 0, 25)

            Control.Name = "Control"
            Control.Parent = Top
            Control.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Control.BackgroundTransparency = 1.000
            Control.BorderSizePixel = 0
            Control.Size = UDim2.new(1, 0, 1, 0)

            UIListLayout.Parent = Control
            UIListLayout.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

            TextButton.Parent = Control
            TextButton.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            TextButton.BorderSizePixel = 0
            TextButton.Size = UDim2.new(0, 35, 0, 25)
            TextButton.Font = Enum.Font.SourceSans
            TextButton.Text = ""
            TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.TextSize = 14.000

            ImageLabel.Parent = TextButton
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ImageLabel.BackgroundTransparency = 1.000
            ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
            ImageLabel.Size = UDim2.new(1, 0, 1, -5)
            ImageLabel.Image = "http://www.roblox.com/asset/?id=7005448756"
            ImageLabel.ScaleType = Enum.ScaleType.Fit

            TextButton_2.Parent = Control
            TextButton_2.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            TextButton_2.BorderSizePixel = 0
            TextButton_2.Size = UDim2.new(0, 35, 0, 25)
            TextButton_2.AutoButtonColor = false
            TextButton_2.Font = Enum.Font.SourceSans
            TextButton_2.Text = ""
            TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_2.TextSize = 14.000

            ImageLabel_2.Parent = TextButton_2
            ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
            ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ImageLabel_2.BackgroundTransparency = 1.000
            ImageLabel_2.Position = UDim2.new(0.5, 0, 0.5, 0)
            ImageLabel_2.Size = UDim2.new(1, 0, 1, -5)
            ImageLabel_2.Image = "http://www.roblox.com/asset/?id=7005447610"
            ImageLabel_2.ScaleType = Enum.ScaleType.Fit

            Info.Name = "Info"
            Info.Parent = Top
            Info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Info.BackgroundTransparency = 1.000
            Info.BorderSizePixel = 0
            Info.Size = UDim2.new(1, 0, 1, 0)

            UIListLayout_2.Parent = Info
            UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
            UIListLayout_2.Padding = UDim.new(0, 5)

            Logo.Name = "Logo"
            Logo.Parent = Info
            Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Logo.BackgroundTransparency = 1.000
            Logo.Size = UDim2.new(0, 25, 0, 25)

            ImageLabel_3.Parent = Logo
            ImageLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
            ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ImageLabel_3.BackgroundTransparency = 1.000
            ImageLabel_3.BorderSizePixel = 0
            ImageLabel_3.Position = UDim2.new(0.5, 0, 0.5, 0)
            ImageLabel_3.Size = UDim2.new(1, -5, 1, -5)
            ImageLabel_3.Image = "http://www.roblox.com/asset/?id=7005536545"
            ImageLabel_3.ScaleType = Enum.ScaleType.Fit

            WindowTitle.Name = "Window Title"
            WindowTitle.Parent = Info
            WindowTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            WindowTitle.BackgroundTransparency = 1.000
            WindowTitle.BorderSizePixel = 0
            WindowTitle.Size = UDim2.new(0, 200, 1, 0)
            WindowTitle.Font = Enum.Font.Roboto
            WindowTitle.Text = ""
            WindowTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            WindowTitle.TextSize = 13.000
            WindowTitle.TextWrapped = true
            WindowTitle.TextXAlignment = Enum.TextXAlignment.Left

            local Content_1 = Instance.new("ScrollingFrame")
            local UIListLayout_3 = Instance.new("UIListLayout")
            local ScrollBarY = Instance.new("Frame")
            local Bar = Instance.new("TextButton")
            local ScrollBarX = Instance.new("Frame")
            local Bar_2 = Instance.new("TextButton")

            --Properties:

            Content_1.Name = "Content"
            Content_1.Parent = Content
            Content_1.Active = true
            Content_1.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
            Content_1.BorderSizePixel = 0
            Content_1.Size = UDim2.new(1, 0, 1, 0)
            Content_1.CanvasSize = UDim2.new(0, 0, 0, 0)
            Content_1.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
            Content_1.ScrollBarThickness = 14
            Content_1.ScrollBarImageTransparency = 1

            UIListLayout_3.Parent = Content_1
            UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder

            ScrollBarY.Name = "ScrollBarY"
            ScrollBarY.Parent = Content
            ScrollBarY.AnchorPoint = Vector2.new(1, 0)
            ScrollBarY.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            ScrollBarY.BorderSizePixel = 0
            ScrollBarY.Position = UDim2.new(1, 0, 0, 0)
            ScrollBarY.Size = UDim2.new(0, 14, 1, 0)
            ScrollBarY.Visible = false

            Bar.Name = "Bar"
            Bar.Parent = ScrollBarY
            Bar.AnchorPoint = Vector2.new(0.5, 0)
            Bar.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
            Bar.BorderSizePixel = 0
            Bar.Position = UDim2.new(0.5, 0, 0, 0)
            Bar.Size = UDim2.new(0, 10, 0, 100)
            Bar.AutoButtonColor = false
            Bar.Font = Enum.Font.SourceSans
            Bar.Text = "0"
            Bar.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bar.TextSize = 14.000
            Bar.TextTransparency = 1.000

            ScrollBarX.Name = "ScrollBarX"
            ScrollBarX.Parent = Content
            ScrollBarX.AnchorPoint = Vector2.new(0, 1)
            ScrollBarX.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            ScrollBarX.BorderSizePixel = 0
            ScrollBarX.Position = UDim2.new(0, 0, 1, 0)
            ScrollBarX.Size = UDim2.new(1, 0, 0, 14)
            ScrollBarX.Visible = false

            Bar_2.Name = "Bar"
            Bar_2.Parent = ScrollBarX
            Bar_2.AnchorPoint = Vector2.new(0, 0.5)
            Bar_2.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
            Bar_2.BorderSizePixel = 0
            Bar_2.Position = UDim2.new(0, 0, 0.5, 0)
            Bar_2.Size = UDim2.new(0, 100, 0, 10)
            Bar_2.AutoButtonColor = false
            Bar_2.Font = Enum.Font.SourceSans
            Bar_2.Text = "0"
            Bar_2.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bar_2.TextSize = 14.000
            Bar_2.TextTransparency = 1.000

            local Destroyed = false

            local element
            element =
                _G.atOm:createElement(
                {
                    Class = self.Class,
                    onDestroy = function()
                        Window:Destroy()
                        Destroyed = true
                    end,
                    Content = Content_1,
                    userSettings = {
                        {
                            Property = "Width",
                            Value = Window.Size.X.Offset,
                            Occuring = true,
                            onChange = function(newValue)
                                Window.Size = UDim2.new(0, newValue, 0, (newValue * 0.6750681198910082))
                            end
                        },
                        {
                            Property = "Visible",
                            Value = Window.Visible,
                            Occuring = true,
                            onChange = function(newValue)
                                Window.Visible = newValue
                            end
                        },
                        {
                            Property = "Position",
                            Value = Window.Position,
                            Occuring = true,
                            onChange = function(newValue)
                                Window.Position = newValue
                            end
                        },
                        {
                            Property = "AnchorPoint",
                            Value = Window.AnchorPoint,
                            Occuring = true,
                            onChange = function(newValue)
                                Window.AnchorPoint = newValue
                            end
                        },
                        {
                            Property = "Parent",
                            Value = Window.Parent,
                            onChange = function(newValue)
                                Window.Parent = newValue
                            end
                        },
                        {
                            Property = "primaryColor",
                            Value = (_G.atOm.theme.windows.primaryColor or Content.BackgroundColor3),
                            Occuring = true,
                            onChange = function(newValue)
                                Content.BackgroundColor3 = newValue
                            end
                        },
                        {
                            Property = "secondaryColor",
                            Value = (_G.atOm.theme.windows.secondaryColor or Top.BackgroundColor3),
                            Occuring = true,
                            onChange = function(newValue)
                                Top.BackgroundColor3 = newValue
                                TextButton.BackgroundColor3 = newValue
                                TextButton_2.BackgroundColor3 = newValue
                            end
                        },
                        {
                            Property = "titleColor",
                            Value = (_G.atOm.theme.windows.titleColor or Title.TextColor3),
                            Occuring = true,
                            onChange = function(newValue)
                                titleColor.TextColor3 = newValue
                            end
                        },
                        {
                            Property = "buttonColor",
                            Value = (_G.atOm.theme.windows.buttonColor or TextButton.ImageColor3),
                            Occuring = true,
                            onChange = function(newValue)
                                TextButton.ImageColor3 = newValue
                                TextButton_2.ImageColor3 = newValue
                            end
                        },
                        {
                            Property = "iconColor",
                            Value = (_G.atOm.theme.windows.iconColor or ImageLabel_3.ImageColor3),
                            Occuring = true,
                            onChange = function(newValue)
                                ImageLabel_3.ImageColor3 = newValue
                            end
                        },
                        {
                            Property = "Icon",
                            Value = (_G.atOm.theme.windows.icon or ImageLabel_3.Image),
                            Occuring = true,
                            onChange = function(newValue)
                                ImageLabel_3.Image = newValue
                            end
                        },
                        {
                            Property = "Title",
                            Value = WindowTitle.Text,
                            Occuring = true,
                            onChange = function(newValue)
                                WindowTitle.Text = newValue
                            end
                        },
                        {
                            Property = "closeDestroy",
                            Value = true,
                            Occuring = true,
                            onChange = function()
                                TextButton_2.MouseButton1Click:Connect(
                                    function()
                                        if element.closeDestroy == true then
                                            element:Destroy()
                                        else
                                            element.Visible = false
                                        end       
                                    end
                                )
                            end
                        },
                    }
                }
            )

            TextButton_2.MouseButton1Click:Connect(
                                    function()
                                        if element.closeDestroy == true then
                                            element:Destroy()
                                        else
                                            element.Visible = false
                                        end       
                                    end
                                )

            local NormalInfo = {
                BackgroundColor3 = element.secondaryColor
            }

            local Tween

            

            local onHover = function()
                NormalInfo.BackgroundColor3 = element.secondaryColor
                Tween =
                    TweenService:Create(
                    TextButton_2,
                    TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0),
                    NormalInfo
                )
                Tween:Play()
            end

            ImageLabel_2.MouseLeave:Connect(onHover)
            MouseLibrary.bindMouseEvents(
                TextButton_2,
                function()
                    Tween =
                        TweenService:Create(
                        TextButton_2,
                        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
                        {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}
                    )
                    Tween:Play()
                end,
                onHover
            )

            local refreshInfoBar = function()
                Info.Size = UDim2.new(1, -(UIListLayout.AbsoluteContentSize.X), 1, 0)
            end

            local isDraggingY = false
            local isDraggingX = false
            local LastMouseMove = Vector2.new(0, 0)
            local Thickness = 14
            local lastPosition = Vector2.new(0, 0)
            local isTouchTopBar = false
            local isDragging = false

            local refreshScrollBars = function()
                Content_1.CanvasSize =
                    UDim2.new(0, UIListLayout_3.AbsoluteContentSize.X, 0, UIListLayout_3.AbsoluteContentSize.Y)

                local canvas_scaleY =
                    Content_1.CanvasPosition.Y / (Content_1.CanvasSize.Y.Offset - Content_1.AbsoluteWindowSize.Y)
                local Y = (1 - Bar.Size.Y.Scale) * canvas_scaleY

                local canvas_scaleX =
                    Content_1.CanvasPosition.X / (Content_1.CanvasSize.X.Offset - Content_1.AbsoluteWindowSize.X)
                local X = (1 - Bar_2.Size.X.Scale) * canvas_scaleX

                local isXScroll = (UIListLayout_3.AbsoluteContentSize.X > Content_1.AbsoluteWindowSize.X)
                local isYScroll = (UIListLayout_3.AbsoluteContentSize.Y > Content_1.AbsoluteWindowSize.Y)

                if isXScroll and isYScroll then
                    ScrollBarY.Size = UDim2.new(0, 14, 1, -(Thickness))
                    ScrollBarX.Size = UDim2.new(1, -(Thickness), 0, 14)
                else
                    ScrollBarY.Size = UDim2.new(0, 14, 1, 0)
                    ScrollBarX.Size = UDim2.new(1, 0, 0, 14)
                end
                if isXScroll then
                    ScrollBarX.Visible = true
                    Bar_2.Size =
                        UDim2.new(
                        (Content_1.AbsoluteWindowSize.X / Content_1.CanvasSize.X.Offset),
                        0,
                        0,
                        (Thickness - 4)
                    )
                    Bar_2.Position = UDim2.new(X, 0, Bar_2.Position.Y.Scale, 0)
                else
                    Bar_2.Size = UDim2.new(0, 0, 0, (Thickness - 4))
                    ScrollBarX.Visible = false
                end
                if isYScroll then
                    ScrollBarY.Visible = true
                    Bar.Size =
                        UDim2.new(
                        0,
                        (Thickness - 4),
                        (Content_1.AbsoluteWindowSize.Y / Content_1.CanvasSize.Y.Offset),
                        0
                    )
                    Bar.Position = UDim2.new(Bar.Position.X.Scale, 0, Y, 0)
                else
                    Bar.Size = UDim2.new(0, (Thickness - 4), 0, 0)
                    ScrollBarY.Visible = false
                end
            end

            refreshScrollBars()
            refreshInfoBar()

            UIListLayout_3.Changed:Connect(
                function()
                    Content_1.CanvasSize =
                        UDim2.new(0, UIListLayout_3.AbsoluteContentSize.X, 0, UIListLayout_3.AbsoluteContentSize.Y)
                end
            )

            UIListLayout.Changed:Connect(
                function()
                    refreshInfoBar()
                end
            )

            Content_1.Changed:Connect(
                function()
                    refreshScrollBars()
                end
            )

            Info.MouseEnter:Connect(
                function()
                    isTouchTopBar = true
                end
            )
            Info.MouseLeave:Connect(
                function()
                    isTouchTopBar = false
                end
            )

            Bar.MouseButton1Down:Connect(
                function(x, y)
                    LastMouseMove = Vector2.new(x, y)
                    isDraggingY = true
                    Bar.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
                end
            )
            Bar_2.MouseButton1Down:Connect(
                function(x, y)
                    LastMouseMove = Vector2.new(x, y)
                    isDraggingX = true
                    Bar_2.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
                end
            )

            UserInputService.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        isDraggingY = false
                        isDraggingX = false
                        isDragging = false
                        lastPosition = Vector2.new(0, 0)
                        LastMouseMove = Vector2.new(0, 0)
                        Bar.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                        Bar_2.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                    end
                end
            )
            UserInputService.InputChanged:Connect(
                function(input, gameProcessed)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        if isDragging then
                            local Drag = Vector2.new((Mouse.X - lastPosition.X), (Mouse.Y - lastPosition.Y))
                            lastPosition = Vector2.new(Mouse.X, Mouse.Y)
                            Window.Position = (Window.Position + UDim2.new(0, Drag.X, 0, Drag.Y))
                        end
                        local x = Mouse.X
                        local y = Mouse.Y
                        if
                            isDraggingY == true and
                                UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                         then
                            local DragY = (y - LastMouseMove.Y)
                            LastMouseMove = Vector2.new(x, y)
                            local scaleY = Content_1.CanvasSize.Y.Offset / (Content.AbsoluteSize.Y)
                            local newY = (Content_1.CanvasPosition.Y + (DragY * scaleY))
                            Content_1.CanvasPosition = Vector2.new(Content_1.CanvasPosition.X, newY)
                        elseif
                            isDraggingX == true and
                                UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                         then
                            local DragX = (x - LastMouseMove.X)
                            LastMouseMove = Vector2.new(x, y)
                            local scaleX = Content_1.CanvasSize.X.Offset / (Content.AbsoluteSize.X)
                            local newX = (Content_1.CanvasPosition.X + (DragX * scaleX))
                            Content_1.CanvasPosition = Vector2.new(newX, Content_1.CanvasPosition.Y)
                        elseif
                            (isDraggingY == true or isDraggingX == true) and
                                not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                         then
                            isDraggingY = false
                            isDraggingY = false
                            LastMouseMove = Vector2.new(0, 0)
                            Bar.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                            Bar_2.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
                        end
                    end
                end
            )

            UserInputService.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 and isTouchTopBar then
                        isDragging = true
                        lastPosition = Vector2.new(Mouse.X, Mouse.Y)
                    end
                end
            )

            return element
        end
    }
}

return Package