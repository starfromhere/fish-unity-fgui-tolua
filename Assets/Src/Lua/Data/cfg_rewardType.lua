
---@class cfg_rewardType
___cfg_rewardType = 
{
	id = 'common',
	firstId = '101',
	secondId = '102',
	threeId = '103',
	fourId = '104',
	fiveId = '105',
	sixId = '106'
}

---@field public instance cfg_rewardType
---@type table<string,cfg_rewardType>
cfg_rewardType =  {
instance = function(key)
    return cfg_rewardType[key]
end,

    ["common"] = 
{
	id = 'common',
	firstId = '101',
	secondId = '102',
	threeId = '103',
	fourId = '104',
	fiveId = '105',
	sixId = '106'
},

    ["bronze"] = 
{
	id = 'bronze',
	firstId = '201',
	secondId = '202',
	threeId = '203',
	fourId = '204',
	fiveId = '205',
	sixId = '206'
},

    ["silver"] = 
{
	id = 'silver',
	firstId = '301',
	secondId = '302',
	threeId = '303',
	fourId = '304',
	fiveId = '305',
	sixId = '306'
},

    ["gold"] = 
{
	id = 'gold',
	firstId = '401',
	secondId = '402',
	threeId = '403',
	fourId = '404',
	fiveId = '405',
	sixId = '406'
},

    ["platina"] = 
{
	id = 'platina',
	firstId = '501',
	secondId = '502',
	threeId = '503',
	fourId = '504',
	fiveId = '505',
	sixId = '506'
},

    ["extreme"] = 
{
	id = 'extreme',
	firstId = '601',
	secondId = '602',
	threeId = '603',
	fourId = '604',
	fiveId = '605',
	sixId = '606'
},


}

return cfg_rewardType