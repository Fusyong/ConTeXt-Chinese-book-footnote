
\startluacode

context("\\incrementuniquename")

-- 定义lua函数，存储在给用户分配的userdata中
userdata = userdata or { }
function userdata.basefootnote(buf, page, uniquename)
    -- 解析位置参数
    local buf_option = utilities.parsers.settings_to_array(buf)[1]
    local page_option = utilities.parsers.settings_to_array(page)[1]
    local uniquename_option = utilities.parsers.settings_to_array(uniquename)[1]
    -- 解析命名参数
    -- local named_values = utilities.parsers.settings_to_hash(keyvals)

    context("\\footnote[%s]{\\getbuffer[%s]:%s.}",uniquename_option,buf_option,page_option)

end

--[[
local getdata = job.datasets.getdata

local me_rp
local d = 1
while getdata("footnotetable", d) do
    if (un == getdata("footnotetable", d, "un")) then
        me_rp = getdata("footnotetable", d, "realpage")
        break
    end
    d = d + 1
end


local first_un
local d = 1
while getdata("footnotetable", d) do
    if (bf_name == getdata("footnotetable", d, "bf")) and
        me_rp == getdata("footnotetable", d, "realpage") then
        first_un = getdata("footnotetable", d, "un")
        break
    end
    d = d + 1
end
context(first_un)
--]]
\stopluacode

