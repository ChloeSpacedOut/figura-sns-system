local count = 0
numericDataKeys = {}
for k,v in pairs(snsData) do
  for i,j in pairs(v) do
    count = count + 1
    local hasDuplicate = false
    for l,m in pairs(numericDataKeys) do
      if m == i then hasDuplicate = true end
    end
    if not hasDuplicate then
      numericDataKeys[count] = i 
    end
  end
end

if host:isHost() then
  syncOrder = {}
  for k,v in pairs(snsData) do
    table.insert(syncOrder,v.ID)
  end
  -- counts how many items are in syncOrder
  local count = 0
  for k,v in pairs(syncOrder) do
    count = count + 1
  end
  syncLoopValue = count
end