# matrix

![Version: 18.4.0](https://img.shields.io/badge/Version-18.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.122.0](https://img.shields.io/badge/AppVersion-v1.122.0-informational?style=flat-square)

A Helm chart to deploy a Matrix homeserver stack on Kubernetes

**Homepage:** <https://github.com/small-hack/matrix-chart>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| jessebot |  | <https://github.com/jessebot> |

## Source Code

* <https://github.com/small-hack/matrix-chart>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://small-hack.github.io/coturn-chart | coturn | 7.1.0 |
| https://small-hack.github.io/matrix-authentication-service-chart | mas(matrix-authentication-service) | 1.3.1 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 16.3.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bridges.affinity | bool | `false` | Recommended to leave this disabled to allow bridges to be scheduled on separate nodes. Set this to true to reduce latency between the homeserver and bridges, or if your cloud provider does not allow the ReadWriteMany access mode (see below) |
| bridges.alertmanager.config.alertmanager_url | string | `""` | set to enable silence link, e.g. https://alertmanager.example.com |
| bridges.alertmanager.config.app_alertmanager_secret | string | `""` | secret key for the alertmanager webhook config URL |
| bridges.alertmanager.config.app_port | int | `3000` | alertmanager's container port |
| bridges.alertmanager.config.bot.avatar_url | string | `""` | optional: mxc:// avatar to set for the bot user |
| bridges.alertmanager.config.bot.display_name | string | `""` | optional: display name to set for the bot user |
| bridges.alertmanager.config.bot.mention_room | bool | `false` | Set this to true to make firing alerts do a `@room` mention. NOTE! Bot should also have enough power in the room for this to be useful. |
| bridges.alertmanager.config.bot.rooms | string | `""` | rooms to send alerts to, separated by a | Each entry contains the receiver name (from alertmanager) and the internal id (not the public alias) of the Matrix channel to forward to. |
| bridges.alertmanager.config.bot.user | string | `"alertmanager"` | user in matrix for the the alertmanager bot e.g. alertmanager which becomes @alertmanager:homeserver.tld |
| bridges.alertmanager.config.grafana_datasource | string | `""` | grafana data source, e.g. default |
| bridges.alertmanager.config.grafana_url | string | `""` | set to enable Grafana links, e.g. https://grafana.example.com |
| bridges.alertmanager.config.homeserver_url | string | `""` | your homeserver url, e.g. https://homeserver.tld |
| bridges.alertmanager.enabled | bool | `false` |  |
| bridges.alertmanager.encryption | bool | `false` |  |
| bridges.alertmanager.existingSecret.registration | string | `""` |  |
| bridges.alertmanager.image.pullPolicy | string | `"IfNotPresent"` | alertmanager bridge docker image pull policy. If tag is "latest", set tag to "Always" |
| bridges.alertmanager.image.repository | string | `"jessebot/matrix-alertmanager-bot"` | alertmanager bridge docker image |
| bridges.alertmanager.image.tag | string | `"0.12.0"` | alertmanager bridge docker image tag |
| bridges.alertmanager.registration.as_token | string | `""` |  |
| bridges.alertmanager.registration.existingSecret | string | `""` | Use an existing Kubernetes Secret to store your own generated appservice and homeserver tokens. If this is not set, we'll generate them for you. Setting this won't override the ENTIRE registration.yaml we generate for the synapse pod to authenticate mautrix/discord. It will only replaces the tokens. To replaces the ENTIRE registration.yaml, use bridges.alertmanager.existingSecret.registration |
| bridges.alertmanager.registration.existingSecretKeys.as_token | string | `"as_token"` | key in existingSecret for as_token (application service token). If provided and existingSecret is set, ignores bridges.alertmanager.registration.as_token |
| bridges.alertmanager.registration.existingSecretKeys.hs_token | string | `"hs_token"` | key in existingSecret for hs_token (home server token) |
| bridges.alertmanager.registration.id | string | `"alertmanager"` | name of the application service |
| bridges.alertmanager.registration.rate_limited | bool | `false` | should this bot be rate limited? |
| bridges.alertmanager.registration.sender_localpart | string | `"alertmanager"` | localpart of the user associated with the application service. Events will be sent to the AS if this user is the target of the event, or is a joined member of the room where the event occurred. |
| bridges.alertmanager.registration.url | string | `""` | url of the alertmanager service. if not provided, we will template it for you like http://matrix-alertmanager-service:3000 |
| bridges.alertmanager.replicaCount | int | `1` | alertmanager bridge pod replicas |
| bridges.alertmanager.revisionHistoryLimit | int | `2` | set the revisionHistoryLimit to decide how many replicaSets are kept when you change a deployment. Explicitly setting this field to 0, will result in cleaning up all the history of your Deployment thus that Deployment will not be able to roll back. |
| bridges.alertmanager.service.type | string | `"ClusterIP"` | service type for the alertmanager bridge |
| bridges.discord.auth.botToken | string | `""` | Discord bot token for authentication |
| bridges.discord.auth.clientId | string | `""` | Discord bot clientID for authentication |
| bridges.discord.channelName | string | `"[Discord] :guild :name"` |  |
| bridges.discord.data.capacity | string | `"512Mi"` | Size of the PVC to allocate for the SQLite database |
| bridges.discord.data.storageClass | string | `""` | Storage class (optional) |
| bridges.discord.defaultVisibility | string | `"public"` | Default visibility of bridged rooms (public/private) |
| bridges.discord.enabled | bool | `false` | Set to true to enable the DEPRECATED Discord bridge. This will be removed in the future in favor of discord_mautrix.enabled |
| bridges.discord.image.pullPolicy | string | `"Always"` |  |
| bridges.discord.image.repository | string | `"halfshot/matrix-appservice-discord"` | docker image repo for discord bridge |
| bridges.discord.image.tag | string | `"latest"` | tag for discord brdige docker image |
| bridges.discord.joinLeaveEvents | bool | `true` | Discord notifications when a user joins/leaves the Matrix channel |
| bridges.discord.presence | bool | `true` | Set to false to disable online/offline presence for Discord users |
| bridges.discord.readReceipt | bool | `true` | Discord bot read receipt, which advances whenever the bot bridges a msg |
| bridges.discord.replicaCount | int | `1` | pod replicas for the discord bridge pod |
| bridges.discord.resources | object | `{}` | resources for the discord bridge pod |
| bridges.discord.selfService | bool | `false` | Set to true to allow users to bridge rooms themselves using !discord cmds More info: https://t2bot.io/discord |
| bridges.discord.service.port | int | `9005` |  |
| bridges.discord.service.type | string | `"ClusterIP"` | service type for the discord bridge |
| bridges.discord.typingNotifications | bool | `true` | Set to false to disable typing notifications (only for Discord to Matrix) |
| bridges.discord.users.nickname | string | `":nick"` | Nickname of bridged Discord users Available vars:   :nick     - user's Discord nickname   :username - user's Discord username   :tag      - user's 4 digit Discord tag   :id       - user's Discord developer ID (long) |
| bridges.discord.users.username | string | `":username#:tag"` | Username of bridged Discord users Available vars:   :username - user's Discord username   :tag      - user's 4 digit Discord tag   :id       - user's Discord developer ID (long) |
| bridges.discord_mautrix.admin_users | list | `[]` | optional: if set and bridges.discord_mautrix.config.permissions are NOT set below, we'll use this list of admin users to template an admin user using your matrix host. You MUST also set the matrix.hostname parameter. example value of ["admin"] would become @admin:matrix.example.com |
| bridges.discord_mautrix.config.appservice.address | string | `""` | The address that the homeserver can use to connect to this appservice. example is http://localhost:29334 but if not provided, we guess :) |
| bridges.discord_mautrix.config.appservice.async_transactions | bool | `false` | Should incoming events be handled asynchronously? This may be necessary for large public instances with lots of messages going through. However, messages will not be guaranteed to be bridged in the same order they were sent in. |
| bridges.discord_mautrix.config.appservice.bot.avatar | string | `"remove"` | Display avatar for bot. Set to "remove" to remove display avatar. example: mxc://maunium.net/nIdEykemnwdisvHbpxflpDlC |
| bridges.discord_mautrix.config.appservice.bot.displayname | string | `"Discord bridge bot"` | Display name for bot. Set to "remove" to remove display name. |
| bridges.discord_mautrix.config.appservice.bot.username | string | `"discordbot"` | Username of the appservice bot. |
| bridges.discord_mautrix.config.appservice.database.max_conn_idle_time | string | `nil` | Maximum connection idle time before its closed. Disabled if null. Parsed with https://pkg.go.dev/time#ParseDuration |
| bridges.discord_mautrix.config.appservice.database.max_conn_lifetime | string | `nil` | Maximum connection lifetime before its closed. Disabled if null. Parsed with https://pkg.go.dev/time#ParseDuration |
| bridges.discord_mautrix.config.appservice.database.max_idle_conns | int | `2` |  |
| bridges.discord_mautrix.config.appservice.database.max_open_conns | int | `20` | Maximum number of connections. Mostly relevant for Postgres. |
| bridges.discord_mautrix.config.appservice.database.type | string | `"sqlite3-fk-wal"` | The database type. "sqlite3-fk-wal" and "postgres" are supported. |
| bridges.discord_mautrix.config.appservice.database.uri | string | `"file:/mautrixdiscord.db?_txlock=immediate"` | The database URI. SQLite: A raw file path is supported, but recommended way is:   `file:<path>?_txlock=immediate`   https://github.com/mattn/go-sqlite3#connection-string Postgres: Connection string. For example,   postgres://user:password@host/database?sslmode=disable To connect via Unix socket, use something like,   postgres:///dbname?host=/var/run/postgresql |
| bridges.discord_mautrix.config.appservice.ephemeral_events | bool | `true` | Whether or not to receive ephemeral events via appservice transactions. Requires MSC2409 support (i.e. Synapse 1.22+). |
| bridges.discord_mautrix.config.appservice.hostname | string | `"0.0.0.0"` | The hostname where this appservice should listen. |
| bridges.discord_mautrix.config.appservice.id | string | `"discord"` | The unique ID of this appservice. |
| bridges.discord_mautrix.config.appservice.port | int | `29334` | The port where this appservice should listen. |
| bridges.discord_mautrix.config.bridge.animated_sticker.args.fps | int | `25` | fps, only for webm, webp and gif (2, 5, 10, 20 or 25 recommended) |
| bridges.discord_mautrix.config.bridge.animated_sticker.args.height | int | `320` | height arg for converter |
| bridges.discord_mautrix.config.bridge.animated_sticker.args.width | int | `320` | width arg for converter |
| bridges.discord_mautrix.config.bridge.animated_sticker.target | string | `"webp"` | Format to which animated stickers should be converted. disable - No conversion, send as-is (lottie JSON) png - converts to non-animated png (fastest) gif - converts to animated gif webm - converts to webm video, requires ffmpeg executable with vp9 codec and webm container support webp - converts to animated webp, requires ffmpeg executable with webp codec/container support |
| bridges.discord_mautrix.config.bridge.autojoin_thread_on_open | bool | `true` | Should the bridge automatically join the user to threads on Discord when the thread is opened on Matrix? This only works with clients that support thread read receipts (MSC3771 added in Matrix v1.4). |
| bridges.discord_mautrix.config.bridge.backfill.forward_limits.initial.channel | int | `0` |  |
| bridges.discord_mautrix.config.bridge.backfill.forward_limits.initial.dm | int | `0` |  |
| bridges.discord_mautrix.config.bridge.backfill.forward_limits.initial.thread | int | `0` |  |
| bridges.discord_mautrix.config.bridge.backfill.forward_limits.missed.channel | int | `0` |  |
| bridges.discord_mautrix.config.bridge.backfill.forward_limits.missed.dm | int | `0` |  |
| bridges.discord_mautrix.config.bridge.backfill.forward_limits.missed.thread | int | `0` |  |
| bridges.discord_mautrix.config.bridge.backfill.max_guild_members | int | `-1` | Maximum members in a guild to enable backfilling. Set to -1 to disable limit. This can be used as a rough heuristic to disable backfilling in channels that are too active. Currently only applies to missed message backfill. |
| bridges.discord_mautrix.config.bridge.cache_media | string | `"unencrypted"` | Should mxc uris copied from Discord be cached? This can be `never` to never cache, `unencrypted` to only cache unencrypted mxc uris, or `always` to cache everything. If you have a media repo that generates non-unique mxc uris, you should set this to never. |
| bridges.discord_mautrix.config.bridge.channel_name_template | string | `"{{if or (eq .Type 3) (eq .Type 4)}}{{.Name}}{{else}}#{{.Name}}{{end}}"` | Displayname template for Discord channels (bridged as rooms, or spaces when type=4). Available variables:   .Name - Channel name, or user displayname (pre-formatted with displayname_template) in DMs.   .ParentName - Parent channel name (used for categories).   .GuildName - Guild name.   .NSFW - Whether the channel is marked as NSFW.   .Type - Channel type (see values at https://github.com/bwmarrin/discordgo/blob/v0.25.0/structs.go#L251-L267) |
| bridges.discord_mautrix.config.bridge.command_prefix | string | `"!discord"` | The prefix for commands. Only required in non-management rooms. |
| bridges.discord_mautrix.config.bridge.custom_emoji_reactions | bool | `true` | Should incoming custom emoji reactions be bridged as mxc:// URIs? If set to false, custom emoji reactions will be bridged as the shortcode instead, and the image won't be available. |
| bridges.discord_mautrix.config.bridge.delete_guild_on_leave | bool | `true` | Should the bridge delete all portal rooms when you leave a guild on Discord? This only applies if the guild has no other Matrix users on this bridge instance. |
| bridges.discord_mautrix.config.bridge.delete_portal_on_channel_delete | bool | `false` | Should the bridge attempt to completely delete portal rooms when a channel is deleted on Discord? If true, the bridge will try to kick Matrix users from the room. Otherwise, the bridge only makes ghosts leave. |
| bridges.discord_mautrix.config.bridge.delivery_receipts | bool | `false` | Should the bridge send a read receipt from the bridge bot when a message has been sent to Discord? |
| bridges.discord_mautrix.config.bridge.direct_media | object | `{"allow_proxy":true,"enabled":false,"server_key":"generate","server_name":"discord-media.example.com","well_known_response":null}` | Settings for converting Discord media to custom mxc:// URIs instead of reuploading. More details can be found at https://docs.mau.fi/bridges/go/discord/direct-media.html |
| bridges.discord_mautrix.config.bridge.direct_media.allow_proxy | bool | `true` | The bridge supports MSC3860 media download redirects and will use them if the requester supports it. Optionally, you can force redirects and not allow proxying at all by setting this to false. |
| bridges.discord_mautrix.config.bridge.direct_media.enabled | bool | `false` | Should custom mxc:// URIs be used instead of reuploading media? |
| bridges.discord_mautrix.config.bridge.direct_media.server_key | string | `"generate"` | Matrix server signing key to make the federation tester pass, same format as synapse's .signing.key file. |
| bridges.discord_mautrix.config.bridge.direct_media.server_name | string | `"discord-media.example.com"` | The server name to use for the custom mxc:// URIs. This server name will effectively be a real Matrix server, it just won't implement anything other than media. You must either set up .well-known delegation from this domain to the bridge, or proxy the domain directly to the bridge. |
| bridges.discord_mautrix.config.bridge.direct_media.well_known_response | string | `nil` | Optionally a custom .well-known response. This defaults to `server_name:443` |
| bridges.discord_mautrix.config.bridge.displayname_template | string | `"{{or .GlobalName .Username}}{{if .Bot}} (bot){{end}}"` | Displayname template for Discord users. This is also used as the room name in DMs if private_chat_portal_meta is enabled. Available variables:   .ID - Internal user ID   .Username - Legacy display/username on Discord   .GlobalName - New displayname on Discord   .Discriminator - The 4 numbers after the name on Discord   .Bot - Whether the user is a bot   .System - Whether the user is an official system user   .Webhook - Whether the user is a webhook and is not an application   .Application - Whether the user is an application |
| bridges.discord_mautrix.config.bridge.double_puppet_allow_discovery | bool | `false` | Allow using double puppeting from any server with a valid client .well-known file. |
| bridges.discord_mautrix.config.bridge.double_puppet_server_map | object | `{}` | Servers to always allow double puppeting from |
| bridges.discord_mautrix.config.bridge.embed_fields_as_tables | bool | `true` | Should inline fields in Discord embeds be bridged as HTML tables to Matrix? Tables aren't supported in all clients, but are the only way to emulate the Discord inline field UI. |
| bridges.discord_mautrix.config.bridge.enable_webhook_avatars | bool | `true` | Bridge webhook avatars? |
| bridges.discord_mautrix.config.bridge.encryption.allow | bool | `false` | Allow encryption, work in group chat rooms with e2ee enabled |
| bridges.discord_mautrix.config.bridge.encryption.allow_key_sharing | bool | `false` | Enable key sharing? If enabled, key requests for rooms where users are in will be fulfilled. You must use a client that supports requesting keys from other users to use this feature. |
| bridges.discord_mautrix.config.bridge.encryption.appservice | bool | `false` | Whether to use MSC2409/MSC3202 instead of /sync long polling for receiving encryption-related data. |
| bridges.discord_mautrix.config.bridge.encryption.default | bool | `false` | Default to encryption, force-enable encryption in all portals the bridge creates This will cause the bridge bot to be in private chats for the encryption to work properly. |
| bridges.discord_mautrix.config.bridge.encryption.delete_keys.delete_fully_used_on_decrypt | bool | `false` | Delete fully used keys (index >= max_messages) after decrypting messages. |
| bridges.discord_mautrix.config.bridge.encryption.delete_keys.delete_on_device_delete | bool | `false` | Delete megolm sessions received from a device when the device is deleted. |
| bridges.discord_mautrix.config.bridge.encryption.delete_keys.delete_outbound_on_ack | bool | `false` | Beeper-specific: delete outbound sessions when hungryserv confirms that the user has uploaded the key to key backup. |
| bridges.discord_mautrix.config.bridge.encryption.delete_keys.delete_outdated_inbound | bool | `false` | Delete inbound megolm sessions that don't have the received_at field used for automatic ratcheting and expired session deletion. This is meant as a migration to delete old keys prior to the bridge update. |
| bridges.discord_mautrix.config.bridge.encryption.delete_keys.delete_prev_on_new_session | bool | `false` | Delete previous megolm sessions from same device when receiving a new one. |
| bridges.discord_mautrix.config.bridge.encryption.delete_keys.dont_store_outbound | bool | `false` | Don't store outbound sessions in the inbound table. |
| bridges.discord_mautrix.config.bridge.encryption.delete_keys.periodically_delete_expired | bool | `false` | Periodically delete megolm sessions when 2x max_age has passed since receiving the session. |
| bridges.discord_mautrix.config.bridge.encryption.delete_keys.ratchet_on_decrypt | bool | `false` | Ratchet megolm sessions forward after decrypting messages. |
| bridges.discord_mautrix.config.bridge.encryption.plaintext_mentions | bool | `false` | Should users mentions be in the event wire content to enable the server to send push notifications? |
| bridges.discord_mautrix.config.bridge.encryption.require | bool | `false` | Require encryption, drop any unencrypted messages. |
| bridges.discord_mautrix.config.bridge.encryption.rotation.disable_device_change_key_rotation | bool | `false` | Disable rotating keys when a user's devices change? You should not enable this option unless you understand all the implications. |
| bridges.discord_mautrix.config.bridge.encryption.rotation.enable_custom | bool | `false` | Enable custom Megolm room key rotation settings. Note that these settings will only apply to rooms created after this option is set. |
| bridges.discord_mautrix.config.bridge.encryption.rotation.messages | int | `100` | The maximum number of messages that should be sent with a given a session before changing it. The Matrix spec recommends 100 as the default. |
| bridges.discord_mautrix.config.bridge.encryption.rotation.milliseconds | int | `604800000` | The maximum number of milliseconds a session should be used before changing it. The Matrix spec recommends 604800000 (a week) as the default. |
| bridges.discord_mautrix.config.bridge.encryption.verification_levels.receive | string | `"unverified"` | Minimum level for which the bridge should send keys to when bridging messages from WhatsApp to Matrix. |
| bridges.discord_mautrix.config.bridge.encryption.verification_levels.send | string | `"unverified"` | Minimum level that the bridge should accept for incoming Matrix messages. |
| bridges.discord_mautrix.config.bridge.encryption.verification_levels.share | string | `"cross-signed-tofu"` | Minimum level that the bridge should require for accepting key requests. |
| bridges.discord_mautrix.config.bridge.federate_rooms | bool | `true` | Whether or not created rooms should have federation enabled. If false, created portal rooms will never be federated. |
| bridges.discord_mautrix.config.bridge.guild_name_template | string | `"{{.Name}}"` | Displayname template for Discord guilds (bridged as spaces). Available variables:   .Name - Guild name |
| bridges.discord_mautrix.config.bridge.login_shared_secret_map | object | `{}` | Shared secrets for https://github.com/devture/matrix-synapse-shared-secret-auth  If set, double puppeting will be enabled automatically for local users instead of users having to find an access token and run `login-matrix` manually. |
| bridges.discord_mautrix.config.bridge.management_room_text.additional_help | string | `""` | Optional extra text sent when joining a management room. |
| bridges.discord_mautrix.config.bridge.management_room_text.welcome | string | `"Hello, I'm a Discord bridge bot."` | Sent when joining a room. |
| bridges.discord_mautrix.config.bridge.management_room_text.welcome_connected | string | `"Use `help` for help."` | Sent when joining a management room and the user is already logged in. |
| bridges.discord_mautrix.config.bridge.management_room_text.welcome_unconnected | string | `"Use `help` for help or `login` to log in."` | Sent when joining a management room and the user is not logged in. |
| bridges.discord_mautrix.config.bridge.message_error_notices | bool | `true` | Whether the bridge should send error notices via m.notice events when a message fails to bridge. |
| bridges.discord_mautrix.config.bridge.message_status_events | bool | `false` | Whether the bridge should send the message status as a custom com.beeper.message_send_status event. |
| bridges.discord_mautrix.config.bridge.mute_channels_on_create | bool | `false` | Should guild channels be muted when the portal is created? This only meant for single-user instances, it won't mute it for all users if there are multiple Matrix users in the same Discord guild. |
| bridges.discord_mautrix.config.bridge.permissions | object | `{}` |  |
| bridges.discord_mautrix.config.bridge.portal_message_buffer | int | `128` |  |
| bridges.discord_mautrix.config.bridge.prefix_webhook_messages | bool | `false` | Prefix messages from webhooks with the profile info? This can be used along with a custom displayname_template to better handle webhooks that change their name all the time (like ones used by bridges). |
| bridges.discord_mautrix.config.bridge.private_chat_portal_meta | string | `"default"` | Whether to explicitly set the avatar and room name for private chat portal rooms. If set to `default`, this will be enabled in encrypted rooms and disabled in unencrypted rooms. If set to `always`, all DM rooms will have explicit names and avatars set. If set to `never`, DM rooms will never have names and avatars set. |
| bridges.discord_mautrix.config.bridge.provisioning.debug_endpoints | bool | `false` | Enable debug API at /debug with provisioning authentication. |
| bridges.discord_mautrix.config.bridge.provisioning.prefix | string | `"/_matrix/provision"` | Prefix for the provisioning API paths. |
| bridges.discord_mautrix.config.bridge.provisioning.shared_secret | string | `"generate"` | Shared secret for authentication. If set to "generate", a random secret will be generated, or if set to "disable", the provisioning API will be disabled. |
| bridges.discord_mautrix.config.bridge.resend_bridge_info | bool | `false` | Set this to true to tell the bridge to re-send m.bridge events to all rooms on the next run. This field will automatically be changed back to false after it, except if the config file is not writable. |
| bridges.discord_mautrix.config.bridge.restricted_rooms | bool | `true` | Should the bridge use space-restricted join rules instead of invite-only for guild rooms? This can avoid unnecessary invite events in guild rooms when members are synced in. |
| bridges.discord_mautrix.config.bridge.startup_private_channel_create_limit | int | `5` | Number of private channel portals to create on bridge startup. Other portals will be created when receiving messages. |
| bridges.discord_mautrix.config.bridge.sync_direct_chat_list | bool | `false` | Should the bridge update the m.direct account data event when double puppeting is enabled. Note that updating the m.direct event is not atomic (except with mautrix-asmux) and is therefore prone to race conditions. |
| bridges.discord_mautrix.config.bridge.use_discord_cdn_upload | bool | `true` | Should the bridge upload media to the Discord CDN directly before sending the message when using a user token, like the official client does? The other option is sending the media in the message send request as a form part (which is always used by bots and webhooks). |
| bridges.discord_mautrix.config.bridge.username_template | string | `"{{`discord_{{.}}`}}"` | Localpart template of MXIDs for Discord users. {{.}} is replaced with the internal ID of the Discord user. |
| bridges.discord_mautrix.config.homeserver.address | string | `""` | The address that this appservice can use to connect to the homeserver. this would be something like https://matrix.example.com, but if not set, we'll try to guess the correct homeserver url :) |
| bridges.discord_mautrix.config.homeserver.async_media | bool | `false` | Does the homeserver support https://github.com/matrix-org/matrix-spec-proposals/pull/2246? |
| bridges.discord_mautrix.config.homeserver.domain | string | `""` | domain of the homeserver (also known as server_name, used for MXIDs, etc). if not provided, we'll try to guess the correct one, but if your server is https://matrix.example.com, it's probably example.com |
| bridges.discord_mautrix.config.homeserver.message_send_checkpoint_endpoint | string | `nil` | Endpoint for reporting per-message status. |
| bridges.discord_mautrix.config.homeserver.ping_interval_seconds | int | `0` | How often should the websocket be pinged? Pinging will be disabled if this is zero. |
| bridges.discord_mautrix.config.homeserver.public_address | string | `nil` |  |
| bridges.discord_mautrix.config.homeserver.software | string | `"standard"` | What software is the homeserver running? Standard Matrix homeservers like Synapse, Dendrite and Conduit should just use "standard" here. |
| bridges.discord_mautrix.config.homeserver.status_endpoint | string | `nil` | The URL to push real-time bridge status to. If set, the bridge will make POST requests to this URL whenever a user's discord connection state changes. The bridge will use the appservice as_token to authorize requests. |
| bridges.discord_mautrix.config.homeserver.websocket | bool | `false` | Should the bridge use a websocket for connecting to the homeserver? The server side is currently not documented anywhere and is only implemented by mautrix-wsproxy, mautrix-asmux (deprecated), and hungryserv (proprietary). |
| bridges.discord_mautrix.config.logging.min_level | string | `"debug"` | min logging level |
| bridges.discord_mautrix.config.logging.writers[0].format | string | `"pretty-colored"` |  |
| bridges.discord_mautrix.config.logging.writers[0].type | string | `"stdout"` |  |
| bridges.discord_mautrix.config.logging.writers[1].compress | bool | `true` |  |
| bridges.discord_mautrix.config.logging.writers[1].filename | string | `"./logs/mautrix-discord.log"` |  |
| bridges.discord_mautrix.config.logging.writers[1].format | string | `"json"` |  |
| bridges.discord_mautrix.config.logging.writers[1].max_backups | int | `10` |  |
| bridges.discord_mautrix.config.logging.writers[1].max_size | int | `100` |  |
| bridges.discord_mautrix.config.logging.writers[1].type | string | `"file"` |  |
| bridges.discord_mautrix.enabled | bool | `false` | Set to true to enable the Discord bridge. Learn more in the [mautrix bridge docs](https://docs.mau.fi/bridges/go/discord/index.html). |
| bridges.discord_mautrix.existingSecret | object | `{"config":"","registration":""}` | use an existingSecret for mautrix/discord bridge config.yaml, if set, ignores everything under bridges.discord_mautrix.config Cannot be used in combination with bridges.discord_mautrix.registration.existingSecret. |
| bridges.discord_mautrix.extraVolumeMounts | list | `[]` | extra volumeMounts for the mautrix/discord deployment |
| bridges.discord_mautrix.extraVolumes | list | `[]` | extra volumes for the mautrix/discord deployment |
| bridges.discord_mautrix.image.pullPolicy | string | `"IfNotPresent"` |  |
| bridges.discord_mautrix.image.repository | string | `"dock.mau.dev/mautrix/discord"` | docker image repo for mautrix/discord bridge |
| bridges.discord_mautrix.image.tag | string | `"8d01c30014978e2360d5cb102e96542ecb2402b6-amd64"` | tag for mautrix/discord bridge docker image |
| bridges.discord_mautrix.podSecurityContext | object | `{}` | security context for the entire mautrix/discord pod |
| bridges.discord_mautrix.registration.existingSecret | string | `""` | Use an existing Kubernetes Secret to store your own generated appservice and homeserver tokens. If this is not set, we'll generate them for you. Setting this won't override the ENTIRE registration.yaml we generate for the synapse pod to authenticate mautrix/discord. It will only replaces the tokens. To replaces the ENTIRE registration.yaml, use bridges.discord_mautrix.existingSecret.registration |
| bridges.discord_mautrix.registration.existingSecretKeys.as_token | string | `"as_token"` | key in existingSecret for as_token (appservice token) |
| bridges.discord_mautrix.registration.existingSecretKeys.hs_token | string | `"hs_token"` | key in existingSecret for hs_token (home server token) |
| bridges.discord_mautrix.registration.sender_localpart | string | `"discord"` | I don't actually know what this does |
| bridges.discord_mautrix.revisionHistoryLimit | int | `2` | set the revisionHistoryLimit to decide how many replicaSets are kept when you change a deployment. Explicitly setting this field to 0, will result in cleaning up all the history of your Deployment thus that Deployment will not be able to roll back. |
| bridges.discord_mautrix.securityContext | object | `{}` | security context for the init container and main container in the discord pod |
| bridges.discord_mautrix.service.bridge.port | int | `29334` |  |
| bridges.discord_mautrix.service.type | string | `"ClusterIP"` |  |
| bridges.hookshot.config.bot.avatar | string | `""` | optional: Define profile avatar for the bot user example: mxc://half-shot.uk/2876e89ccade4cb615e210c458e2a7a6883fe17d |
| bridges.hookshot.config.bot.displayname | string | `""` | Define profile display name for the bot user |
| bridges.hookshot.config.bridge.bindAddress | string | `"0.0.0.0"` | this probably shouldn't change since we're using docker |
| bridges.hookshot.config.bridge.domain | string | `""` | if not set, defaults to matrix.serverName |
| bridges.hookshot.config.bridge.mediaUrl | string | `""` | example is https://example.com, but if left blank, we don't include it |
| bridges.hookshot.config.bridge.port | int | `9993` | the port to run the application service on |
| bridges.hookshot.config.bridge.url | string | `""` | url in example is http://localhost:8008, but if not set, we use matrix.baseUrl |
| bridges.hookshot.config.cache | Optional | `{"redisUri":""}` | Cache options for large scale deployments. |
| bridges.hookshot.config.cache.redisUri | string | `""` | For encryption to work, this must be configured. example value: redis://localhost:6379 |
| bridges.hookshot.config.feeds.enabled | bool | `false` | enable RSS/Atom feed support |
| bridges.hookshot.config.feeds.pollConcurrency | int | `4` |  |
| bridges.hookshot.config.feeds.pollIntervalSeconds | int | `600` | specifies how often each feed will be checked for updates. It may be checked less often if under exceptional load, but it will never be checked more often than every pollIntervalSeconds |
| bridges.hookshot.config.feeds.pollTimeoutSeconds | int | `30` |  |
| bridges.hookshot.config.figma.enabled | Optional | `false` | Configure this to enable Figma support |
| bridges.hookshot.config.figma.instances.your-instance.accessToken | string | `"your-personal-access-token"` |  |
| bridges.hookshot.config.figma.instances.your-instance.passcode | string | `"your-webhook-passcode"` |  |
| bridges.hookshot.config.figma.instances.your-instance.teamId | string | `"your-team-id"` |  |
| bridges.hookshot.config.figma.publicUrl | string | `"https://example.com/hookshot/"` |  |
| bridges.hookshot.config.generic.allowJsTransformationFunctions | bool | `false` | will allow users to write short transformation snippets in code, and thus is unsafe in untrusted environments |
| bridges.hookshot.config.generic.enableHttpGet | bool | `false` | means that webhooks can be triggered by GET requests, in addition to POST and PUT. This was previously on by default, but is now disabled due to concerns mentioned in docs. |
| bridges.hookshot.config.generic.enabled | bool | `false` | enable support for generic webhook events via the hookshot bridge, see [docs](https://matrix-org.github.io/matrix-hookshot/latest/setup/webhooks.html) for more info |
| bridges.hookshot.config.generic.outbound | bool | `false` | configure Hookshot to send outgoing requests to other services when a message appears on Matrix |
| bridges.hookshot.config.generic.urlPrefix | string | `""` | describes the public facing URL of your webhook handler. For instance, if your load balancer redirected webhook requests from https://example.com/mywebhookspath to the bridge (on /webhook), an example webhook URL would look like: https://example.com/mywebhookspath/abcdef. |
| bridges.hookshot.config.generic.userIdPrefix | string | `""` | create a specific user for each new webhook connection in a room. For example, a connection with a name like example for a prefix of webhook_ will create a user called @webhook_example:example.com. If you enable this option, you need to configure the user to be part of your registration file |
| bridges.hookshot.config.generic.waitForComplete | bool | `false` | causes the bridge to wait until the webhook is processed before sending a response. Some services prefer you always respond with a 200 as soon as the webhook has entered processing (false) while others prefer to know if the resulting Matrix message has been sent (true) |
| bridges.hookshot.config.github.auth.id | string | `""` | App ID for the GitHub App, e.g. 123 |
| bridges.hookshot.config.github.auth.privateKeyFile | string | `"/data/github-key.pem"` | privateKeyFile can be generated by clicking "Generate a private key" under the Private keys section on the GitHub app page. |
| bridges.hookshot.config.github.defaultOptions | Optional | `{"hotlinkIssues":{"prefix":"#"},"showIssueRoomLink":false}` | Default options for GitHub connections. see docs for more: https://matrix-org.github.io/matrix-hookshot/latest/usage/room_configuration/github_repo.html#configuration |
| bridges.hookshot.config.github.enabled | bool | `false` | enable GitHub support in the hookshot bridge |
| bridges.hookshot.config.github.enterpriseUrl | string | `""` | If you are using an on-premise / enterprise edition of GitHub, you need provide the base URL in enterpriseUrl. You do not need to specify the /api/... path in the URL |
| bridges.hookshot.config.github.existingSecret | string | `""` | grab sensitive values for github from an existing Kubernetes secret |
| bridges.hookshot.config.github.existingSecretKeys.auth_id | string | `""` | key in existing Kubernetes secret for GitHub auth.id which is the GitHub App ID |
| bridges.hookshot.config.github.existingSecretKeys.oauth_client_id | string | `""` | key in existing Kubernetes secret for GitHub oauth client id |
| bridges.hookshot.config.github.existingSecretKeys.oauth_client_secret | string | `""` | key in existing Kubernetes secret for GitHub oauth client secret |
| bridges.hookshot.config.github.existingSecretKeys.private_key | string | `""` | key in existin Kubernetes secret for GitHub privatekey |
| bridges.hookshot.config.github.existingSecretKeys.webhook_secret | string | `""` | key in existing Kubernetes secret for GitHub webhook secret |
| bridges.hookshot.config.github.oauth | object | `{"client_id":"","client_secret":"","redirect_uri":""}` | oauth section should include both the Client ID and Client Secret on the GitHub App page. The redirect_uri value must be the public path to /oauth on the webhooks path. E.g. if your load balancer points https://example.com/hookshot to the bridge webhooks listener, you should use the path https://example.com/hookshot/oauth. This value MUST exactly match the Callback URL on the GitHub App page. |
| bridges.hookshot.config.github.userIdPrefix | Optional | `"_github_"` | Prefix used when creating ghost users for GitHub accounts. |
| bridges.hookshot.config.github.webhook.secret | string | `""` | Webhook settings for the GitHub app. example showed value secrettoken |
| bridges.hookshot.config.gitlab.commentDebounceMs | Optional | `5000` | Aggregate comments by waiting this many miliseconds before posting them to Matrix. Defaults to 5000 (5 seconds) |
| bridges.hookshot.config.gitlab.enabled | bool | `false` | enable GitLab support in the hookshot bridge |
| bridges.hookshot.config.gitlab.instances | object | `{}` | gitlab instances to use |
| bridges.hookshot.config.gitlab.userIdPrefix | Optional | `""` | Prefix used when creating ghost users for GitLab accounts. docs suggest: "_gitlab_" |
| bridges.hookshot.config.gitlab.webhook.publicUrl | string | `""` | example showed https://example.com/hookshot/ |
| bridges.hookshot.config.gitlab.webhook.secret | string | `""` | example showed value of secrettoken |
| bridges.hookshot.config.listeners[0].bindAddress | string | `"0.0.0.0"` |  |
| bridges.hookshot.config.listeners[0].port | int | `9000` |  |
| bridges.hookshot.config.listeners[0].resources[0] | string | `"webhooks"` |  |
| bridges.hookshot.config.listeners[1].bindAddress | string | `"0.0.0.0"` |  |
| bridges.hookshot.config.listeners[1].port | int | `9001` |  |
| bridges.hookshot.config.listeners[1].resources[0] | string | `"metrics"` |  |
| bridges.hookshot.config.listeners[1].resources[1] | string | `"provisioning"` |  |
| bridges.hookshot.config.logging.colorize | bool | `true` | enable text colors in logging |
| bridges.hookshot.config.logging.json | bool | `false` | enable json formatted logging |
| bridges.hookshot.config.logging.level | string | `"info"` | log severity level. Options: debug, info, warn, error |
| bridges.hookshot.config.logging.timestampFormat | string | `"HH:mm:ss:SSS"` | logging timestamp format |
| bridges.hookshot.config.metrics.enabled | bool | `false` | enable Prometheus metrics support from hookshot to Prometheus, see [docs](https://matrix-org.github.io/matrix-hookshot/latest/metrics.html) |
| bridges.hookshot.config.passFile | string | `"/data/passkey.pem"` | A passkey used to encrypt tokens stored inside the bridge. |
| bridges.hookshot.config.permissions | Optional | `[]` | Permissions for using the bridge. See [docs](https://matrix-org.github.io/matrix-hookshot/latest/setup.html#permissions) |
| bridges.hookshot.config.provisioning.enabled | Optional | `false` | Provisioning API for integration managers |
| bridges.hookshot.config.provisioning.secret | string | `"!secretToken"` |  |
| bridges.hookshot.config.queue | Optional | `{"redisUri":""}` | Message queue configuration options for large scale deployments. |
| bridges.hookshot.config.queue.redisUri | string | `""` | For encryption to work, this must not be configured. example value: redis://localhost:6379 |
| bridges.hookshot.config.sentry | Optional | `{"dsn":"","environment":""}` | Configure Sentry error reporting |
| bridges.hookshot.config.sentry.dsn | string | `""` | example value: https://examplePublicKey@o0.ingest.sentry.io/0 |
| bridges.hookshot.config.sentry.environment | string | `""` | example value: production |
| bridges.hookshot.config.serviceBots | Optional | `[]` | Define additional bot users for specific services |
| bridges.hookshot.config.widgets.addToAdminRooms | bool | `false` | The admin room feature is still very barebones so while it's included here for completeness, most instances should leave addToAdminRooms off (as it is by default). This flag will add an "admin room" widget to user admin rooms. |
| bridges.hookshot.config.widgets.branding.widgetTitle | string | `"Hookshot Configuration"` |  |
| bridges.hookshot.config.widgets.disallowedIpRanges | list | `[]` | which IP ranges should be disallowed when resolving homeserver IP addresses (for security reasons). Unless you know what you are doing, it is recommended to not include this key. The default blocked IPs are listed below for your convenience. In addition to setting up the widgets config, you must bind a listener for the widgets resource in your listeners config. |
| bridges.hookshot.config.widgets.enabled | Optional | `false` | EXPERIMENTAL support for complimentary widgets |
| bridges.hookshot.config.widgets.openIdOverrides | object | `{}` | allows you to configure the correct federation endpoints for a given set of Matrix server names. This is useful if you are testing/developing Hookshot in a local dev environment. Production environments should not use this configuration (as their Matrix server name should be resolvable). The config takes a mapping of Matrix server name => base path for federation. E.g. if your server name was my-local-server and your federation was readable via http://localhost/_matrix/federation, you would put configure my-local-server: "http://localhost" |
| bridges.hookshot.config.widgets.publicUrl | string | `"https://example.com/widgetapi/v1/static/"` | should be set to the publicly reachable address for the widget public content. By default, Hookshot hosts this content on the widgets listener under /widgetapi/v1/static. |
| bridges.hookshot.config.widgets.roomSetupWidget | object | `{"addOnInvite":false}` | The room setup feature is more complete, supporting generic webhook configuration (with more options coming soon). This can be enabled by setting roomSetupWidget to an object. You can add the widget by saying !hookshot setup-widget in any room. When addOnInvite is true, the bridge will add a widget to rooms when the bot is invited, and the room has no existing connections. |
| bridges.hookshot.enabled | bool | `false` | enable the [hookshot](https://matrix-org.github.io/matrix-hookshot) bridge |
| bridges.hookshot.encryption | bool | `false` | if you'd like to enable encryption in your registration.yml |
| bridges.hookshot.existingConfigMap | string | `""` | use the name of an existing ConfigMap for hookshot bridge. If set, ignores entire bridges.hookshot.config section |
| bridges.hookshot.existingSecret.config | string | `""` | optionally use existing kubernetes Secret for config.yml, ignores hookshot.config |
| bridges.hookshot.existingSecret.passkey | string | `""` | optionally use existing kubernetes Secret for passkey.pem, ignores hookshot.passkey |
| bridges.hookshot.existingSecret.registration | string | `""` | optionally use existing kubernetes Secret for registration |
| bridges.hookshot.image.pullPolicy | string | `"IfNotPresent"` | hookshot bridge docker image pull policy. If tag is "latest", set tag to "Always" |
| bridges.hookshot.image.repository | string | `"halfshot/matrix-hookshot"` | hookshot bridge docker image |
| bridges.hookshot.image.tag | string | `"6.0.1"` | hookshot bridge docker image tag |
| bridges.hookshot.passkey | string | `""` | If bridges.hookshot.passkey AND bridges.hookshot.existingSecret.passkey are BOTH empty strings, we will generate a passkey for you. To Generate yourself: openssl genpkey -out passkey.pem -outform PEM -algorithm RSA -pkeyopt rsa_keygen_bits:4096 |
| bridges.hookshot.podSecurityContext | object | `{}` | hookshot pod security context |
| bridges.hookshot.registration.existingSecret | string | `""` |  |
| bridges.hookshot.registration.existingSecretKeys.as_token | string | `"as_token"` | key in existingSecret for as_token (application service token) |
| bridges.hookshot.registration.existingSecretKeys.hs_token | string | `"hs_token"` | key in existingSecret for hs_token (home server token) |
| bridges.hookshot.registration.rate_limited | bool | `false` |  |
| bridges.hookshot.registration.sender_localpart | string | `"hookshot"` |  |
| bridges.hookshot.registration.url | string | `""` | This should match the bridges.hookshot.config.bridge.port in your config file |
| bridges.hookshot.replicaCount | int | `1` | hookshot bridge pod replicas |
| bridges.hookshot.resources | object | `{}` | resources limits/requests for the hookshot bridge pod |
| bridges.hookshot.revisionHistoryLimit | int | `2` | set the revisionHistoryLimit to decide how many replicaSets are kept when you change a deployment. Explicitly setting this field to 0, will result in cleaning up all the history of your Deployment thus that Deployment will not be able to roll back. |
| bridges.hookshot.securityContext | object | `{}` | hookshot container securityContext |
| bridges.hookshot.service.appservice.port | int | `9993` | appservice service port for the hookshot bridge |
| bridges.hookshot.service.metrics.port | int | `9001` | metrics service port for the hookshot bridge |
| bridges.hookshot.service.type | string | `"ClusterIP"` | service type for the hookshot bridge |
| bridges.hookshot.service.webhook.port | int | `9000` | webhook service port for the hookshot bridge |
| bridges.irc.data.capacity | string | `"1Mi"` | Size of the data PVC to allocate |
| bridges.irc.database | string | `"matrix_irc"` | Postgres database to store IRC bridge data in, this db will be created if postgresql.enabled: true, otherwise you must create it manually |
| bridges.irc.databaseSslVerify | bool | `true` |  |
| bridges.irc.enabled | bool | `false` | Set to true to enable the IRC bridge |
| bridges.irc.image.pullPolicy | string | `"IfNotPresent"` |  |
| bridges.irc.image.repository | string | `"matrixdotorg/matrix-appservice-irc"` |  |
| bridges.irc.image.tag | string | `"release-1.0.1"` |  |
| bridges.irc.presence | bool | `false` | Whether to enable presence (online/offline indicators). If presence is disabled for the homeserver (above), it should be disabled here too |
| bridges.irc.replicaCount | int | `1` |  |
| bridges.irc.resources | object | `{}` |  |
| bridges.irc.servers."chat.freenode.net".name | string | `"Freenode"` | A human-readable short name. |
| bridges.irc.servers."chat.freenode.net".port | int | `6697` | The port to connect to. Optional. |
| bridges.irc.servers."chat.freenode.net".ssl | bool | `true` | Whether to use SSL or not. Default: false. |
| bridges.irc.service.port | int | `9006` |  |
| bridges.irc.service.type | string | `"ClusterIP"` |  |
| bridges.volume.accessMode | string | `"ReadWriteMany"` | Access mode of the shared volume. ReadWriteMany is recommended to allow bridges to be scheduled on separate nodes. Some cloud providers may not allow the ReadWriteMany access mode. In that case, change this to ReadWriteOnce AND set bridges.affinity (above) to true |
| bridges.volume.capacity | string | `"1Mi"` | Capacity of the shared volume for storing bridge/appservice registration files. Note: 1Mi should be enough but some cloud providers may set a minimum PVC size of 1Gi, adjust as necessary |
| bridges.volume.existingClaim | string | `""` | name of an existing persistent volume claim to use for bridges |
| bridges.volume.storageClass | string | `""` | Storage class (optional) |
| bridges.whatsapp.bot.avatar | string | `""` | avatar of the WhatsApp bridge bot example: mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr |
| bridges.whatsapp.bot.displayName | string | `"WhatsApp bridge bot"` | display name of the WhatsApp bridge bot |
| bridges.whatsapp.bot.username | string | `"whatsappbot"` | Username of the WhatsApp bridge bot |
| bridges.whatsapp.callNotices | bool | `true` | Send notifications for incoming calls |
| bridges.whatsapp.communityName | string | `"whatsapp_{{.Localpart}}={{.Server}}"` | Display name for communities. A community will be automatically generated for each user using the bridge, and can be used to group WhatsApp chats together. Evaluated as a template, with variables: {{.Localpart}} - MXID localpart {{.Server}}    - MXID server part of the user. |
| bridges.whatsapp.connection.maxAttempts | int | `3` | Maximum number of connection attempts before failing |
| bridges.whatsapp.connection.qrRegenCount | int | `2` | Number of QR codes to store, which multiplies the connection timeout |
| bridges.whatsapp.connection.reportRetry | bool | `true` | Whether or not to notify the user when attempting to reconnect. Set to false to only report when maxAttempts has been reached |
| bridges.whatsapp.connection.retryDelay | int | `-1` | Retry delay. Negative numbers are exponential backoff: -connection_retry_delay + 1 + 2^attempts |
| bridges.whatsapp.connection.timeout | int | `20` | WhatsApp server connection timeout (seconds) |
| bridges.whatsapp.data.capacity | string | `"512Mi"` | Size of the PVC to allocate for the SQLite database |
| bridges.whatsapp.data.storageClass | string | `""` | Storage class (optional) |
| bridges.whatsapp.enabled | bool | `false` | Set to true to enable the WhatsApp bridge |
| bridges.whatsapp.image.pullPolicy | string | `"Always"` |  |
| bridges.whatsapp.image.repository | string | `"dock.mau.dev/tulir/mautrix-whatsapp"` |  |
| bridges.whatsapp.image.tag | string | `"latest"` |  |
| bridges.whatsapp.permissions | object | `{"*":"relaybot"}` | Permissions for using the bridge. Permitted values: relaybot - Talk through the relaybot (if enabled), no access otherwise     user - Access to use the bridge to chat with a WhatsApp account.    admin - User level and some additional administration tools Permitted keys:        * - All Matrix users   domain - All users on that homeserver     mxid - Specific user |
| bridges.whatsapp.relaybot.enabled | bool | `false` | Set to true to enable the relaybot and management room |
| bridges.whatsapp.relaybot.invites | list | `[]` |  |
| bridges.whatsapp.relaybot.management | string | `"!foo:example.com"` | Management room for the relay bot where status notifs are posted |
| bridges.whatsapp.replicaCount | int | `1` |  |
| bridges.whatsapp.resources | object | `{}` |  |
| bridges.whatsapp.service.port | int | `29318` |  |
| bridges.whatsapp.service.type | string | `"ClusterIP"` |  |
| bridges.whatsapp.users.displayName | string | `"{{if .Notify}}{{.Notify}}{{else}}{{.Jid}}{{end}} (WA)"` | Display name for WhatsApp users Evaluated as a template, with variables: {{.Notify}} - nickname set by the WhatsApp user {{.Jid}}    - phone number (international format) following vars are available, but cause issue on multi-user instances: {{.Name}}   - display name from contact list {{.Short}}  - short display name from contact list |
| bridges.whatsapp.users.username | string | `"whatsapp_{{.}}"` | Username for WhatsApp users. Evaluated as a template where {{.}} is replaced with the phone number of the WhatsApp user |
| coturn.allowGuests | bool | `true` | Whether to allow guests to use the TURN server |
| coturn.certificate.enabled | bool | `false` | set to true to generate a TLS certificate for encrypted comms |
| coturn.certificate.host | string | `"turn.example.com"` | hostname for TLS cert |
| coturn.certificate.issuerName | string | `"letsencrypt-staging"` | cert-manager cert Issuer or ClusterIssuer to use |
| coturn.coturn.auth.existingSecret | string | `""` | existing secret with keys username/password for coturn |
| coturn.coturn.auth.password | string | `""` | password for the main user of the turn server |
| coturn.coturn.auth.secretKeys.password | string | `"password"` | key in existing secret for turn server user's password |
| coturn.coturn.auth.secretKeys.username | string | `"username"` | key in existing secret for turn server user |
| coturn.coturn.auth.username | string | `"coturn"` | username for the main user of the turn server |
| coturn.coturn.extraTurnserverConfiguration | string | `"verbose\n"` | extra configuration for turnserver.conf |
| coturn.coturn.listeningIP | string | `"0.0.0.0"` | coturn's listening IP address |
| coturn.coturn.logFile | string | `"stdout"` | set the logfile. Defaults to stdout for use with kubectl logs |
| coturn.coturn.ports.listening | int | `3478` | insecure listening port |
| coturn.coturn.ports.max | int | `65535` | maximum ephemeral port for coturn |
| coturn.coturn.ports.min | int | `49152` | minimum ephemeral port for coturn |
| coturn.coturn.ports.tlsListening | int | `5349` | secure listening port |
| coturn.coturn.realm | string | `"turn.example.com"` | hostname for the coturn server realm |
| coturn.enabled | bool | `false` | Set to false to disable the included deployment of Coturn |
| coturn.existingSecret | string | `""` | Optional: name of an existingSecret with key for sharedSecret |
| coturn.externalDatabase.database | string | `""` | database to create, ignored if existingSecret is passed in |
| coturn.externalDatabase.enabled | bool | `false` | enables the use of postgresql instead of the default sqlite for coturn to use the bundled subchart, enable this, and postgresql.enable |
| coturn.externalDatabase.existingSecret | string | `""` | name of existing Secret to use for postgresql credentials |
| coturn.externalDatabase.hostname | string | `""` | required if externalDatabase.enabled: true and postgresql.enabled:false |
| coturn.externalDatabase.password | string | `""` | password for database, ignored if existingSecret is passed in |
| coturn.externalDatabase.secretKeys.database | string | `""` | key in existing Secret to use for the database name |
| coturn.externalDatabase.secretKeys.hostname | string | `""` | key in existing Secret to use for the db's hostname |
| coturn.externalDatabase.secretKeys.password | string | `""` | key in existing Secret to use for db user's password |
| coturn.externalDatabase.secretKeys.username | string | `""` | key in existing Secret to use for the db user |
| coturn.externalDatabase.type | string | `"postgresql"` | Currently only postgresql is supported. mysql coming soon |
| coturn.externalDatabase.username | string | `""` | username for database, ignored if existingSecret is passed in |
| coturn.image.pullPolicy | string | `"IfNotPresent"` | image pull policy, set to Always if using image.tag: latest |
| coturn.image.repository | string | `"coturn/coturn"` | container registry and repo for coturn docker image |
| coturn.image.tag | string | `""` | docker tag for coturn server |
| coturn.labels | object | `{"component":"coturn"}` | Coturn specific labels |
| coturn.persistence.accessMode | string | `"ReadWriteOnce"` | access mode for the PVC, ignored if persistence.existingClaim passed in |
| coturn.persistence.annotations | object | `{}` | annotations for the PVC, ignored if persistence.existingClaim passed in |
| coturn.persistence.existingClaim | string | `""` | existing PVC to use instead of creating one on the fly |
| coturn.persistence.size | string | `"1Mi"` | size of the PVC, ignored if persistence.existingClaim passed in |
| coturn.persistence.storageClass | string | `""` | storageClass for the PVC, ignored if persistence.existingClaim passed in |
| coturn.ports | object | `{"from":3478,"to":3478}` | UDP port range for TURN connections |
| coturn.postgresql.enabled | bool | `false` | enables bitnami postgresql subchart, you can disable to use external db |
| coturn.postgresql.global.postgresql.auth | object | `{"database":"coturn","existingSecret":"","password":"","secretKeys":{"adminPasswordKey":"postgresPassword","database":"database","hostname":"hostname","userPasswordKey":"password","username":"username"},"username":"coturn"}` | global.postgresql.auth overrides postgresql.auth |
| coturn.postgresql.global.postgresql.auth.database | string | `"coturn"` | database to create, ignored if existingSecret is passed in |
| coturn.postgresql.global.postgresql.auth.existingSecret | string | `""` | name of existing Secret to use for postgresql credentials |
| coturn.postgresql.global.postgresql.auth.password | string | `""` | password for db, autogenerated if empty & existingSecret empty |
| coturn.postgresql.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"postgresPassword"` | key in existing Secret to use for postgres admin user's password |
| coturn.postgresql.global.postgresql.auth.secretKeys.database | string | `"database"` | key in existingSecret for database to create |
| coturn.postgresql.global.postgresql.auth.secretKeys.hostname | string | `"hostname"` | key in existingSecret for database to create |
| coturn.postgresql.global.postgresql.auth.secretKeys.userPasswordKey | string | `"password"` | key in existing Secret to use for coturn user's password |
| coturn.postgresql.global.postgresql.auth.secretKeys.username | string | `"username"` | key in exsiting Secret to use for the coturn user |
| coturn.postgresql.global.postgresql.auth.username | string | `"coturn"` | username for database, ignored if existingSecret is passed in |
| coturn.resources | object | `{}` | ref: kubernetes.io/docs/concepts/configuration/manage-resources-containers |
| coturn.secretKey | string | `"coturnSharedSecret"` | key in existing secret with sharedSecret value. Required if coturn.enabled=true and existingSecret not "" |
| coturn.securityContext.allowPrivilegeEscalation | bool | `true` | allow priviledged access |
| coturn.securityContext.capabilities.add | list | `["NET_BIND_SERVICE"]` | linux cabilities to allow for the coturn k8s pod |
| coturn.securityContext.capabilities.drop | list | `["ALL"]` | linux cabilities to disallow for the coturn k8s pod |
| coturn.securityContext.fsGroup | int | `1000` | all processes of the container are also part of the supplementary groupID |
| coturn.securityContext.readOnlyRootFilesystem | bool | `false` | allow modificatin to root filesystem |
| coturn.securityContext.runAsGroup | int | `1000` | for all Containers in the Pod, all processes run w/ this GroupID |
| coturn.securityContext.runAsUser | int | `1000` | for all Containers in the Pod, all processes run w/ this userID |
| coturn.service.externalTrafficPolicy | string | `"Local"` | I don't actually know what this is 🤔 open a PR if you know |
| coturn.service.type | string | `"ClusterIP"` |  |
| coturn.sharedSecret | string | `""` | shared secert for comms b/w Synapse/Coturn. autogenerated if not provided |
| coturn.uris | list | `[]` | URIs of the Coturn servers. If deploying Coturn with this chart, include the public IPs of each node in your cluster (or a DNS round-robin hostname) You can also include an external Coturn instance if you'd prefer |
| element.branding.authFooterLinks | list | `[]` | Array of links to show at the bottom of the login screen |
| element.branding.authHeaderLogoUrl | string | `""` | Logo shown at top of login screen |
| element.branding.brand | string | `"Element"` | brand shown in email notifications |
| element.branding.welcomeBackgroundUrl | string | `""` | Background of login splash screen |
| element.enabled | bool | `true` | Set to false to disable a deployment of Element. Users will still be able to connect via any other instances of Element e.g. https://app.element.io, Element Desktop, or any other Matrix clients |
| element.image.pullPolicy | string | `"IfNotPresent"` | pullPolicy to use for element image, set to Always if using latest tag |
| element.image.repository | string | `"vectorim/element-web"` | registry and repository to use for element docker image |
| element.image.tag | string | `"v1.11.90"` | tag to use for element docker image |
| element.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt-staging"` | required for TLS certs issued by cert-manager |
| element.ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` |  |
| element.ingress.className | string | `"nginx"` | ingressClassName for the k8s ingress |
| element.ingress.enabled | bool | `true` | enable ingress for element |
| element.ingress.host | string | `"element.chart-example.local"` | the hostname to use for element |
| element.ingress.tls.enabled | bool | `true` | enable a fairly stock ingress, open a github issue if you need more features |
| element.ingress.tls.secretName | string | `"element-tls"` | name for the element tls secret for ingress |
| element.integrations.api | string | `"https://scalar.vector.im/api"` | API for the integration server |
| element.integrations.enabled | bool | `false` | enables the Integrations menu, including:    widgets, bots, and other plugins to Element    disabled by default as this is for enterprise users |
| element.integrations.ui | string | `"https://scalar.vector.im/"` | UI to load when a user selects the Integrations button at the top-right    of a room |
| element.integrations.widgets | list | `["https://scalar.vector.im/_matrix/integrations/v1","https://scalar.vector.im/api","https://scalar-staging.vector.im/_matrix/integrations/v1","https://scalar-staging.vector.im/api","https://scalar-staging.element.im/scalar/api"]` | Array of API paths providing widgets |
| element.labels | object | `{"component":"element"}` | Element specific labels |
| element.labs | list | `["feature_new_spinner","feature_pinning","feature_custom_status","feature_custom_tags","feature_state_counters","feature_many_integration_managers","feature_mjolnir","feature_dm_verification","feature_bridge_state","feature_presence_in_room_list","feature_custom_themes"]` | Experimental features in Element, see: https://github.com/vector-im/element-web/blob/develop/docs/labs.md |
| element.permalinkPrefix | string | `"https://matrix.to"` | Prefix before permalinks generated when users share links to rooms, users, or messages. If running an unfederated Synapse, set the below to the URL of your Element instance. |
| element.probes.liveness | object | `{}` |  |
| element.probes.readiness | object | `{}` |  |
| element.probes.startup | object | `{}` |  |
| element.replicaCount | int | `1` | replicas for element pods |
| element.resources | object | `{}` |  |
| element.revisionHistoryLimit | int | `2` | set the revisionHistoryLimit to decide how many replicaSets are kept when you change a deployment. Explicitly setting this field to 0, will result in cleaning up all the history of your Deployment thus that Deployment will not be able to roll back. |
| element.roomDirectoryServers | list | `["matrix.org"]` | Servers to show in the Explore menu (the current server is always shown) |
| element.service.port | int | `80` | service port for element |
| element.service.type | string | `"ClusterIP"` | service type for element |
| element.welcomeUserId | string | `""` | Set to the user ID (@username:domain.tld) of a bot to invite all new users to a DM with the bot upon registration |
| externalDatabase.database | string | `"matrix"` | name of the database to try and connect to |
| externalDatabase.enabled | bool | `false` | enable using an external database *instead of* the Bitnami PostgreSQL sub-chart if externalDatabase.enabled is set to true, postgresql.enabled must be set to false |
| externalDatabase.existingSecret | string | `""` | Name of existing secret to use for PostgreSQL credentials |
| externalDatabase.hostname | string | `""` | hostname of db server. Can be left blank if using postgres subchart |
| externalDatabase.password | string | `"changeme"` | password of matrix postgres user - ignored using exsitingSecret |
| externalDatabase.port | int | `5432` | which port to use to connect to your database server |
| externalDatabase.secretKeys.adminPasswordKey | string | `"postgresPassword"` | key in existingSecret with the admin postgresql password |
| externalDatabase.secretKeys.database | string | `"database"` | key in existingSecret with name of the database |
| externalDatabase.secretKeys.databaseHostname | string | `"hostname"` | key in existingSecret with hostname of the database |
| externalDatabase.secretKeys.databaseUsername | string | `"username"` | key in existingSecret with username for matrix to connect to db |
| externalDatabase.secretKeys.userPasswordKey | string | `"password"` | key in existingSecret with password for matrix to connect to db |
| externalDatabase.sslcert | string | `""` | optional: tls/ssl cert for postgresql connections |
| externalDatabase.sslkey | string | `""` | optional: tls/ssl key for postgresql connections |
| externalDatabase.sslmode | string | `""` | sslmode to use, example: verify-full |
| externalDatabase.sslrootcert | string | `""` | optional: tls/ssl root cert for postgresql connections |
| externalDatabase.username | string | `"matrix"` | username of matrix postgres user |
| fullnameOverride | string | `""` | override the full name of the chart |
| imagePullSecrets | list | `[]` | imagePullSecrets to use for all below images |
| mail.elementUrl | string | `""` | Optional: Element instance URL. If ingress is enabled, this is unnecessary, else if this is empty, emails will contain a link to https://app.element.io |
| mail.enabled | bool | `false` | disabled all email notifications by default. NOTE: If enabled, either enable the Exim relay or configure an external mail server below |
| mail.external.existingSecret | string | `""` | use an existing k8s Secret for your host, username, and password |
| mail.external.host | string | `""` | External mail server hostname - ignored if existingSecret not "" |
| mail.external.password | string | `""` | External mail server password - ignored if existingSecret not "" |
| mail.external.port | int | `587` | External mail server port INSECURE: 25, SSL: 465, STARTTLS: 587 |
| mail.external.requireTransportSecurity | bool | `true` | require TLS, I think |
| mail.external.secretKeys | object | `{"host":"host","password":"password","username":"username"}` | secret keys to use for your existing SMTP server |
| mail.external.username | string | `""` | External mail server username - ignored if existingSecret not "" |
| mail.from | string | `"Matrix <matrix@example.com>"` | Name and email address for outgoing mail |
| mail.relay.enabled | bool | `true` | whether to enable exim relay or not |
| mail.relay.image.pullPolicy | string | `"IfNotPresent"` |  |
| mail.relay.image.repository | string | `"devture/exim-relay"` |  |
| mail.relay.image.tag | string | `"4.95-r0"` |  |
| mail.relay.labels.component | string | `"mail"` |  |
| mail.relay.probes.liveness | object | `{}` |  |
| mail.relay.probes.readiness | object | `{}` |  |
| mail.relay.probes.startup | object | `{}` |  |
| mail.relay.replicaCount | int | `1` |  |
| mail.relay.resources | object | `{}` |  |
| mail.relay.service.port | int | `25` |  |
| mail.relay.service.type | string | `"ClusterIP"` |  |
| mas.affinity | object | `{}` |  |
| mas.autoscaling.enabled | bool | `false` |  |
| mas.autoscaling.maxReplicas | int | `100` |  |
| mas.autoscaling.minReplicas | int | `1` |  |
| mas.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| mas.configVolume.existingClaim | string | `""` | name of an existing persistent volume claim to use for matrix-authentication-service config. If provided, ignores mas parameter map |
| mas.configVolume.storage | string | `"500Mi"` | storage capacity for creating a persistent volume |
| mas.configVolume.storageClassName | string | `"default"` | name of storage class for the persistent volume |
| mas.enabled | bool | `false` | enable the MAS (Matrix Authentication Service) sub chart to use OIDC This is the only way that's tested to use with element-x beta right now You must also fill out matrix.experimental_feature.msc3861 if you use this method |
| mas.existingMasConfigSecret | string | `""` | Existing Kubernetes Secret for entire matrix authentication service `config.yaml` file. If set, everything under the mas section of the values.yaml is ignored. |
| mas.externalDatabase.database | string | `"mas"` | name of the database to try and connect to |
| mas.externalDatabase.enabled | bool | `false` | enable using an external database *instead of* the Bitnami PostgreSQL sub-chart if externalDatabase.enabled is set to true, postgresql.enabled must be set to false |
| mas.externalDatabase.existingSecret | string | `""` | Name of existing secret to use for PostgreSQL credentials |
| mas.externalDatabase.hostname | string | `""` | hostname of db server. Can be left blank if using postgres subchart |
| mas.externalDatabase.password | string | `"changeme"` | password of matrix-authentication-service postgres user - ignored using exsitingSecret |
| mas.externalDatabase.port | string | `"5432"` | which port to use to connect to your database server |
| mas.externalDatabase.secretKeys.adminPasswordKey | string | `"postgresPassword"` | key in existingSecret with the admin postgresql password |
| mas.externalDatabase.secretKeys.database | string | `"database"` | key in existingSecret with name of the database |
| mas.externalDatabase.secretKeys.databaseHostname | string | `"hostname"` | key in existingSecret with hostname of the database |
| mas.externalDatabase.secretKeys.databaseUsername | string | `"username"` | key in existingSecret with username for matrix to connect to db |
| mas.externalDatabase.secretKeys.userPasswordKey | string | `"password"` | key in existingSecret with password for matrix to connect to db |
| mas.externalDatabase.sslcert | string | `""` | optional: tls/ssl cert for postgresql connections |
| mas.externalDatabase.sslkey | string | `""` | optional: tls/ssl key for postgresql connections |
| mas.externalDatabase.sslmode | string | `""` | sslmode to use, example: verify-full |
| mas.externalDatabase.sslrootcert | string | `""` | optional: tls/ssl root cert for postgresql connections |
| mas.externalDatabase.username | string | `"mas"` | username of matrix-authentication-service postgres user |
| mas.extraVolumeMounts | list | `[]` |  |
| mas.extravolumes | list | `[]` |  |
| mas.fullnameOverride | string | `""` |  |
| mas.image.pullPolicy | string | `"IfNotPresent"` | image pull policy. if image.tag is set to "latest", set to "Always" |
| mas.image.repository | string | `"ghcr.io/matrix-org/matrix-authentication-service"` |  |
| mas.image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| mas.imagePullSecrets | list | `[]` |  |
| mas.ingress.annotations | object | `{}` |  |
| mas.ingress.className | string | `""` |  |
| mas.ingress.enabled | bool | `true` | enable ingress for matrix authentication service |
| mas.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| mas.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| mas.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| mas.ingress.tls | list | `[]` |  |
| mas.livenessProbe.enabled | bool | `false` | enable a liveness probe on the deployment |
| mas.livenessProbe.httpGet.path | string | `"/"` |  |
| mas.livenessProbe.httpGet.port | string | `"http"` |  |
| mas.mas.captcha.secret_key | string | `""` | ignored if mas.captcha.service is ~ or null |
| mas.mas.captcha.service | string | `nil` | Which service to use for CAPTCHA protection. Set to `null` (or `~`) to disable CAPTCHA protection. options are: ~, null, recaptcha_v2 (google), cloudflare_turnstile, or hcaptcha. see: https://matrix-org.github.io/matrix-authentication-service/reference/configuration.html#captcha |
| mas.mas.captcha.site_key | string | `""` | ignored if mas.captcha.service is ~ or null |
| mas.mas.clients[0] | object | `{"client_auth_method":"client_secret_basic","client_id":"0000000000000000000SYNAPSE","client_secret":"exampletest"}` | a unique identifier for the client. It must be a valid ULID, and it happens that 0000000000000000000SYNAPSE is a valid ULID. |
| mas.mas.clients[0].client_auth_method | string | `"client_secret_basic"` | set to client_secret_basic. Other methods are possible, such as client_secret_post, but this is the easiest to set up. |
| mas.mas.clients[0].client_secret | string | `"exampletest"` | a shared secret used for the homeserver to authenticate |
| mas.mas.database.connect_timeout | int | `30` |  |
| mas.mas.database.idle_timeout | int | `600` |  |
| mas.mas.database.max_connections | int | `10` |  |
| mas.mas.database.max_lifetime | int | `1800` |  |
| mas.mas.database.min_connections | int | `0` |  |
| mas.mas.database.uri | string | `""` | if blank, this can be autogenerated from mas.postgres or mas.externalDatabase settings, or you can set this to a valid [postgres URI](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNSTRING-URIS) |
| mas.mas.email.command | string | `"/usr/sbin/sendmail"` | Send emails by calling a local sendmail binary, only used if transport is sendmail |
| mas.mas.email.from | string | `"\"The almighty auth service\" <auth@example.com>"` | email.from |
| mas.mas.email.hostname | string | `"localhost"` | SMTP hostname. only used if transport is smtp |
| mas.mas.email.mode | string | `"plain"` | SMTP mode. options are plan, tls, or starttls. only used if transport is smtp |
| mas.mas.email.password | string | `"password"` | SMTP password. only used if transport is smtp |
| mas.mas.email.port | int | `587` | SMTP port. only used if transport is smtp |
| mas.mas.email.reply_to | string | `"\"No reply\" <no-reply@example.com>"` | email.reply_to |
| mas.mas.email.transport | string | `"blackhole"` | Default transport: don't send any emails, options: blackhole, smtp, sendmail, aws_ses (use AWS SESv2 API, via the AWS SDK, so the usual AWS environment variables are supported) |
| mas.mas.email.username | string | `"username"` | SMTP username. only used if transport is smtp |
| mas.mas.http.issuer | string | `""` | OIDC issuer advertised by the service. Defaults to `public_base` |
| mas.mas.http.listeners[0].binds[0].host | string | `"localhost"` |  |
| mas.mas.http.listeners[0].binds[0].port | int | `8080` |  |
| mas.mas.http.listeners[0].name | string | `"web"` |  |
| mas.mas.http.listeners[0].proxy_protocol | bool | `false` |  |
| mas.mas.http.listeners[0].resources[0].name | string | `"discovery"` |  |
| mas.mas.http.listeners[0].resources[1].name | string | `"human"` |  |
| mas.mas.http.listeners[0].resources[2].name | string | `"oauth"` |  |
| mas.mas.http.listeners[0].resources[3].name | string | `"compat"` |  |
| mas.mas.http.listeners[0].resources[4].name | string | `"graphql"` |  |
| mas.mas.http.listeners[0].resources[4].playground | bool | `true` |  |
| mas.mas.http.listeners[0].resources[5].name | string | `"assets"` |  |
| mas.mas.http.listeners[0].tls | object | `{}` | If set, makes the listener use TLS with the provided certificate and key. more info: https://matrix-org.github.io/matrix-authentication-service/reference/configuration.html#httplisteners |
| mas.mas.http.public_base | string | `""` | Public URL base used when building absolute public URLs |
| mas.mas.masClientSecret.existingSecret | string | `""` | use an existing secret for clients section of config.yaml for: mas.clients[0].client_id, mas.clients[0].client_secret if set, ignores mas.clients[0].client_id, mas.clients[0].client_secret |
| mas.mas.masClientSecret.secretKeys.client_id | string | `"client_id"` | key in secret with the client_id |
| mas.mas.masClientSecret.secretKeys.client_secret | string | `"client_secret"` | key in secret with the client_secret |
| mas.mas.matrix.endpoint | string | `"https://localhost:8008"` | endpoint of your matrix home server (synapse or dendrite) with port if needed |
| mas.mas.matrix.existingSecret | string | `""` | grab the above secret from an existing k8s secret. if set, ignores mas.matrix.secret |
| mas.mas.matrix.homeserver | string | `"localhost:8008"` | name of your matrix home server (synapse or dendrite) with port if needed |
| mas.mas.matrix.secret | string | `"test"` | a shared secret the service will use to call the homeserver admin API |
| mas.mas.matrix.secretKey | string | `"secret"` | name of the key in existing secret to grab matrix.secret from |
| mas.mas.passwords.enabled | bool | `false` | Whether to enable the password database. If disabled, users will only be able to log in using upstream OIDC providers |
| mas.mas.policy.data.admin_clients | list | `[]` | Client IDs which are allowed to ask for admin access with a client_credentials grant |
| mas.mas.policy.data.admin_users | list | `[]` | Users which are allowed to ask for admin access. If possible, use the can_request_admin flag on users instead. |
| mas.mas.policy.data.client_registration.allow_host_mismatch | bool | `true` | don't require URIs to be on the same host. default: false |
| mas.mas.policy.data.client_registration.allow_insecure_uris | bool | `true` | allow non-SSL and localhost URIs. default: false |
| mas.mas.policy.data.passwords | object | `{}` |  |
| mas.mas.upstream_oauth2.existingSecret | string | `""` | use an existing k8s secret for upstream oauth2 client_id and client_secret |
| mas.mas.upstream_oauth2.providers[0] | object | `{"authorization_endpoint":"","claims_imports":{"displayname":{"action":"suggest","template":"{{ user.name }}"},"email":{"action":"suggest","set_email_verification":"always","template":"{{ user.email }}"},"localpart":{"action":"require","template":"{{ user.preferred_username }}"},"subject":{"template":"{{ user.sub }}"}},"client_id":"","client_secret":"","discovery_mode":"oidc","id":"","issuer":"https://example.com/","jwks_uri":"","pkce_method":"auto","scope":"openid email profile","token_endpoint":"","token_endpoint_auth_method":"client_secret_basic"}` | A unique identifier for the provider Must be a valid ULID, and can be generated using online tools like: https://www.ulidtools.com |
| mas.mas.upstream_oauth2.providers[0].authorization_endpoint | string | `""` | The provider authorization endpoint, takes precedence over the discovery mechanism |
| mas.mas.upstream_oauth2.providers[0].claims_imports.displayname | object | `{"action":"suggest","template":"{{ user.name }}"}` | The display name is the user's display name. |
| mas.mas.upstream_oauth2.providers[0].claims_imports.email | object | `{"action":"suggest","set_email_verification":"always","template":"{{ user.email }}"}` | An email address to import. |
| mas.mas.upstream_oauth2.providers[0].claims_imports.email.set_email_verification | string | `"always"` | Whether the email address must be marked as verified. Possible values are:  - `import`: mark the email address as verified if the upstream provider     has marked it as verified, using the `email_verified` claim.     This is the default.   - `always`: mark the email address as verified   - `never`: mark the email address as not verified |
| mas.mas.upstream_oauth2.providers[0].claims_imports.localpart | object | `{"action":"require","template":"{{ user.preferred_username }}"}` | The localpart is the local part of the user's Matrix ID. For example, on the `example.com` server, if the localpart is `alice`,  the user's Matrix ID will be `@alice:example.com`. |
| mas.mas.upstream_oauth2.providers[0].claims_imports.subject | object | `{"template":"{{ user.sub }}"}` | The subject is an internal identifier used to link the user's provider identity to local accounts. By default it uses the `sub` claim as per the OIDC spec, which should fit most use cases. |
| mas.mas.upstream_oauth2.providers[0].client_id | string | `""` | The client ID to use to authenticate to the provider |
| mas.mas.upstream_oauth2.providers[0].client_secret | string | `""` | The client secret to use to authenticate to the provider This is only used by the `client_secret_post`, `client_secret_basic` and `client_secret_jwk` authentication methods |
| mas.mas.upstream_oauth2.providers[0].discovery_mode | string | `"oidc"` | How the provider configuration and endpoints should be discovered |
| mas.mas.upstream_oauth2.providers[0].issuer | string | `"https://example.com/"` | The issuer URL, which will be used to discover the provider's configuration. If discovery is enabled, this *must* exactly match the `issuer` field advertised in `<issuer>/.well-known/openid-configuration`. |
| mas.mas.upstream_oauth2.providers[0].jwks_uri | string | `""` | The provider JWKS URI. takes precedence over the discovery mechanism |
| mas.mas.upstream_oauth2.providers[0].pkce_method | string | `"auto"` | Whether PKCE should be used during the authorization code flow. Possible values are:  - `auto`: use PKCE if the provider supports it (default)    Determined through discovery, and disabled if discovery is disabled  - `always`: always use PKCE (with the S256 method)  - `never`: never use PKCE |
| mas.mas.upstream_oauth2.providers[0].scope | string | `"openid email profile"` | The scopes to request from the provider In most cases, it should always include `openid` scope |
| mas.mas.upstream_oauth2.providers[0].token_endpoint | string | `""` | The provider token endpoint. takes precedence over the discovery mechanism |
| mas.mas.upstream_oauth2.providers[0].token_endpoint_auth_method | string | `"client_secret_basic"` | Which authentication method to use to authenticate to the provider Supported methods are:   - `none`   - `client_secret_basic`   - `client_secret_post`   - `client_secret_jwt`   - `private_key_jwt` (using the keys defined in the `secrets.keys` section) |
| mas.mas.upstream_oauth2.secretKeys.authorization_endpoint | string | `""` | key in secret with the authorization_endpoint if discovery is disabled |
| mas.mas.upstream_oauth2.secretKeys.client_id | string | `"client_id"` | key in secret with the client_id |
| mas.mas.upstream_oauth2.secretKeys.client_secret | string | `"client_secret"` | key in secret with the client_secret |
| mas.mas.upstream_oauth2.secretKeys.issuer | string | `"issuer"` | key in secret with the issuer |
| mas.mas.upstream_oauth2.secretKeys.token_endpoint | string | `""` | key in secret with the token_endpoint if discovery is disabled |
| mas.mas.upstream_oauth2.secretKeys.userinfo_endpoint | string | `""` | key in secret with the userinfo_endpoint if discovery is disabled |
| mas.nameOverride | string | `""` |  |
| mas.networkPolicies.enabled | bool | `true` |  |
| mas.nodeSelector | object | `{}` |  |
| mas.podAnnotations | object | `{}` |  |
| mas.podLabels | object | `{}` |  |
| mas.podSecurityContext | object | `{}` |  |
| mas.postgresql.enabled | bool | `false` | Whether to deploy the Bitnami Postgresql sub chart If postgresql.enabled is set to true, externalDatabase.enabled must be set to false else if externalDatabase.enabled is set to true, postgresql.enabled must be set to false |
| mas.postgresql.global.postgresql.auth.database | string | `"mas"` | name of the database |
| mas.postgresql.global.postgresql.auth.existingSecret | string | `""` | Name of existing secret to use for PostgreSQL credentials |
| mas.postgresql.global.postgresql.auth.password | string | `"changeme"` | password of matrix-authentication-service postgres user - ignored using exsitingSecret |
| mas.postgresql.global.postgresql.auth.port | string | `"5432"` | which port to use to connect to your database server |
| mas.postgresql.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"postgresPassword"` | key in existingSecret with the admin postgresql password |
| mas.postgresql.global.postgresql.auth.secretKeys.database | string | `"database"` | key in existingSecret with name of the database |
| mas.postgresql.global.postgresql.auth.secretKeys.databaseHostname | string | `"hostname"` | key in existingSecret with hostname of the database |
| mas.postgresql.global.postgresql.auth.secretKeys.databaseUsername | string | `"username"` | key in existingSecret with username for matrix-authentication-service to connect to db |
| mas.postgresql.global.postgresql.auth.secretKeys.userPasswordKey | string | `"password"` | key in existingSecret with password for matrix-authentication-service to connect to db |
| mas.postgresql.global.postgresql.auth.username | string | `"mas"` | username of matrix-authentication-service postgres user |
| mas.postgresql.primary.initdb | object | `{"scriptsConfigMap":"{{ .Release.Name }}-postgresql-initdb"}` | run the scripts in templates/postgresql/initdb-configmap.yaml If using an external Postgres server, make sure to configure the database ref: https://github.com/element-hq/synapse/blob/develop/docs/postgres.md |
| mas.postgresql.primary.podSecurityContext.enabled | bool | `true` |  |
| mas.postgresql.primary.podSecurityContext.fsGroup | int | `1000` |  |
| mas.postgresql.primary.podSecurityContext.runAsUser | int | `1000` |  |
| mas.postgresql.tls.autoGenerated | bool | `false` | Generate automatically self-signed TLS certificates |
| mas.postgresql.tls.certCAFilename | string | `""` | CA Certificate filename |
| mas.postgresql.tls.certFilename | string | `""` | Certificate filename |
| mas.postgresql.tls.certKeyFilename | string | `""` | Certificate key filename |
| mas.postgresql.tls.certificatesSecret | string | `""` | Name of an existing secret that contains the certificates |
| mas.postgresql.tls.crlFilename | string | `""` | File containing a Certificate Revocation List |
| mas.postgresql.tls.enabled | bool | `false` | Enable TLS traffic support for postgresql, see [bitnami/charts/postgresql#securing-traffic-using-tls](https://github.com/bitnami/charts/tree/main/bitnami/postgresql#securing-traffic-using-tls) |
| mas.postgresql.tls.preferServerCiphers | bool | `true` | Whether to use the server's TLS cipher preferences rather than the client's |
| mas.postgresql.volumePermissions.enabled | bool | `true` | Enable init container that changes the owner and group of the PVC |
| mas.readinessProbe.enabled | bool | `false` | enable a readiness probe on the deployment |
| mas.readinessProbe.httpGet.path | string | `"/"` |  |
| mas.readinessProbe.httpGet.port | string | `"http"` |  |
| mas.replicaCount | int | `1` |  |
| mas.resources | object | `{}` |  |
| mas.securityContext | object | `{}` |  |
| mas.service.annotations | object | `{}` | annotations for your service |
| mas.service.port | int | `80` | Port of service |
| mas.service.targetPort | int | `8080` | targetPort of service. should be the same as port for bindaddr |
| mas.service.type | string | `"ClusterIP"` | type of service |
| mas.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| mas.serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| mas.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| mas.serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| mas.tolerations | list | `[]` |  |
| matrix.adminEmail | string | `"admin@example.com"` | Email address of the administrator |
| matrix.allow_public_rooms_over_federation | bool | `false` | Allow members of other homeservers to fetch *public* rooms |
| matrix.allow_public_rooms_without_auth | bool | `false` | If set to true, removes the need for authentication to access the server's public rooms directory through the client API, meaning that anyone can query the room directory |
| matrix.blockNonAdminInvites | bool | `false` | Set to true to block non-admins from inviting users to any rooms |
| matrix.disabled | bool | `false` | Set to true to globally block access to the homeserver |
| matrix.disabledMessage | string | `""` | Human readable reason for why the homeserver is blocked |
| matrix.encryptByDefault | string | `"invite"` | Which types of rooms to enable end-to-end encryption on by default. options: off (none), all (all rooms), or invite (private msg/room created w/ private_chat or trusted_private_chat room presets) |
| matrix.experimental_features.msc3861.account_management_url | string | `""` | URL to advertise to clients where users can self-manage their account this is typically https://your-mas-domain.com/account |
| matrix.experimental_features.msc3861.admin_token | string | `"AnotherRandomSecret"` | Matches the `mas.mas.matrix.secret` in the auth service config |
| matrix.experimental_features.msc3861.client_auth_method | string | `"client_secret_basic"` | Matches the `client_auth_method` in the auth service config |
| matrix.experimental_features.msc3861.client_id | string | `"0000000000000000000SYNAPSE"` | Matches the `mas.mas.clients[0].client_id` in the auth service config |
| matrix.experimental_features.msc3861.client_secret | string | `"SomeRandomSecret"` | Matches the `mas.mas.clients[0].client_secret` in the auth service config |
| matrix.experimental_features.msc3861.enabled | bool | `false` | experimental_feature msc3861 - enable this if you want to use the matrix authentication service Likely needed if using OIDC on synapse and you want to allow usage of Element-X (the beta of element) See: [Matrix authentication service home server docs](https://matrix-org.github.io/matrix-authentication-service/setup/homeserver.html#configure-the-homeserver-to-delegate-authentication-to-the-service), [full matrix authentication service docs](https://matrix-org.github.io/matrix-authentication-service/index.html), and [issue#1915](https://github.com/element-hq/element-meta/issues/1915#issuecomment-2119297748) where this is being discussed |
| matrix.experimental_features.msc3861.issuer | string | `"http://localhost:8080/"` | Synapse will call `{issuer}/.well-known/openid-configuration` to get the OIDC configuration |
| matrix.extra_well_known_client_content | object | `{}` | extra sections for the your /.well-known/matrix/client which returns json used by clients to know where your matrix sliding sync server is |
| matrix.federation.client_timeout | string | `"60s"` | timeout for the federation requests |
| matrix.federation.destination_max_retry_interval | string | `"1w"` | a cap on the backoff. Defaults to a week |
| matrix.federation.destination_min_retry_interval | string | `"10m"` | the initial backoff, after the first request fails |
| matrix.federation.destination_retry_multiplier | int | `2` | how much we multiply the backoff by after each subsequent fail |
| matrix.federation.enabled | bool | `false` | Set to true to enable federation |
| matrix.federation.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt-staging"` | required for TLS certs issued by cert-manager |
| matrix.federation.ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` | required for the Nginx ingress provider. You can remove it if you use a different ingress provider |
| matrix.federation.ingress.className | string | `"nginx"` | ingressClassName for the k8s ingress |
| matrix.federation.ingress.enabled | bool | `false` | enable ingress for federation |
| matrix.federation.ingress.host | string | `"matrix-fed.chart-example.local"` |  |
| matrix.federation.ingress.tls.enabled | bool | `true` | enable a TLS cert |
| matrix.federation.max_long_retries | int | `10` | maximum number of retries for the long retry algo |
| matrix.federation.max_long_retry_delay | string | `"60s"` | maximum delay to be used for the short retry algo |
| matrix.federation.max_short_retries | int | `3` | maximum number of retries for the short retry algo |
| matrix.federation.max_short_retry_delay | string | `"2s"` | maximum delay to be used for the short retry algo |
| matrix.federation_client_minimum_tls_version | float | `1.2` | minimum required tls version support. set to 1.3 if you know all clients implement this. may break public servers |
| matrix.federation_domain_whitelist | list | `[]` | Restrict federation to the given whitelist of domains. N.B. we recommend also firewalling your federation listener to limit inbound federation traffic as early as possible, rather than relying purely on this application-layer restriction. If not specified, the default is to whitelist everythingNote Note: this does not stop a server from joining rooms that servers not on the whitelist are in. As such, this option is really only useful to establish a "private federation", where a group of servers all whitelist each other and have the same whitelist. |
| matrix.homeserverExtra | object | `{}` | Contents will be appended to the end of the default configuration |
| matrix.homeserverOverride | object | `{}` | Manual overrides for homeserver.yaml, the main config file for Synapse Its highly recommended that you take a look at the defaults in templates/synapse/_homeserver.yaml, to get a sense of the requirements and default config options to use other services in this chart. |
| matrix.hostname | string | `""` | Hostname where Synapse can be reached, e.g. matrix.mydomain.com |
| matrix.ip_range_blacklist | list | `["127.0.0.0/8","10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","100.64.0.0/10","192.0.0.0/24","169.254.0.0/16","192.88.99.0/24","198.18.0.0/15","192.0.2.0/24","198.51.100.0/24","203.0.113.0/24","224.0.0.0/4","::1/128","fe80::/10","fc00::/7","2001:db8::/32","ff00::/8","fec0::/10"]` | This option prevents outgoing requests from being sent to the specified blacklisted IP address CIDR ranges. If this option is not specified then it defaults to private IP address ranges (see the example below). The blacklist applies to the outbound requests for federation, identity servers, push servers, and for checking key validity for third-party invite events. (0.0.0.0 and :: are always blacklisted, whether or not they are explicitly listed here, since they correspond to unroutable addresses.) This option replaces federation_ip_range_blacklist in Synapse v1.25.0. Note: The value is ignored when an HTTP proxy is in use. |
| matrix.limit_profile_requests_to_users_who_share_rooms | bool | `true` | require a user to share a room with another user in order to retrieve their profile information. Only checked on Client-Server requests. Profile requests from other servers should be checked by the requesting server. |
| matrix.logging.rootLogLevel | string | `"WARNING"` | Root log level is the default log level for log outputs that don't have more specific settings. |
| matrix.logging.sqlLogLevel | string | `"WARNING"` | beware: increasing this to DEBUG will make synapse log sensitive information such as access tokens. |
| matrix.logging.synapseLogLevel | string | `"WARNING"` | The log level for the synapse server |
| matrix.msc3861ExistingSecret | string | `""` | use an existing secret for all msc3861 (matrix authentication service) related values if set, all other msc3861 values are ignored (issuer, client_id, client_auth_method, client_secret, admin_token, account_management_url) |
| matrix.msc3861SecretKeys.account_management_url | string | `""` | secret key to use in existing secret for msc3861 account_management_url |
| matrix.msc3861SecretKeys.admin_token | string | `""` | secret key to use in existing secret for msc3861 admin_token |
| matrix.msc3861SecretKeys.client_id | string | `""` | secret key to use in existing secret for msc3861 client id |
| matrix.msc3861SecretKeys.client_secret | string | `""` | secret key to use in existing secret for msc3861 client secret |
| matrix.msc3861SecretKeys.issuer | string | `""` | secret key to use in existing secret for msc3861 issuer |
| matrix.oidc.enabled | bool | `false` | set to true to enable authorization against an OpenID Connect server unless using OIDC on synapse AND you want to allow usage of Element-X (the beta of element), then you must set experimental_feature.msc3861.enabled to True to use the MAS (Matrix Authentication Service) and fill out the values there. |
| matrix.oidc.existingSecret | string | `""` | existing secret to use for the OIDC config |
| matrix.oidc.providers | list | `[{"authorization_endpoint":"https://accounts.example.com/oauth2/auth","backchannel_logout_enabled":true,"client_auth_method":"client_secret_post","client_id":"provided-by-your-issuer","client_secret":"provided-by-your-issuer","discover":true,"idp_brand":"","idp_id":"","idp_name":"","issuer":"https://accounts.example.com/","scopes":["openid","profile"],"skip_verification":false,"token_endpoint":"https://accounts.example.com/oauth2/token","user_mapping_provider":{"config":{"display_name_template":"","localpart_template":"","picture_template":"{{ user.data.profile_image_url }}","subject_claim":""}},"userinfo_endpoint":"https://accounts.example.com/userinfo"}]` | each of these will be templated under oidc_providers in homeserver.yaml ref: https://element-hq.github.io/synapse/latest/openid.html?search= |
| matrix.oidc.providers[0] | object | `{"authorization_endpoint":"https://accounts.example.com/oauth2/auth","backchannel_logout_enabled":true,"client_auth_method":"client_secret_post","client_id":"provided-by-your-issuer","client_secret":"provided-by-your-issuer","discover":true,"idp_brand":"","idp_id":"","idp_name":"","issuer":"https://accounts.example.com/","scopes":["openid","profile"],"skip_verification":false,"token_endpoint":"https://accounts.example.com/oauth2/token","user_mapping_provider":{"config":{"display_name_template":"","localpart_template":"","picture_template":"{{ user.data.profile_image_url }}","subject_claim":""}},"userinfo_endpoint":"https://accounts.example.com/userinfo"}` | id of your identity provider, e.g. dex |
| matrix.oidc.providers[0].authorization_endpoint | string | `"https://accounts.example.com/oauth2/auth"` | oauth2 authorization endpoint. Required if provider discovery disabled. |
| matrix.oidc.providers[0].backchannel_logout_enabled | bool | `true` | optional - maybe useful for keycloak |
| matrix.oidc.providers[0].client_auth_method | string | `"client_secret_post"` | auth method to use when exchanging the token. Valid values are: 'client_secret_basic' (default), 'client_secret_post' and 'none'. |
| matrix.oidc.providers[0].client_id | string | `"provided-by-your-issuer"` | oauth2 client id to use. Required if 'enabled' is true. |
| matrix.oidc.providers[0].client_secret | string | `"provided-by-your-issuer"` | oauth2 client secret to use. Required if 'enabled' is true. |
| matrix.oidc.providers[0].discover | bool | `true` | turn off discovery by setting this to false |
| matrix.oidc.providers[0].idp_brand | string | `""` | optional styling hint for clients |
| matrix.oidc.providers[0].idp_name | string | `""` | human readable comment of your identity provider, e.g. "My Dex Server" |
| matrix.oidc.providers[0].issuer | string | `"https://accounts.example.com/"` | OIDC issuer. Used to validate tokens and (if discovery is enabled) to discover the provider's endpoints. Required if 'enabled' is true. |
| matrix.oidc.providers[0].scopes | list | `["openid","profile"]` | list of scopes to request. should normally include the "openid" scope. Defaults to ["openid"]. |
| matrix.oidc.providers[0].token_endpoint | string | `"https://accounts.example.com/oauth2/token"` | the oauth2 token endpoint. Required if provider discovery is disabled. |
| matrix.oidc.providers[0].user_mapping_provider.config.display_name_template | string | `""` | Jinja2 template for the display name to set on first login. If unset, no displayname will be set. |
| matrix.oidc.providers[0].user_mapping_provider.config.localpart_template | string | `""` | This must be configured if using the default mapping provider. |
| matrix.oidc.providers[0].user_mapping_provider.config.subject_claim | string | `""` | name of the claim containing a unique identifier for user. Defaults to `sub`, which OpenID Connect compliant providers should provide. |
| matrix.oidc.providers[0].userinfo_endpoint | string | `"https://accounts.example.com/userinfo"` | the OIDC userinfo endpoint. Required if discovery is disabled and the "openid" scope is not requested. |
| matrix.oidc.secretKeys.authorization_endpoint | string | `""` | key in secret with the authorization_endpoint if discovery is disabled |
| matrix.oidc.secretKeys.client_id | string | `"client_id"` | key in secret with the client_id |
| matrix.oidc.secretKeys.client_secret | string | `"client_secret"` | key in secret with the client_secret |
| matrix.oidc.secretKeys.issuer | string | `"issuer"` | key in secret with the issuer |
| matrix.oidc.secretKeys.token_endpoint | string | `""` | key in secret with the token_endpoint if discovery is disabled |
| matrix.oidc.secretKeys.userinfo_endpoint | string | `""` | key in secret with the userinfo_endpoint if discovery is disabled |
| matrix.password_config | object | `{}` |  |
| matrix.presence | bool | `true` | Set to false to disable presence (online/offline indicators) |
| matrix.registration.allowGuests | bool | `false` | Allow users to join rooms as a guest |
| matrix.registration.autoJoinRooms | list | `[]` | Rooms to automatically join all new users to |
| matrix.registration.enabled | bool | `false` | Allow new users to register an account |
| matrix.registration.existingSecret | string | `""` | if set, pull sharedSecret from an existing k8s secret |
| matrix.registration.generateSharedSecret | bool | `false` | if set, allows user to generate a random shared secret in a k8s secret ignored if existingSecret is passed in |
| matrix.registration.requiresToken | bool | `false` | Whether to allow token based registration |
| matrix.registration.secretKey | string | `"registrationSharedSecret"` | key in existing k8s secret for registration shared secret |
| matrix.registration.sharedSecret | string | `""` | If set, allows registration of standard or admin accounts by anyone who has the shared secret, even if registration is otherwise disabled. ignored if existingSecret is passed in |
| matrix.require_auth_for_profile_requests | bool | `true` | require auth for profile requests, not useful if federation is enable |
| matrix.retentionPeriod | string | `"7d"` | How long to keep redacted events in unredacted form in the database |
| matrix.search | bool | `true` | Set to false to disable message searching |
| matrix.security.surpressKeyServerWarning | bool | `true` |  |
| matrix.security.trustedKeyServers | list | `[]` |  |
| matrix.security.trustedKeyServersExistingSecret | string | `""` | use an existing Kubernetes Secret for trusted server list instead of matrix.security.trustedKeyServers |
| matrix.security.trustedKeyServersSecretKey | string | `"trustedKeys"` | key in existing Kubernetes Secret for trusted server list |
| matrix.serve_server_wellknown | bool | `false` | By default, other servers will try to reach our server on port 8448, which can be inconvenient in some environments. Provided https://<server_name>/ on port 443 is routed to Synapse, this option configures Synapse to serve a file at https://<server_name>/.well-known/matrix/server. This will tell other servers to send traffic to port 443 instead |
| matrix.serverName | string | `"example.com"` | Domain name of the server: This is not necessarily the host name where the service is reachable. In fact, you may want to omit any subdomains from this value as the server name set here will be the name of your homeserver in the fediverse, & will be the domain name at the end of every username |
| matrix.telemetry | bool | `false` | Enable anonymous telemetry to matrix.org |
| matrix.uploads | object | `{"maxPixels":"32M","maxSize":"10M"}` | Settings related to image and multimedia uploads |
| matrix.uploads.maxPixels | string | `"32M"` | Max image size in pixels |
| matrix.uploads.maxSize | string | `"10M"` | Max upload size in bytes |
| matrix.urlPreviews.enabled | bool | `false` | Enable URL previews. WARN: Make sure to review default rules below to ensure that users cannot crawl sensitive internal endpoints on yr cluster |
| matrix.urlPreviews.rules.ip.blacklist[0] | string | `"127.0.0.0/8"` |  |
| matrix.urlPreviews.rules.ip.blacklist[1] | string | `"10.0.0.0/8"` |  |
| matrix.urlPreviews.rules.ip.blacklist[2] | string | `"172.16.0.0/12"` |  |
| matrix.urlPreviews.rules.ip.blacklist[3] | string | `"192.168.0.0/16"` |  |
| matrix.urlPreviews.rules.ip.blacklist[4] | string | `"100.64.0.0/10"` |  |
| matrix.urlPreviews.rules.ip.blacklist[5] | string | `"169.254.0.0/16"` |  |
| matrix.urlPreviews.rules.ip.blacklist[6] | string | `"::1/128"` |  |
| matrix.urlPreviews.rules.ip.blacklist[7] | string | `"fe80::/64"` |  |
| matrix.urlPreviews.rules.ip.blacklist[8] | string | `"fc00::/7"` |  |
| matrix.urlPreviews.rules.ip.whitelist | list | `[]` |  |
| matrix.urlPreviews.rules.maxSize | string | `"10M"` | Max size of a crawlable page. Keep this low to prevent a DOS vector |
| matrix.urlPreviews.rules.url | object | `{}` | Whitelist and blacklist based on URL pattern matching |
| nameOverride | string | `""` | override the name of the chart |
| networkPolicies.enabled | bool | `true` | whether to enable kubernetes network policies or not |
| postgresql.enabled | bool | `true` | Whether to deploy the Bitnami Postgresql sub chart If postgresql.enabled is set to true, externalDatabase.enabled must be set to false else if externalDatabase.enabled is set to true, postgresql.enabled must be set to false |
| postgresql.global.postgresql.auth.existingSecret | string | `""` | Name of existing secret to use for PostgreSQL credentials |
| postgresql.global.postgresql.auth.password | string | `"changeme"` | password of matrix postgres user - ignored using exsitingSecret |
| postgresql.global.postgresql.auth.port | int | `5432` | which port to use to connect to your database server |
| postgresql.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"postgresPassword"` | key in existingSecret with the admin postgresql password |
| postgresql.global.postgresql.auth.secretKeys.database | string | `"database"` | key in existingSecret with name of the database |
| postgresql.global.postgresql.auth.secretKeys.databaseHostname | string | `"hostname"` | key in existingSecret with hostname of the database |
| postgresql.global.postgresql.auth.secretKeys.databaseUsername | string | `"username"` | key in existingSecret with username for matrix to connect to db |
| postgresql.global.postgresql.auth.secretKeys.userPasswordKey | string | `"password"` | key in existingSecret with password for matrix to connect to db |
| postgresql.global.postgresql.auth.username | string | `"matrix"` | username of matrix postgres user |
| postgresql.persistence.enabled | bool | `false` |  |
| postgresql.primary.initdb | object | `{"scriptsConfigMap":"{{ .Release.Name }}-postgresql-initdb"}` | run the scripts in templates/postgresql/initdb-configmap.yaml If using an external Postgres server, make sure to configure the database ref: https://github.com/element-hq/synapse/blob/develop/docs/postgres.md |
| postgresql.primary.podSecurityContext.enabled | bool | `true` |  |
| postgresql.primary.podSecurityContext.fsGroup | int | `1000` |  |
| postgresql.primary.podSecurityContext.runAsUser | int | `1000` |  |
| postgresql.volumePermissions.enabled | bool | `true` | Enable init container that changes the owner and group of the PVC |
| s3.bucket | string | `""` | name of the bucket to use |
| s3.cronjob.enabled | bool | `false` | enable a regular cleanup k8s cronjob to automatically backup everything to your s3 bucket for you and delete it from local disk ref: https://github.com/matrix-org/synapse-s3-storage-provider/tree/main#regular-cleanup-job |
| s3.cronjob.file_age | string | `"2m"` | this is the age of files you'd like to clean up, defaults files not used within two months (2m) |
| s3.cronjob.schedule | string | `"0 0 * * *"` | cron schedule to run the k8s cronjob. Defaults to every day at midnight |
| s3.enabled | bool | `false` | enable s3 storage via https://github.com/matrix-org/synapse-s3-storage-provider |
| s3.endpoint | string | `""` | your s3 endpoint |
| s3.existingSecret | string | `""` | use credentials from an existing kubernetes secret |
| s3.region | string | `""` | optional region to use for s3 |
| s3.secretKeys.accessKey | string | `"S3_ACCESS_KEY"` | key in existing secret fo the S3 key |
| s3.secretKeys.secretKey | string | `"S3_SECRET_KEY"` | key in existing secret fo the S3 secret |
| s3.sse_algorithm | string | `"AES256"` | optional SSE-C algorithm - very likely AES256 |
| s3.sse_c_key | string | `""` | optional Server Side Encryption for Customer-provided keys |
| synapse.extraEnv | list | `[]` | optiona: extra env variables to pass to the matrix synapse deployment |
| synapse.extraVolumeMounts | list | `[]` | optional: extra volume mounts for the matrix synapse deployment |
| synapse.extraVolumes | list | `[]` | optional: extra volumes for the matrix synapse deployment |
| synapse.image.pullPolicy | string | `"IfNotPresent"` | pullPolicy for synapse image, Use Always if using image.tag: latest |
| synapse.image.repository | string | `"matrixdotorg/synapse"` | image registry and repository to use for synapse |
| synapse.image.tag | string | `""` | tag of synapse docker image to use. change this to latest to grab the    cutting-edge release of synapse |
| synapse.ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` | This annotation is required for the Nginx ingress provider. You can remove it if you use a different ingress provider |
| synapse.ingress.className | string | `"nginx"` | ingressClassName for the k8s ingress |
| synapse.ingress.enabled | bool | `true` | enable ingress for synapse, so the server is reachable outside the cluster |
| synapse.ingress.hosts[0].host | string | `"matrix.chart-example.local"` |  |
| synapse.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| synapse.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| synapse.ingress.tls | list | `[]` | enable tls for synapse ingress |
| synapse.labels | object | `{"component":"synapse"}` | Labels to be appended to all Synapse resources |
| synapse.metrics.annotations | bool | `true` |  |
| synapse.metrics.enabled | bool | `true` | Whether Synapse should capture metrics on an additional endpoint |
| synapse.metrics.port | int | `9092` | Port to listen on for metrics scraping |
| synapse.metrics.serviceMonitor.enabled | bool | `false` | enable a prometheus ServiceMonitor to send metrics to prometheus |
| synapse.podSecurityContext | object | `{"env":false,"fsGroup":1000,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000}` | securityContext for the entire synapse pod, including the all containers Does not work by default in all cloud providers, disable by default |
| synapse.podSecurityContext.env | bool | `false` | Enable if your k8s environment allows containers to chuser/setuid https://github.com/matrix-org/synapse/blob/96cf81e312407f0caba1b45ba9899906b1dcc098/docker/start.py#L196 |
| synapse.podSecurityContext.fsGroup | int | `1000` | A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod: 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw---- If unset, the Kubelet will not modify the ownership and permissions of any volume. Note that this field cannot be set when spec.os.name is windows. |
| synapse.podSecurityContext.runAsGroup | int | `1000` | group ID to run the synapse POD as |
| synapse.podSecurityContext.runAsNonRoot | bool | `true` | Indicates that the pod's containers must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. |
| synapse.podSecurityContext.runAsUser | int | `1000` | user ID to run the synapse POD as |
| synapse.probes.liveness.periodSeconds | int | `10` | liveness probe seconds trying again |
| synapse.probes.liveness.timeoutSeconds | int | `5` | liveness probe seconds before timing out |
| synapse.probes.readiness.periodSeconds | int | `10` | readiness probe seconds trying again |
| synapse.probes.readiness.timeoutSeconds | int | `5` | readiness probe seconds before timing out |
| synapse.probes.startup.failureThreshold | int | `6` | startup probe times to try and fail before giving up |
| synapse.probes.startup.periodSeconds | int | `5` | startup probe seconds trying again |
| synapse.probes.startup.timeoutSeconds | int | `5` | startup probe seconds before timing out |
| synapse.replicaCount | int | `1` | replica count of the synapse pods |
| synapse.resources | object | `{}` | resource requests and limits for synapse |
| synapse.revisionHistoryLimit | int | `2` | set the revisionHistoryLimit to decide how many replicaSets are kept when you change a deployment. Explicitly setting this field to 0, will result in cleaning up all the history of your Deployment thus that Deployment will not be able to roll back. |
| synapse.securityContext | object | `{"allowPrivilegeEscalation":false,"readOnlyRootFilesystem":false,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000}` | securityContext for the synapse CONTAINER ONLY Does not work by default in all cloud providers, disable by default |
| synapse.securityContext.allowPrivilegeEscalation | bool | `false` | AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN Note that this field cannot be set when spec.os.name is windows. |
| synapse.securityContext.readOnlyRootFilesystem | bool | `false` | Whether this container has a read-only root filesystem. Default is false. Note that this field cannot be set when spec.os.name is windows. |
| synapse.securityContext.runAsGroup | int | `1000` | group ID to run the synapse container as |
| synapse.securityContext.runAsNonRoot | bool | `true` | Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. |
| synapse.securityContext.runAsUser | int | `1000` | user ID to run the synapse container as |
| synapse.service.federation.port | int | `80` |  |
| synapse.service.federation.type | string | `"ClusterIP"` |  |
| synapse.service.port | int | `80` | service port for synapse |
| synapse.service.type | string | `"ClusterIP"` | service type for synpase |
| volumes.extraPipPackages.capacity | string | `"100Mi"` | Capacity of the extra pip packages PVC. Note: 1Mi is more than enough, but some cloud providers set a min PVC size of 1Mi or 1Gi, adjust as necessary |
| volumes.extraPipPackages.existingClaim | string | `""` | name of an existing persistent volume claim for the extra pip packages |
| volumes.extraPipPackages.storageClass | string | `""` | Storage class (optional) |
| volumes.media.capacity | string | `"10Gi"` | Capacity of the media PVC - ignored if using exsitingClaim |
| volumes.media.existingClaim | string | `""` | name of an existing PVC to use for uploaded attachments and multimedia |
| volumes.media.storageClass | string | `""` | Storage class of the media PVC - ignored if using exsitingClaim |
| volumes.signingKey.capacity | string | `"1Mi"` | Capacity of the signing key PVC. Note: 1Mi is more than enough, but some cloud providers set a min PVC size of 1Mi or 1Gi, adjust as necessary |
| volumes.signingKey.existingClaim | string | `""` | name of an existing persistent volume claim to use for signing key |
| volumes.signingKey.storageClass | string | `""` | Storage class (optional) |
| volumes.synapseConfig.capacity | string | `"1Mi"` | Capacity of the signing key PVC. Note: 1Mi is more than enough, but some cloud providers set a min PVC size of 1Mi or 1Gi, adjust as necessary |
| volumes.synapseConfig.existingClaim | string | `""` | name of an existing persistent volume claim for synapse config file |
| volumes.synapseConfig.storageClass | string | `""` | Storage class (optional) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
