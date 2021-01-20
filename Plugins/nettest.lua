local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
local os = require("os")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    if (string.find(data.Content, "409测速") == 1) then
        --log.notice("From Lua data.FromGroupId %d", data.FromGroupId)
        luaRes =
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = "正在测试网速熬, 请稍等片刻(使用speedtest)",
                atUser = 0
            }
        )
        local t = io.popen('python speedtest.py')
        local a = t:read("*all")
        luaRes =
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = string.format( "WIFI(C1-409-ICEPIE)：\n%s",a),
                atUser = 0
            }
        )
        log.notice("From Lua SendMsg Ret-->%d", luaRes.Ret)
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end