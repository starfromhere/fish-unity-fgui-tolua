local _M = {}
local sender = WebSocketManager.instance
--setmetatable(sender, {
--    --TODO
--    __index = function (k,v)
--        print("Send show k, v  =======>> ", k, v)
--        if v == "Send" or v == "send" then
--            return WebSocketManager.instance
--        end
--    end})

--提示钻石代替道具
function _M.DiamondToGoods(info)
    sender:Send(10012, info)
end
--心跳
function _M.HeartBeat(info)
    sender:Send(11001, info)
end
--进入普通渔场
function _M.EnterRoom(info)
    sender:Send(12001, info)
end
--离开普通渔场
function _M.ExitRoom(info)
    sender:Send(12003, info)
end
--发射子弹
function _M.Shoot(info)
    sender:Send(12014, info)
end
--快速进入房间
function _M.QuickEnterRoom(info)
    sender:Send(12024, info)
end
--请求受击协议
function _M.BeHit(info)
    sender:Send(12035, info)
end
--同步服务端rick
function _M.SyncTick(info)
    sender:Send(12039, info)
end
--进入比赛场
function _M.EnterMatchRoom(info)
    sender:Send(12051, info)
end
--离开挑战赛
function _M.ExitChallengeRoom(info)
    sender:Send(12057, info)
end
--准备匹配赛
function _M.ReadyMatchRoom(info)
    sender:Send(12101, info)
end
--开始匹配赛
function _M.StartMatchRoom(info)
    sender:Send(12104, info)
end
--查询匹配赛
function _M.FindMatchRoom(info)
    sender:Send(12110, info)
end
--继续匹配赛
function _M.ContinueMatchRoom(info)
    sender:Send(12112, info)
end
--炸弹鱼
function _M.BombFish(info)
    sender:Send(12120, info)
end
--移除鱼
function _M.MoveOutFish(info)
    sender:Send(12122, info)
end
--BOSS觉醒后阶段碰撞
function _M.BossLastCollision(info)
    sender:Send(12130, info)
end
--解锁炮台
function _M.UnlockBattery(info)
    sender:Send(13001, info)
end
--改变炮的皮肤和倍数
function _M.ChangeBatterySkin(info)
    sender:Send(13003, info)
end
--改变命中率和是否双倍金币
function _M.ChangeDoubleGoldOrRate(info)
    sender:Send(13007, info)
end
--解锁命中率和是否双倍金币
function _M.UnlockDoubleGoldOrRate(info)
    sender:Send(13009, info)
end
--购买商品
function _M.Buy(info)
    sender:Send(14000, info)
end
--获取首充奖励
function _M.GetFirstChargeReward(info)
    sender:Send(14002, info)
end
--月卡每日奖励
function _M.MonthCardDailyReward(info)
    sender:Send(14006, info)
end
--商品兑换todo
function _M.GoodExchange(info)
    sender:Send(14014, info)
end
--赠送礼物
function _M.SendGift(info)
    sender:Send(14017, info)
end
--接受礼物
function _M.ReceiveGift(info)
    sender:Send(14019, info)
end
--接受礼物
function _M.UseGoods(info)
    sender:Send(14028, info)
end
--红包兑换类型 支付宝或者微信
function _M.ChangeRedPackageType(info)
    sender:Send(14070, info)
end
--鱼币抽奖
function _M.FishLottery(info)
    sender:Send(15001, info)
end
--获取抽奖记录
function _M.LotteryList(info)
    sender:Send(15003, info)
end
--使用技能
function _M.UseSkill(info)
    sender:Send(17001, info)
end

--请求服务端清除红点
function _M.ClearRedPoint(info)
    sender:Send(19007, info)
end
--红包任务数据
function _M.RedPackageTaskInfo(info)
    sender:Send(19009, info)
end
--获得红包任务奖励
function _M.RedPackageTaskReward(info)
    sender:Send(19011, info)
end
--生成公众号红包绑定码
function _M.CreateWxBindCode(info)
    sender:Send(19014, info)
end
--领取任务进度奖励
function _M.GetTaskReward(info)
    sender:Send(19051, info)
end
--领取任务完成奖励
function _M.GetTaskFinishedReward(info)
    sender:Send(19053, info)
end
--领取任务完成奖励
function _M.Lottery(info)
    sender:Send(19061, info)
end
--获取签到信息
function _M.GetSignInInfo(info)
    sender:Send(20000, info)
end
--领取签到奖励
function _M.GetSignInReward(info)
    sender:Send(20002, info)
end
--获取在线奖励信息
function _M.GetOnlineReward(info)
    sender:Send(22000, info)
end
--查询在线奖励信息
function _M.OnlineReward(info)
    sender:Send(22002, info)
end
--获取奖金池总奖励
function _M.PoolReward(info)
    sender:Send(30002, info)
end
--活动状态
function _M.ActivityStatus(info)
    sender:Send(32002, info)
end
--存入银行 存钱
function _M.SaveMoney(info)
    sender:Send(33002, info)
end
--取钱
function _M.WithdrawMoney(info)
    sender:Send(33004, info)
end
--获取玩家银行信息
function _M.GetBankInfo(info)
    sender:Send(33012, info)
end
--发送验证码
function _M.SendMobileCode(info)
    sender:Send(33014, info)
end
--绑定银行
function _M.BindBank(info)
    sender:Send(33020, info)
end
--挑战赛奖励获取
function _M.ChallengeMatchReward(info)
    sender:Send(35002, info)
end
--日常赛奖励获取
function _M.DailyMatchReward(info)
    sender:Send(35005, info)
end
--兑换礼包码
function _M.GiftCodeConfirm(info)
    sender:Send(39000, info)
end
--获取排行版奖励
function _M.GetRankReward(info)
    sender:Send(42001, info)
end
--进行实名认证
function _M.Certification(info)
    sender:Send(60001, info)
end
--实名认证次数计数
function _M.CountCertification(info)
    sender:Send(60003, info)
end
--获取玩家升级奖励
function _M.LevelUpReward(info)
    sender:Send(60004, info)
end

--TODO global
NetSender = _M
return _M