local EasyGUI = {}

-- Вспомогательные функции
local function createElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

-- Создание окна (основного контейнера)
function EasyGUI.createWindow(parent, size, position, name)
    local window = createElement("Frame", {
        Name = name or "Window",
        Size = size or UDim2.new(0.5, 0, 0.5, 0),
        Position = position or UDim2.new(0.25, 0, 0.25, 0),
        BackgroundTransparency = 0.7,
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        ClipsDescendants = true
    })
    
    window.Parent = parent
    return window
end

-- Создание кнопки
function EasyGUI.createButton(parent, text, size, position)
    local button = createElement("TextButton", {
        Name = "Button",
        Size = size or UDim2.new(0, 120, 0, 40),
        Position = position or UDim2.new(0.5, -60, 0, 10),
        BackgroundColor3 = Color3.fromRGB(80, 120, 200),
        Text = text or "Button",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14
    })
    
    -- Добавление эффектов при наведении
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(100, 140, 220)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
    end)
    
    button.Parent = parent
    return button
end

-- Создание текстового поля
function EasyGUI.createLabel(parent, text, size, position)
    local label = createElement("TextLabel", {
        Name = "Label",
        Size = size or UDim2.new(0.8, 0, 0, 30),
        Position = position or UDim2.new(0.1, 0, 0, 50),
        BackgroundTransparency = 1,
        Text = text or "Label Text",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    label.Parent = parent
    return label
end

-- Создание поля ввода
function EasyGUI.createInput(parent, placeholder, size, position)
    local input = createElement("TextBox", {
        Name = "Input",
        Size = size or UDim2.new(0.8, 0, 0, 35),
        Position = position or UDim2.new(0.1, 0, 0, 100),
        BackgroundColor3 = Color3.fromRGB(60, 60, 60),
        PlaceholderText = placeholder or "Enter text...",
        Text = "",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14,
        ClearTextOnFocus = false
    })
    
    input.Parent = parent
    return input
end

-- Создание переключателя
function EasyGUI.createToggle(parent, text, default, callback)
    local toggleFrame = createElement("Frame", {
        Name = "Toggle",
        Size = UDim2.new(0, 200, 0, 30),
        BackgroundTransparency = 1
    })
    
    local toggleButton = createElement("TextButton", {
        Name = "ToggleButton",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = default and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 100, 100),
        Text = ""
    })
    
    local toggleLabel = createElement("TextLabel", {
        Name = "ToggleLabel",
        Size = UDim2.new(0, 170, 0, 30),
        Position = UDim2.new(0, 35, 0, 0),
        BackgroundTransparency = 1,
        Text = text or "Toggle Option",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Логика переключения
    local state = default or false
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        toggleButton.BackgroundColor3 = state and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 100, 100)
        if callback then callback(state) end
    end)
    
    toggleButton.Parent = toggleFrame
    toggleLabel.Parent = toggleFrame
    toggleFrame.Parent = parent
    
    return {
        frame = toggleFrame,
        setState = function(s, newState)
            state = newState
            toggleButton.BackgroundColor3 = state and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 100, 100)
        end,
        getState = function() return state end
    }
end

return EasyGUI
