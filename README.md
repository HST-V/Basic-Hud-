# Basic-Hud-
Basic Hud for esx. Simply Displays the players Bank, Money, Black Money and server ID in the top right.
download the zip, extract the folder hud and place in your resources folder. next add ensure hud to your server.cfg
the hud can be enabled and disabled with the command /hud
the config is editable and is as follows:

Config = {}

Config.DefaultVisible = true -- Is the HUD visible by default when logging in?

Config.TextSettings = {
    fontSize = "24px", -- Size of the HUD text (supports px, rem, em)
    fontFamily = "Arial, sans-serif", -- Font family used for the numbers
    fontWeight = "700", -- Weight of the text (700 is bold)
}

Config.Colors = {
    bank = "#1a73e8",       -- Blue for bank account
    cash = "#2e7d32",       -- Green for cash money
    blackMoney = "#c62828", -- Red for dirty/black money
    serverId = "#ffffff"    -- White for Server ID
}
