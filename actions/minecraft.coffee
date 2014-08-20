crypto = require("crypto")
request = require("request")
Minecraft = module.exports = (options) ->
  defaults =
    host: "localhost"
    port: 20059

  @_ = options or {}
  for i of defaults
    @_[i] = defaults[i]  unless @_[i]
  return

Minecraft::generateUrl = (method, args) ->
  key = @generateKey(method)
  url = "http://" + @_.host + ":" + @_.port + "/api/call" + "?method=" + method + "&key=" + key + "&tag=null"
  if args
    args = [args]  unless typeof args is "object"
    url += "&args=" + escape(JSON.stringify(args))
  url

Minecraft::generateKey = (method) ->
  crypto.createHash("sha256").update(@_.user + method + @_.pass + @_.salt).digest "hex"

Minecraft::call = (method, args, cb) ->
  if typeof args is "function"
    cb = args
    args = `undefined`
  url = @generateUrl(method, args)
  request url, (err, res, body) ->
    try
      body = JSON.parse(body)
    catch e
      console.log "Could not parse: " + body
    cb err, body and body[body.result] or body  if cb
    return

  return

commands = [
  "addEnchantmentToPlayerInventorySlot"
  "addEnchantmentsToPlayerInventorySlot"
  "addToWhitelist"
  "appendToFile"
  "ban"
  "banIP"
  "banWithReason"
  "broadcast"
  "broadcastWithName"
  "clearPlayerInventorySlot"
  "deopPlayer"
  "disablePlugin"
  "disablePlugins"
  "editPropertiesFile"
  "enablePlugin"
  "getBannedIPs"
  "getBannedPlayers"
  "getBinaryFileBase64"
  "getBlock"
  "getBukkitVersion"
  "getDirectory"
  "getFileContents"
  "getLatestChats"
  "getLatestChatsWithLimit"
  "getLatestConnections"
  "getLatestConnectionsWithLimit"
  "getLatestConsoleLogs"
  "getLatestConsoleLogsWithLimit"
  "getOfflinePlayer"
  "getOfflinePlayerNames"
  "getOfflinePlayers"
  "getPlayer"
  "getPlayerCount"
  "getPlayerLimit"
  "getPlayerNames"
  "getPlayers"
  "getPlugin"
  "getPluginFiles"
  "getPluginVersion"
  "getPlugins"
  "getPropertiesFile"
  "getServer"
  "getServerIp"
  "getServerPort"
  "getServerVersion"
  "getSingleDirectory"
  "getStream"
  "getStreamWithLimit"
  "getWhitelist"
  "getWorld"
  "getWorlds"
  "givePlayerItem"
  "givePlayerItemDrop"
  "givePlayerItemDropWithData"
  "givePlayerItemWithData"
  "kickPlayer"
  "opPlayer"
  "reloadServer"
  "removeEnchantmentsFromPlayerInventorySlot"
  "removeFromWhitelist"
  "removePlayerInventoryItem"
  "runConsoleCommand"
  "saveMap"
  "saveOff"
  "saveOn"
  "sendMessage"
  "setBlockData"
  "setBlockType"
  "setFileBinaryBase64"
  "setFileContents"
  "setPlayerExperience"
  "setPlayerFoodLevel"
  "setPlayerGameMode"
  "setPlayerHealth"
  "setPlayerInventorySlot"
  "setPlayerInventorySlotWithDamage"
  "setPlayerInventorySlotWithData"
  "setPlayerInventorySlotWithDataAndDamage"
  "setPlayerInventorySlotWithDataDamageAndEnchantments"
  "setPlayerLevel"
  "setWorldTime"
  "teleport"
  "teleportPlayerToLocation"
  "teleportPlayerToWorldLocation"
  "unban"
  "unbanIP"
  "updatePlayerInventorySlot"
]
commands.forEach (command) ->
  Minecraft::[command] = (args, cb) ->
    @call command, args, cb
    return

  return
