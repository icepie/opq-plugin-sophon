local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
local os = require("os")

function ReceiveFriendMsg(CurrentQQ, data)
    return
end

function ReadAll(filePath)
    local f, err = io.open(filePath, "rb")
    if err ~= nil then
        return nil
    end
    local content = f:read("*all")
    f:close()
    return content
end

function ReceiveGroupMsg(CurrentQQ, data)
    if (string.find(data.Content, "色图") == 1) then
        --log.notice("From Lua data.FromGroupId %d", data.FromGroupId)
        luaRes =
            Api.Api_SendMsg(--调用发消息的接口
            CurrentQQ,
            {
                toUser = data.FromGroupId, --回复当前消息的来源群ID
                sendToType = 2, --2发送给群1发送给好友3私聊
                sendMsgType = "PicMsg", --进行文本复读回复
                                content = string.format("嘘~"),
                                picUrl = "http://funny.wongxy.com/xxoo",
                                picBase64Buf = "",
                                fileMd5 = ""
            }
        )
        log.notice("From Lua SendMsg Ret-->%d", luaRes.Ret)
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end
