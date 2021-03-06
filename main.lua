--[[
	░█████╗░████████╗░█████╗░███╗░░░███╗
	██╔══██╗╚══██╔══╝██╔══██╗████╗░████║
	███████║░░░██║░░░██║░░██║██╔████╔██║
	██╔══██║░░░██║░░░██║░░██║██║╚██╔╝██║
	██║░░██║░░░██║░░░╚█████╔╝██║░╚═╝░██║
	╚═╝░░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝
					    v1.5
	Gui Library - Main
	This is the corescript for making gui elements
]]--

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

	Element class creator

]]--

local Library

local Version = 1.5
_G.atOm = nil
--[[
	Library Returnable
]]--
local function init()
	_G.atOm = {
		version = Version,
		elementClasses = setmetatable({}, {
			__index = function(self, key)
				for i,v in pairs(self) do
					if v.Class == key then
						return v
					end
				end
				return nil
			end
		}),
		createNewElementClass = function(self, elem)
			table.insert(self.elementClasses, elem)
		end,
		createElement = function(self, elementSettings)
			local genId = HttpService:GenerateGUID(false)
            local element = {
				Id = genId,
                Destroy = function(self)
                    if elementSettings.onDestroy then
                        elementSettings.onDestroy()
                    end
                    Library.elements[genId] = nil
                end
			}
			local constants = {
				{"Class", elementSettings.Class}
			}
            if elementSettings.Content then
                table.insert(constants, {"Content", elementSettings.Content})
            end
			local variables = {}
			for i,v in pairs(elementSettings.userSettings) do
				local a = v
				if a.Occuring == true then
					a.Type = typeof(a.Value)
				end
				table.insert(variables, v)
			end
            if elementSettings.userFunctions then
                for i,v in pairs(elementSettings.userFunctions) do
                    print(v.Index..": Done")
                    element[v.Index] = v.Function
                end
            end
			setmetatable(element, {
				__newindex = function(self, key, value)
					for i,v in pairs(variables) do
						if v.Property == key then
							-- Change Value
							if v.Occuring ~= true then
								v.Value = value
								if v.onChange then
									v.onChange(value);
								end
							else
								if typeof(value) == v.Type then
									-- Filter Number Values
									if v.Type == "Number" then
										if v.Maximum then
											if value > v.Maximum then
												value = v.Maximum
											end
										end
										if v.Minimum then
											if value < v.Minimum then
												value = v.Minimum
											end
										end
									end

									-- Finalize Change
									v.Value = value
									if v.onChange then
										v.onChange(value);
									end
								end
							end
						end
					end
				end,
				__index = function(self, key)
					for i,v in pairs(constants) do
						if v[1] == key then
							return v[2]
						end
					end
					for i,v in pairs(variables) do
						if v.Property == key then
							return v.Value
						end
					end
				end,
			})
			return element
		end
	}
end
if _G.atOm ~= nil then
	if _G.atOm.version < Version then
		init()
	end
else
	init()
end
_G.atOm.theme = {

}
Library = {
	elements = {},
	newElement = function(self, class, settings)
		if settings == nil then
			settings = {}
		end
		if _G.atOm.elementClasses[class] then
			local element = _G.atOm.elementClasses[class]:onCreate(settings)
			self.elements[element.Id] = element
			return element
		end
	end,
	loadPackage = function(self, Package)
		print("atOm: loaded package '"..Package.Name.."'")
		for i,v in pairs(Package.Theme) do
			_G.atOm.theme[i] = v
		end
		for i,v in pairs(Package.Elements) do
			_G.atOm:createNewElementClass(v)
		end
	end
}

--[[
	Essentials Package
]]--

Library:loadPackage(loadstring(game:HttpGet('https://raw.githubusercontent.com/TROLLERMASTERH/atOm-library/main/essentials.lua?flush_cache=True'))())


return Library