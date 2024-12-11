
\startluacode

-- 定义lua函数，存储在给用户分配的userdata中
userdata = userdata or { }
function userdata.basefootnote(buf, page, uniquename)
    local getdata = job.datasets.getdata
    local setdata = job.datasets.setdata
    -- 解析位置参数
    local buf_option = utilities.parsers.settings_to_array(buf)[1]
    local page_option = utilities.parsers.settings_to_array(page)[1]
    -- 解析命名参数
    -- local named_values = utilities.parsers.settings_to_hash(keyvals)
    --context("\\setdataset[footnotetable][%s][buf={%s},page={%s}]",uniquename,buf_option,page_option)
    setdata {
        name  = "footnotetable",
        tag   = uniquename,
        data  = {
            ["uniquename"]=99999,
        }
    }


    -- 找到自己的真实页码
    local current_realpage
    local current_order
    local i = 1
    while getdata("footnotetable", i) do
        if (uniquename == getdata("footnotetable", i, "uniquename"))
            and getdata("footnotetable", i, "realpage") then
                current_realpage = getdata("footnotetable", i, "realpage")
                current_order = getdata("footnotetable", i, "order")
                -- 找到本页第一个同源注释
                local n = 1
                while getdata("footnotetable", n) do
                    if (buf == getdata("footnotetable", n, "buf"))
                        and current_realpage == getdata("footnotetable", n, "realpage")
                        and current_order > getdata("footnotetable", n, "order") then
                            local firstre = getdata("footnotetable", n, "uniquename")
                            context("\\setdataset[footnotetable][%s][buf={%s},page={%s},firstre={%s}]",uniquename,buf_option,page_option,firstre)
                            context("\\footnote{同[\\in{}{}[%s]]%s.}",firstre,page_option)
                        break
                    end
                    n = n + 1
                end
            break
        else
            context("\\setdataset[footnotetable][%s][buf={%s},page={%s}]",uniquename,buf_option,page_option)
            context("\\footnote[%s]{\\getbuffer[%s]\\unskip:%s.}",uniquename,buf_option,page_option)
        end
        i = i + 1
    end

    -- \setdataset[footnotetable][buf={#1},page={#2},uniquename={\uniquename}]

end



--[[
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

