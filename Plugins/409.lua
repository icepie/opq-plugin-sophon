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
    if (string.find(data.Content, "409状况") == 1) then
        --log.notice("From Lua data.FromGroupId %d", data.FromGroupId)
        local t = io.popen('termux-camera-photo -c 1 ./Plugins/test.jpeg')
        local a = t:read("*all")
        TimePath = string.format("./Plugins/%s.jpeg", 'test')
        print(TimePath)
        --拼接文件路径
        res = ReadAll(TimePath)
        --读入文件
        base64 = PkgCodec.EncodeBase64(res)
        luaRes0 =
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = "在发啦~稍等mua",
                atUser = 0
            }
        )
        log.notice("From Lua SendMsg Ret-->%d", luaRes0.Ret)
        luaRes =
            Api.Api_SendMsg(--调用发消息的接口
            CurrentQQ,
            {
                toUser = data.FromGroupId, --回复当前消息的来源群ID
                sendToType = 2, --2发送给群1发送给好友3私聊
                sendMsgType = "PicMsg", --进行文本复读回复
                                content = string.format("是C1-409哒~"),
                                picUrl = "",
                                picBase64Buf = base64,
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
