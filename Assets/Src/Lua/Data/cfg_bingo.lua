
---@class cfg_bingo
___cfg_bingo = 
{
	id = 1,
	des = '安康鱼',
	icon = 'ui://Fish/BossAKY',
	isMoveCom = 0,
	baseCom = 'BingoBaseCom',
	baseController = 'base',
	baseSelectPage = 0,
	isScale = 1,
	isShowSum = 1,
	sumCom = 'BingoNumItem',
	sumController = 'c1',
	sumSelectPage = 2,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 0
}

---@field public instance cfg_bingo
---@type table<string,cfg_bingo>
cfg_bingo =  {
instance = function(key)
    return cfg_bingo[key]
end,

    [1] = 
{
	id = 1,
	des = '安康鱼',
	icon = 'ui://Fish/BossAKY',
	isMoveCom = 0,
	baseCom = 'BingoBaseCom',
	baseController = 'base',
	baseSelectPage = 0,
	isScale = 1,
	isShowSum = 1,
	sumCom = 'BingoNumItem',
	sumController = 'c1',
	sumSelectPage = 2,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 0
},

    [2] = 
{
	id = 2,
	des = '鳄鱼',
	icon = 'ui://Fish/BossEY',
	isMoveCom = 0,
	baseCom = 'BingoBaseCom',
	baseController = 'base',
	baseSelectPage = 1,
	isScale = 1,
	isShowSum = 1,
	sumCom = 'BingoNumItem',
	sumController = 'c1',
	sumSelectPage = 2,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 0
},

    [3] = 
{
	id = 3,
	des = '章鱼',
	icon = 'ui://Fish/BossZY',
	isMoveCom = 0,
	baseCom = 'BingoBaseCom',
	baseController = 'base',
	baseSelectPage = 2,
	isScale = 1,
	isShowSum = 0,
	sumCom = '',
	sumController = '',
	sumSelectPage = 0,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 0
},

    [11] = 
{
	id = 11,
	des = '炸弹螃蟹',
	icon = 'ui://Fish/SerialBoomItem',
	isMoveCom = 1,
	baseCom = 'CannonItem',
	baseController = 'crab',
	baseSelectPage = 0,
	isScale = 0,
	isShowSum = 1,
	sumCom = 'BingoNumItem',
	sumController = 'c1',
	sumSelectPage = 0,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 0
},

    [12] = 
{
	id = 12,
	des = '钻头螃蟹',
	icon = 'ui://Fish/Cannon_101',
	isMoveCom = 0,
	baseCom = 'CannonItem',
	baseController = 'crab',
	baseSelectPage = 1,
	isScale = 0,
	isShowSum = 1,
	sumCom = 'BingoNumItem',
	sumController = 'c1',
	sumSelectPage = 1,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 0
},

    [13] = 
{
	id = 13,
	des = '锤子螃蟹',
	icon = 'ui://Fish/HammerItem',
	isMoveCom = 1,
	baseCom = 'CannonItem',
	baseController = 'crab',
	baseSelectPage = 2,
	isScale = 0,
	isShowSum = 0,
	sumCom = '',
	sumController = '',
	sumSelectPage = 0,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 0
},

    [14] = 
{
	id = 14,
	des = '电磁炮螃蟹',
	icon = 'ui://Fish/Cannon_100',
	isMoveCom = 0,
	baseCom = 'CannonItem',
	baseController = 'crab',
	baseSelectPage = 3,
	isScale = 0,
	isShowSum = 0,
	sumCom = '',
	sumController = '',
	sumSelectPage = 0,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 0
},

    [21] = 
{
	id = 21,
	des = '旋风鱼',
	icon = 'ui://Fish/Whirlwind',
	isMoveCom = 0,
	baseCom = 'CannonItem',
	baseController = 'crab',
	baseSelectPage = 4,
	isScale = 0,
	isShowSum = 0,
	sumCom = '',
	sumController = '',
	sumSelectPage = 0,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 1
},

    [5] = 
{
	id = 5,
	des = '雷龙',
	icon = 'ui://Fish/DragonBingoItem',
	isMoveCom = 0,
	baseCom = 'BingoBaseCom',
	baseController = 'base',
	baseSelectPage = 3,
	isScale = 1,
	isShowSum = 0,
	sumCom = '',
	sumController = '',
	sumSelectPage = 0,
	finalCom = 'FinalScore',
	finalController = 'final',
	finalSelectPage = 0
},


}

return cfg_bingo