textureIndex = {}
local count = 0
for k,v in pairs(textures:getTextures()) do
  count = count + 1
  textureIndex[count] = v:getName()
end
table.sort(textureIndex,function(a,b) return a<b end)

numericIDs = {}
for k,v in pairs(snsData) do
  count = count + 1
  numericIDs[count] = v.ID
end

function dataComp(dataIn)
	local dataOut = {}
	if dataIn.ID then
		for k,v in pairs(numericIDs) do
			if v == dataIn.ID then
				dataIn.ID = k
			end
		end
	end

	for _,texture in pairs({"primaryTexture","secondaryTexture"}) do
		if dataIn[texture] then
			if dataIn[texture] == 'nil' then
				dataIn[texture] = 0
			else
				for k,v in pairs(textureIndex) do
					if v == dataIn[texture] then
						dataIn[texture] = k
					end
				end
			end
			
		end
	end

	for k,v in pairs(dataIn) do
		for i,j in pairs(numericDataKeys) do
			if j == k then
				dataOut[i] = v
			end
		end
	end
	return dataOut
end

function dataDecomp(dataIn)
	local dataOut = {}
	for k,v in pairs(dataIn) do
		dataOut[numericDataKeys[k]] = v
	end
	if dataOut.ID then
		dataOut.ID = numericIDs[dataOut.ID]
	end
	for _,texture in pairs({"primaryTexture","secondaryTexture"}) do
		if dataOut[texture] then
			if dataOut[texture] == 0 then
				dataOut[texture] = 'nil'
			else
				dataOut[texture] = textureIndex[dataOut[texture]]
			end
		end
	end
	return dataOut
end