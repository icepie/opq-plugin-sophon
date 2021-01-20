local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    if (string.find(data.Content, "#tasklist") == 1) then
        --log.notice("From Lua data.FromGroupId %d", data.FromGroupId)

        task=Api.Api_GetCrons()
        str = string.format("Ret %d Crons %s",task.Ret, task.Crons)
        log.info("Api_GetCrons %s", str)

        luaRes =
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = str,
                atUser = 0
            }
        )
        log.notice("From Lua SendMsg Ret-->%d", luaRes.Ret)
    elseif (string.find(data.Content, "#taskadd") == 1) then
        --log.notice("From Lua data.FromGroupId %d", data.FromGroupId)
            Api.Api_AddCrons(
            {
                QQ = CurrentQQ,
                Sepc = "0 0/1 * * * ? ",
                FileName = "CronDemo1.lua",
                FuncName = "NcovReport"
            }
        )
        luaRes =
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = "已添加",
                atUser = 0
            }
        )
        log.notice("From Lua SendMsg Ret-->%d", luaRes.Ret)
    elseif (string.find(data.Content, "#taskdel") == 1) then
        Api.Api_DelCrons(6)--传入任务整数
        str = string.format("Ret %d Msg %s",task.Ret, task.Msg)
        luaRes =
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = str,
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