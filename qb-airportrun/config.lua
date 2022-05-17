print("qb-airportrun v1 - Do You See Me If So its Working")
Config = Config or {}

Config.ItemTiers = 1

Config.Timer = 60 -- in seconds

--33% on each to get money/an item or nothing
Config.RewardTypes = {
    [1] = {
        type = "item"
    },
    [2] = {
        type = "money",
    },
    [3] = {
        type = "nothing",
    }
}

--rewards for searching
Config.RewardsSmall = {
    [1] = {item = "samsungphone", minAmount = 1, maxAmount = 2},
    [2] = {item = "tablet", minAmount = 1, maxAmount = 2},
    [3] = {item = "fitbit", minAmount = 1, maxAmount = 2},
    [4] = {item = "lighter", minAmount = 1, maxAmount = 1},
    [5] = {item = "airpods", minAmount = 1, maxAmount = 1},
    [6] = {item = "joint", minAmount = 1, maxAmount = 2},
    [7] = {item = "plastic", minAmount = 1, maxAmount = 3},
}

Config.Objects = {
    -- CargoBins -- Feel Free to Add More Props Below But Make Sure you dont forget your Comma , otherwise your break it :)
    `prop_air_cargo_01a`,
    `prop_air_cargo_01b`,
    `prop_air_cargo_01c`,
    `prop_air_cargo_02a`,
    `prop_air_cargo_02b`,
    `prop_air_cargo_04a`,
    `prop_air_trailer_1a`,
    `prop_air_trailer_1b`,
    `prop_air_trailer_1c`


}
