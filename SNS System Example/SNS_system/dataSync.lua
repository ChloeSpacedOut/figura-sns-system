dataSync = {}
function pings.entrySync(rawNewEntryData)
  local newEntryData = dataDecomp(rawNewEntryData)
  local entryID = newEntryData.ID
  local oldEntryData = {}
  for k,v in pairs(snsData[entryID]) do
    oldEntryData[k] = v
  end
  snsData[entryID] = newEntryData
  for k,v in pairs(snsData[entryID]) do
    if v ~= oldEntryData[k] then
      if snsMetadata[entryID].snsFunctions[k] ~= nil then
        dataSync[snsMetadata[entryID].snsFunctions[k]](newEntryData,k)
      end
    end
  end
end

function dataSync.updatePart(newEntryData,entryDataKey)
  local entryID = newEntryData.ID
  local operator = 'set'..string.upper(string.sub(entryDataKey,1,1))..string.sub(entryDataKey,2,-1)
  local texturePath = textures[tostring(snsData[entryID][entryDataKey])]
  for k,v in pairs(snsMetadata[entryID].paths) do
    local path = load('return '..v)()
    if entryDataKey == "primaryTexture" or entryDataKey == "secondaryTexture" then
      if texturePath ~= nil then
        path[operator](path,'CUSTOM',texturePath)
      else
        path[operator](path,nil)
      end
    else
      path[operator](path,snsData[entryID][entryDataKey])
    end
  end
end

function dataSync.playAnimation(newEntryData,entryDataKey)
  for k,v in pairs(newEntryData) do
    if k ~= 'ID' then
      if v then
        animations.model[k]:play()
      else
        animations.model[k]:stop()
      end
    end
  end
end