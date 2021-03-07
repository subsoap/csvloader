local utf8 = require("imports.utf8")
local M = {}

-- Via Dragosha https://forum.defold.com/t/scan-text-for-unique-characters-for-chinese-japanese-korean-fonts/64967/4
function M.get_unique_chars(input_table)
    local unique={}
    local extra_characters=""
    for k,v in pairs(input_table) do
        for kk,vv in pairs(v) do
            if vv then
                utf8.gsub(vv,".", function(c)
                if  not unique[c] then
                    unique[c]=1
                    extra_characters=extra_characters..c
                else
                    unique[c]=unique[c]+1
                end
                end)
            end
        end
    end
    return extra_characters
end

return M