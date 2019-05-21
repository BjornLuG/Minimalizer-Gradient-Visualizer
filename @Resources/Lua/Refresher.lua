function Initialize()
    if IsCache("LineCount") and IsCache("LineGap") and IsCache("LineWidth") and IsCache("LineHeight") then 
		SKIN:Bang("!WriteKeyValue", SELF:GetName(), "Refreshed", "0")
    elseif SELF:GetOption("Refreshed", "0") == "0" then
        SKIN:Bang("!WriteKeyValue", SELF:GetName(), "Refreshed", "1")
        SKIN:Bang("!Refresh")
    else
		SKIN:Bang("!WriteKeyValue", SELF:GetName(), "Refreshed", "0")
    end
end

-- Check variable prev (Custom added)
function IsCache(str) 
    if SKIN:GetVariable(str) == SKIN:GetVariable("Prev" .. str) then
        return true
    else 
        SKIN:Bang("!WriteKeyValue", "Variables", "Prev" .. str, SKIN:GetVariable(str), "#@#Internal/Previous.inc")
        return false
    end
end