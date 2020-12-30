---@class QuitTipInfo
QuitTipInfo = class("QuitTipInfo")



function QuitTipInfo:ctor()

    self.content = nil

    --- > 0 则显示倒计时
    self.autoCloseTime = 10
    ---左中右分别为 1，2，4，
    self.state = 0

    self.leftClick = nil
    self.middleClick = nil
    self.rightClick = nil

    self.middleTxt = "确定"
    self.leftTxt = "取消"
    self.rightTxt = "确定"
end