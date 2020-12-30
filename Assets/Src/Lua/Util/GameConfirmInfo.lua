---@class ConfirmTipInfo
---@field New ConfirmTipInfo
ConfirmTipInfo = class("QuitTipInfo")

ConfirmTipInfo.Left = 1
ConfirmTipInfo.Middle = 2
ConfirmTipInfo.Right = 4

ConfirmTipInfo.LeftRight = bit.bor(ConfirmTipInfo.Left, ConfirmTipInfo.Right)
ConfirmTipInfo.LeftMiddleRight = bit.bor(ConfirmTipInfo.Left, ConfirmTipInfo.Right, ConfirmTipInfo.Middle)

function ConfirmTipInfo:ctor()
    self.content = nil

    --- > 0 则显示倒计时
    self.autoCloseTime = 10
    ---左中右分别为 1，2，4， 默认为LeftRight
    self.state = ConfirmTipInfo.LeftRight

    self.leftClick = nil
    self.middleClick = nil
    self.rightClick = nil

    self.middleTxt = "确定"
    self.leftTxt = "取消"
    self.rightTxt = "确定"
end


