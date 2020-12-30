----@type HTTPRequest
local HTTPRequest = BestHTTP.HTTPRequest
---@type HTTPResponse
local HTTPResponse = BestHTTP.HTTPResponse
---@type HTTPMethods
local HTTPMethods = BestHTTP.HTTPMethods
---@type Uri
local Uri = System.Uri

local JSON = require 'cjson'
local decode = JSON.decode

local ApiDomain = "https://api-unity.qzygxt.com"

---@class ApiManager
---@field public instance ApiManager
ApiManager = class("ApiManager")

function ApiManager:ctor()
end

---@private
---@param url string
---@param body table
---@param method function
---@return HTTPRequest
function ApiManager:BaseHttp(url, body, method)
    method = method or HTTPMethods.Get
    body = body or {}
    url = url or ""

    if method == HTTPMethods.Get then
        local filed = nil
        for k, v in pairs(body) do
            filed = filed == nil and "?" .. tostring(k) .. "=" .. tostring(v) or "&" .. tostring(k) .. "=" .. tostring(v)
            url = url .. filed
        end
    end

    ---@type Uri
    local requestUrl = Uri(url)
    ---@type HTTPRequest
    local httpRequest = HTTPRequest(requestUrl, method)

    if method == HTTPMethods.Post then
        for k, v in pairs(body) do
            httpRequest:AddField(k, v)
        end
    end
    httpRequest:Send()
    return httpRequest
end

---@private
---@param httpRequest HTTPRequest
---@param caller table
---@param callback function
---@return void
function ApiManager:OnRequestCallBack(httpRequest, caller, callback)
    httpRequest.Callback = function(request, response)
        local response_body = response.DataAsText
        Log.debug("【ApiManager RequestCallBack】:", #response_body, response_body)
        local data = decode(response_body)
        if (caller ~= nil) then
            callback(caller, data)
        else
            callback(data)
        end
    end
end

---@public
---@param username string
---@param caller table
---@param callback function
---@return void
function ApiManager:ThirdLogin(username, caller, callback)
    local url = ApiDomain .. "/collect/user/third_login"
    local body = {
        third_part_token = username,
        GAME_TYPE_OVERHEAD = 2
    }

    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Post)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

---@public
---@param username string
---@param password string
---@param caller table
---@param callback function
---@return void
function ApiManager:UnityLogin(username, password, caller, callback)
    local url = ApiDomain .. "/foreign/user_login"
    local body = {
        username = username,
        password = password
    }

    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Post)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

---@public
---@param username string
---@param password string
---@param caller table
---@param callback function
---@return void
function ApiManager:UnityRegister(username, password, confirm_password, truename, idcard, phone, sms_code, caller, callback)
    local url = ApiDomain .. "/foreign/user_register"
    local body = {
        username = username,
        password = password,
        confirm_password = confirm_password,
        truename = truename,
        idcard = idcard,
        phone = phone,
        sms_code = sms_code,
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Post)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

---@public
---@param coin_type string
---@param caller table
---@param callback function
---@return void
function ApiManager:ExchangeList(coin_type, caller, callback)
    local url = ApiDomain .. "/collect/exchange_item"
    local body = {
        coin_type = coin_type,
    }

    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Get)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

---@public
---@param access_token string
---@param coin_type string
---@param caller table
---@param callback function
---@return void
function ApiManager:ExchangeRecords(access_token, coin_type, caller, callback)
    local url = ApiDomain .. "/collect/exchange_record"
    local body = {
        access_token = access_token,
        coin_type = coin_type,
    }

    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Post)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

---@public
---@param token string
---@param caller table
---@param callback function
---@return void
function ApiManager:Get_Rank_List(token, caller, callback)
    local url = ApiDomain .. "/collect/top"
    local body = {
        access_token = token,
    }

    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Post)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

function ApiManager:QueryUserName(access_token, uid, caller, callback)
    local url = ApiDomain .. "/collect/find_user"
    local body = {
        access_token = access_token,
        uid = uid
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Post)
    self:OnRequestCallBack(httpRequest, caller, callback)

end

function ApiManager:giftList(access_token, page, caller, callback)
    local url = ApiDomain .. "/collect/send_list"
    local body = {
        access_token = access_token,
        page = page
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Get)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

function ApiManager:GetNotReceiveReward(access_token, caller, callback)
    local url = ApiDomain .. "/contest/get_not_receive_reward"
    local body = {
        access_token = access_token,
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Get)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

function ApiManager:GetMatchList(access_token, caller, callback)
    local url = ApiDomain .. "/contest/get_contest_user"
    local body = {
        access_token = access_token,
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Get)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

function ApiManager:GetContestDailyRankList(access_token, contest_id, caller, callback)
    local url = ApiDomain .. "/contest/daily_top"
    local body = {
        access_token = access_token,
        contest_id = contest_id,
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Get)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

function ApiManager:GetAnnounce(type, caller, callback)
    local url = ApiDomain .. "/foreign/collect/announce_v2"
    local body = {
        type = type,
        server_name = 0,
        provider_id = -1,
        key = "unity"
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Post)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

function ApiManager:GetFeedBack(access_token, content, caller, callback)
    local url = ApiDomain .. "/feedback";
    local body = {
        access_token = access_token,
        content = content,
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Post)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

function ApiManager:SaveUserInfo(access_token, nickname, avatar, caller, callback)
    local url = ApiDomain .. "/foreign/save_user_info";
    local body = {
        access_token = access_token,
        nickname = nickname,
        avatar = avatar,
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Post)
    self:OnRequestCallBack(httpRequest, caller, callback)
end

function ApiManager:GetVersionList(access_token, platform, caller, callback)
    local url = ApiDomain .. "/foreign/version_list";
    local body = {
        access_token = access_token,
        platform = platform,
    }
    local httpRequest = self:BaseHttp(url, body, HTTPMethods.Get)
    self:OnRequestCallBack(httpRequest, caller, callback)
end