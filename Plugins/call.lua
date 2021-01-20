local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
local os = require("os")

function ReceiveFriendMsg(CurrentQQ, data)
    return 1
end
function ReceiveGroupMsg(CurrentQQ, data)
    if string.find(data.Content, "呼叫") == 1 then
        keyWord = data.Content:gsub("呼叫", "")
        if keyWord == nil then
            return 1
        end
        voiceUrl = "https://dds.dui.ai/runtime/v1/synthesize?voiceId=qianranfa&speed=0.8&volume=100&audioType=wav&text=111"
        print(voiceUrl)
        --log.notice("From Lua data.FromGroupId %d", data.FromGroupId)
        local t = io.popen('bash tts.sh' .. ' ' .. keyWord)
        local a = t:read("*all")
        local tbs = "mua"
        luaRes =
            Api.Api_SendMsg(
            CurrentQQ,
            {
                toUser = data.FromGroupId,
                sendToType = 2,
                sendMsgType = "TextMsg",
                groupid = 0,
                content = "已语音呼唤409的gay友们啦!",
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