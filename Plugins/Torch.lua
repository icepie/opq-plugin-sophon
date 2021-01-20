local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    if (string.find(data.Content, "开灯") == 1) then
        --log.notice("From Lua data.FromGroupId %d", data.FromGroupId)

        luaRes =
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = "已为您打开啦, mua~",
                atUser = 0
            }
        )
        os.execute("termux-torch on");
        log.notice("From Lua SendMsg Ret-->%d", luaRes.Ret)
    elseif (string.find(data.Content, "关灯") == 1) then
        --log.notice("From Lua data.FromGroupId %d", data.FromGroupId)

        luaRes =
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = "已为您关闭啦, mua~",
                atUser = 0
            }
        )
        os.execute("termux-torch off");
        log.notice("From Lua SendMsg Ret-->%d", luaRes.Ret)
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end