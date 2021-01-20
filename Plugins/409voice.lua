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
    if (string.find(data.Content, "409之声") == 1) then
        keyWord = data.Content:gsub("409之声", "")
        if keyWord == nil then
            return 1
        end
        --log.notice("From Lua data.FromGroupId %d", data.FromGroupId)

        luaRes0 =
        Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = "在发啦~" .. keyWord .."秒哦～一会哈",
                atUser = 0
            }
        )
        log.notice("From Lua SendMsg Ret-->%d", luaRes0.Ret)
        local t = io.popen('bash vc.sh' .. ' ' .. keyWord)
        local a = t:read("*all")
        TimePath = string.format("./Plugins/%s.silk", 'test')
        print(TimePath) 
        --拼接文件路径
        res = ReadAll(TimePath)
        --读入文件
        base64 = PkgCodec.EncodeBase64(res)
        luaRes =
            Api.Api_SendMsg(--调用发消息的接口
            CurrentQQ,
            {
				toUser = data.FromGroupId,
				sendToType = 2,
				sendMsgType = "VoiceMsg",
				groupid = 0,
				content = "",
				atUser = 0,
				voiceUrl = "", --将回复的文字转成语音并听过网络Url方式发送回复语音
				voiceBase64Buf = base64,
				picUrl = "",
				picBase64Buf = ""
            }
        )
        log.notice("From Lua SendMsg Ret-->%d", luaRes.Ret)
        
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data, extData)
    return 1
end