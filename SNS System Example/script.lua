require("SNS_system.dataStore&Retrive")
config:name('SNS_example')
models.model.cube:setColor(1,0,0)

if not host:isHost() then return end

if not config:load("cubeToggle") then
    dataStore.generic("cubeToggle", {ID = {"visible"}, val = {true}})
end

if not config:load("cubeAnim") then
    dataStore.generic("cubeAnim", {ID = {"spin"}, val = {false}})
end

examplePage = action_wheel:newPage()
action_wheel:setPage(examplePage)

-- toggle cube action wheel
toggleCube = examplePage:newAction(1):setTitle('Toggle Cube'):setToggled(config:load("cubeToggle").visible)

function toggleCube.toggle(bool)
    dataStore.generic("cubeToggle", {ID = {"visible"}, val = {bool}})
end

-- cube colour action wheel
cubeColor = examplePage:newAction(2):setTitle('Cube Color')

function cubeColor.scroll(scrollDir)
    local color = vectors.rgbToHSV(snsData.cubeColor.color)
    color = vec((color.x + scrollDir/10) % 1, color.y, color.z)
    color = vectors.hsvToRGB(color)
    dataStore.generic("cubeColor",{ID = {"color"}, val = {color}})
end

-- cube texture action wheel
cubeTexture = examplePage:newAction(3):setTitle('Cube Texture')

function cubeTexture.scroll(scrollDir)
    local textureOrder = {"model.smile","model.frown"}
    local textureID
    for k,v in pairs(textureOrder) do
        if snsData.cubeTexture.primaryTexture == v then
            textureID = k
        end
    end
    textureID = textureID - 1 -- why does lua index from 1 omg I hate lua
    textureID = ((textureID + scrollDir) % #textureOrder)
    dataStore.generic("cubeTexture",{ID = {"primaryTexture"}, val = {textureOrder[textureID + 1]}})
end

-- cube spin action wheel
cubeSpin = examplePage:newAction(4):setTitle('Cube Spin'):setToggled(config:load("cubeAnim").spin)

function cubeSpin.toggle(bool)
    dataStore.generic("cubeAnim", {ID = {"spin"}, val = {bool}})
end

-- cube roll action wheel
cubeRoll = examplePage:newAction(5):setTitle('Cube Roll'):setToggled(config:load("cubeAnim").roll)

function cubeRoll.toggle(bool)
    dataStore.generic("cubeAnim", {ID = {"roll"}, val = {bool}})
end

