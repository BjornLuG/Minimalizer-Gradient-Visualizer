function Initialize()
    grad1 = split(SKIN:GetVariable('Color1'), ",", 4)
    local grad2 = split(SKIN:GetVariable('Color2'), ",", 4)

    deltaR = grad2[1] - grad1[1]
    deltaG = grad2[2] - grad1[2]
    deltaB = grad2[3] - grad1[3]
    deltaA = grad2[4] - grad1[4]

    local volMax = SKIN:GetVariable('VolMax')
    invVolMax = 1.0 / volMax
end

function Get(band)
    local ratio = SKIN:GetMeasure('MeasureAudioChild'.. band):GetValue() * invVolMax
    return (grad1[1] + ratio * deltaR) .. "," .. (grad1[2] + ratio * deltaG) .. "," .. (grad1[3] + ratio * deltaB) .. "," .. (grad1[4] + ratio * deltaA)
end

-- Copied from https://www.lua-users.org/wiki/SplitJoin
function split(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end

    if maxNb == nil or maxNb < 1 then 
        maxNb = 0 -- No limit
    end

    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos = 0

    for part, pos in string.gmatch(str, pat) do
        local s = part

        if s ~= nil and s ~= "" then
            nb = nb + 1
            result[nb] = s
        end

        lastPos = pos

        if(nb == maxNb) then 
            break 
        end
    end

    if nb ~= maxNb then
        result[nb + 1] = str:sub(lastPos)
    end

    return result
end
