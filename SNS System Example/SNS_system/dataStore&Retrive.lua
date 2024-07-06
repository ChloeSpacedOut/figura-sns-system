require("SNS_system.utils")
require("SNS_system.metadataTables")
require("SNS_system.dataTables")
-- store & retrive handler
dataStore = {}
dataRetrive = {}
local syncInterval = 20 -- in ticks

local sns_clock = 0
function events.tick()
  sns_clock = sns_clock + 1
end

function dataStore.generic(dataID,editData)
  local newEntryData = {}
  for k,v in pairs(snsData[dataID]) do
    newEntryData[k] = v
  end
  for k,v in pairs(editData.ID) do
    newEntryData[editData.ID[k]] = editData.val[k]
  end
  config:save(dataID,newEntryData)
  pings.entrySync(dataComp(newEntryData))
end

function dataRetrive.avatarSync()
  local syncEntry = snsData[syncOrder[sns_clock/syncInterval % syncLoopValue + 1]].ID
  local storedEntry = config:load(syncEntry)
  if storedEntry ~= nil then
    pings.entrySync(dataComp(storedEntry))
  end
end

function events.tick()
  if host:isHost() and sns_clock % syncInterval == 0 then
    dataRetrive.avatarSync()
  end
end