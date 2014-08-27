crypto = require("crypto")
request = require("request")
debug = require('debug')('Minecraft');

class Minecraft 
  constructor: (@options = {}) ->
    defaults =
      host: "localhost"
      port: 20059

    for i of defaults
      @options[i] = defaults[i]  unless @options[i]

    @key_cache = []

  generateUrl: (method, args = [], tag) ->
    key = @generateKey(method)
    json = 
      "name": method
      "key": @generateKey(method)
      "username": @options.user
      "arguments": args
    json["tag"] = tag if tag?

    url = "http://#{@options.host}:#{@options.port}/api/2/call?json=#{escape(JSON.stringify(json))}"

  generateKey: (method) ->
    if @key_cache[method]?
      return @key_cache[method]

    @key_cache[method] = crypto.createHash("sha256").update(@options.user + method + @options.pass).digest "hex"

  call: (method, args, cb, tag) ->
    if typeof args is "function"
      cb = args
      args = null
    url = @generateUrl(method, args, tag)
    debug url
    request url, (err, res, body) ->
      try
        body = JSON.parse(body)
        body = body[0] if body.length == 1 and typeof body is 'object'
      catch e
        debug "Could not parse: #{body}"

      cb err, body and body[body.result] or body if cb
      return

    @



[
  'chat.broadcast'
  'chat.enabled'
  'chat.groups'
  'chat.with_name'
  'dynmap.host'
  'dynmap.port'
  'economy.bank.has_support'
  'economy.banks.name.balance'
  'economy.banks.name.delete'
  'economy.banks.name.deposit'
  'economy.banks.name.has'
  'economy.banks.name.is_member'
  'economy.banks.name.is_owner'
  'economy.banks.name.withdraw'
  'economy.banks.names'
  'economy.currency.format'
  'economy.currency.name'
  'economy.currency.name_plural'
  'economy.is_enabled'
  'economy.name'
  'essentials.config.get_keys'
  'essentials.config.get_text'
  'essentials.config.get_value'
  'essentials.config.restore_default'
  'essentials.config.set_value'
  'essentials.reload'
  'essentials.users.add_mail'
  'essentials.users.add_mail_all'
  'essentials.users.burn'
  'essentials.users.clear_all_powertools'
  'essentials.users.clear_inventory'
  'essentials.users.clear_nick'
  'essentials.users.fly'
  'essentials.users.get_base'
  'essentials.users.get_pos'
  'essentials.users.get_uuid'
  'essentials.users.heal'
  'essentials.users.player_get_all'
  'essentials.users.seen'
  'essentials.users.set_afk'
  'essentials.users.set_nick'
  'essentials.users.toggle_god'
  'essentials.users.tp_back'
  'essentials.users.vanish'
  'files.append'
  'files.copy'
  'files.create'
  'files.create_folder'
  'files.delete'
  'files.list_directory'
  'files.move'
  'files.read'
  'files.read_binary'
  'files.write'
  'files.write_binary'
  'groups.all'
  'groups.group.players'
  'jsonapi.groups'
  'jsonapi.groups.add'
  'jsonapi.groups.group.methods.add'
  'jsonapi.groups.group.methods.remove'
  'jsonapi.groups.group.permissions.add'
  'jsonapi.groups.group.permissions.remove'
  'jsonapi.groups.group.streams.add'
  'jsonapi.groups.group.streams.remove'
  'jsonapi.groups.name'
  'jsonapi.groups.name.set'
  'jsonapi.groups.names'
  'jsonapi.groups.remove'
  'jsonapi.methods'
  'jsonapi.methods.all'
  'jsonapi.methods.all.for_namespace'
  'jsonapi.methods.all.namespaces'
  'jsonapi.permissions'
  'jsonapi.streams'
  'jsonapi.users'
  'jsonapi.users.add'
  'jsonapi.users.remove'
  'jsonapi.users.user.groups.add'
  'jsonapi.users.user.groups.remove'
  'jsonapi.users.user.methods'
  'jsonapi.users.user.password.set'
  'jsonapi.users.user.permissions'
  'jsonapi.users.user.streams'
  'jsonapi.users.username'
  'jsonapi.users.usernames'
  'permissions.all'
  'players.ban_ip'
  'players.banned.names'
  'players.banned_ips'
  'players.name'
  'players.name.ban'
  'players.name.bank.balance'
  'players.name.bank.create'
  'players.name.bank.create_account'
  'players.name.bank.deposit'
  'players.name.bank.has'
  'players.name.bank.has_account'
  'players.name.bank.withdraw'
  'players.name.deop'
  'players.name.drop_item'
  'players.name.groups'
  'players.name.groups.add'
  'players.name.groups.remove'
  'players.name.inventory.give_item'
  'players.name.inventory.remove_item'
  'players.name.inventory.slots.slot.clear'
  'players.name.inventory.slots.slot.enchant'
  'players.name.inventory.slots.slot.enchantments.enchantment_id.remove'
  'players.name.inventory.slots.slot.set'
  'players.name.kick'
  'players.name.op'
  'players.name.pardon'
  'players.name.permissions'
  'players.name.permissions.add'
  'players.name.permissions.remove'
  'players.name.send_message'
  'players.name.set_experience'
  'players.name.set_food_level'
  'players.name.set_game_mode'
  'players.name.set_health'
  'players.name.set_level'
  'players.name.teleport'
  'players.name.teleport_to.to_name'
  'players.name.teleport_world'
  'players.name.unwhitelist'
  'players.name.whitelist'
  'players.offline'
  'players.offline.name'
  'players.offline.names'
  'players.online'
  'players.online.count'
  'players.online.ips'
  'players.online.limit'
  'players.online.names'
  'players.ops.names'
  'players.pardon_ip'
  'players.whitelisted.names'
  'plugins'
  'plugins.disable_all'
  'plugins.install'
  'plugins.name'
  'plugins.name.commands'
  'plugins.name.disable'
  'plugins.name.enable'
  'plugins.name.files'
  'plugins.name.version'
  'server'
  'server.bukkit.version'
  'server.commands.list'
  'server.commands.list_with_details'
  'server.commands.name'
  'server.map.save'
  'server.map.save_off'
  'server.map.save_on'
  'server.performance.disk.free'
  'server.performance.disk.size'
  'server.performance.disk.used'
  'server.performance.memory.total'
  'server.performance.memory.used'
  'server.performance.tick_health'
  'server.power.reschedule_restart'
  'server.power.restart'
  'server.power.start'
  'server.power.stop'
  'server.reload'
  'server.run_command'
  'server.settings.ip'
  'server.settings.max_players'
  'server.settings.motd'
  'server.settings.port'
  'server.version'
  'streams.chat.latest'
  'streams.connections.limit'
  'streams.console.latest'
  'streams.formatted_chat.latest'
  'streams.name.limit'
  'worlds.all'
  'worlds.names'
  'worlds.world'
  'worlds.world.chat.groups.group.has_player'
  'worlds.world.get_block'
  'worlds.world.groups.group.prefix'
  'worlds.world.groups.group.set_prefix'
  'worlds.world.groups.group.set_suffix'
  'worlds.world.groups.group.suffix'
  'worlds.world.players.names'
  'worlds.world.players.player.chat.groups'
  'worlds.world.players.player.chat.groups.primary'
  'worlds.world.players.player.chat.prefix'
  'worlds.world.players.player.chat.set_prefix'
  'worlds.world.players.player.chat.set_suffix'
  'worlds.world.players.player.chat.suffix'
  'worlds.world.set_block'
  'worlds.world.set_difficulty'
  'worlds.world.set_time'
].sort().forEach (command) ->
  Minecraft::[command] = (args, cb) ->
    @call command, args, cb

  #TODO: 将功能分隔符.给迭代到子项目里面去喵!
  #cmd_domain = command.split '.'  
  #for cd in cmd_domain
    
   
    
  return

module.exports = Minecraft