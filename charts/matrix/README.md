# matrix

![Version: 3.0.0](https://img.shields.io/badge/Version-3.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.68.0](https://img.shields.io/badge/AppVersion-1.68.0-informational?style=flat-square)

A Helm chart to deploy a Matrix homeserver stack into Kubernetes

**Homepage:** <https://github.com/jessebot/matrix-chart>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| David Cruz | <david@typokign.com> | <https://github.com/dacruz21/> |
| Rhea Danzey | <rhea@isomemetric.com> | <https://github.com/Arkaniad/> |
| Jesse Hitch | <jessebot@linux.com> | <https://github.com/jessebot/> |

## Source Code

* <https://github.com/jessebot/matrix-chart>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 12.6.8 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bridges.affinity | bool | `false` |  |
| bridges.discord.auth.botToken | string | `""` |  |
| bridges.discord.auth.clientId | string | `""` |  |
| bridges.discord.channelName | string | `"[Discord] :guild :name"` |  |
| bridges.discord.data.capacity | string | `"512Mi"` |  |
| bridges.discord.data.storageClass | string | `""` |  |
| bridges.discord.defaultVisibility | string | `"public"` |  |
| bridges.discord.enabled | bool | `false` |  |
| bridges.discord.image.pullPolicy | string | `"Always"` |  |
| bridges.discord.image.repository | string | `"halfshot/matrix-appservice-discord"` |  |
| bridges.discord.image.tag | string | `"latest"` |  |
| bridges.discord.joinLeaveEvents | bool | `true` |  |
| bridges.discord.presence | bool | `true` |  |
| bridges.discord.readReceipt | bool | `true` |  |
| bridges.discord.replicaCount | int | `1` |  |
| bridges.discord.resources | object | `{}` |  |
| bridges.discord.selfService | bool | `false` |  |
| bridges.discord.service.port | int | `9005` |  |
| bridges.discord.service.type | string | `"ClusterIP"` |  |
| bridges.discord.typingNotifications | bool | `true` |  |
| bridges.discord.users.nickname | string | `":nick"` |  |
| bridges.discord.users.username | string | `":username#:tag"` |  |
| bridges.irc.data.capacity | string | `"1Mi"` |  |
| bridges.irc.database | string | `"matrix_irc"` |  |
| bridges.irc.databaseSslVerify | bool | `true` |  |
| bridges.irc.enabled | bool | `false` |  |
| bridges.irc.image.pullPolicy | string | `"IfNotPresent"` |  |
| bridges.irc.image.repository | string | `"matrixdotorg/matrix-appservice-irc"` |  |
| bridges.irc.image.tag | string | `"release-0.22.0-rc1"` |  |
| bridges.irc.presence | bool | `false` |  |
| bridges.irc.replicaCount | int | `1` |  |
| bridges.irc.resources | object | `{}` |  |
| bridges.irc.servers."chat.freenode.net".name | string | `"Freenode"` |  |
| bridges.irc.servers."chat.freenode.net".port | int | `6697` |  |
| bridges.irc.servers."chat.freenode.net".ssl | bool | `true` |  |
| bridges.irc.service.port | int | `9006` |  |
| bridges.irc.service.type | string | `"ClusterIP"` |  |
| bridges.volume.accessMode | string | `"ReadWriteMany"` |  |
| bridges.volume.capacity | string | `"1Mi"` |  |
| bridges.volume.storageClass | string | `""` |  |
| bridges.whatsapp.bot.avatar | string | `"mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr"` |  |
| bridges.whatsapp.bot.displayName | string | `"WhatsApp bridge bot"` |  |
| bridges.whatsapp.bot.username | string | `"whatsappbot"` |  |
| bridges.whatsapp.callNotices | bool | `true` |  |
| bridges.whatsapp.communityName | string | `"whatsapp_{{.Localpart}}={{.Server}}"` |  |
| bridges.whatsapp.connection.maxAttempts | int | `3` |  |
| bridges.whatsapp.connection.qrRegenCount | int | `2` |  |
| bridges.whatsapp.connection.reportRetry | bool | `true` |  |
| bridges.whatsapp.connection.retryDelay | int | `-1` |  |
| bridges.whatsapp.connection.timeout | int | `20` |  |
| bridges.whatsapp.data.capacity | string | `"512Mi"` |  |
| bridges.whatsapp.data.storageClass | string | `""` |  |
| bridges.whatsapp.enabled | bool | `false` |  |
| bridges.whatsapp.image.pullPolicy | string | `"Always"` |  |
| bridges.whatsapp.image.repository | string | `"dock.mau.dev/tulir/mautrix-whatsapp"` |  |
| bridges.whatsapp.image.tag | string | `"latest"` |  |
| bridges.whatsapp.permissions.* | string | `"relaybot"` |  |
| bridges.whatsapp.relaybot.enabled | bool | `false` |  |
| bridges.whatsapp.relaybot.invites | list | `[]` |  |
| bridges.whatsapp.relaybot.management | string | `"!foo:example.com"` |  |
| bridges.whatsapp.replicaCount | int | `1` |  |
| bridges.whatsapp.resources | object | `{}` |  |
| bridges.whatsapp.service.port | int | `29318` |  |
| bridges.whatsapp.service.type | string | `"ClusterIP"` |  |
| bridges.whatsapp.users.displayName | string | `"{{if .Notify}}{{.Notify}}{{else}}{{.Jid}}{{end}} (WA)"` |  |
| bridges.whatsapp.users.username | string | `"whatsapp_{{.}}"` |  |
| coturn.allowGuests | bool | `true` |  |
| coturn.enabled | bool | `true` |  |
| coturn.image.pullPolicy | string | `"IfNotPresent"` |  |
| coturn.image.repository | string | `"instrumentisto/coturn"` |  |
| coturn.image.tag | string | `"4.5.1.3"` |  |
| coturn.kind | string | `"DaemonSet"` |  |
| coturn.labels.component | string | `"coturn"` |  |
| coturn.ports.from | int | `49152` |  |
| coturn.ports.to | int | `49172` |  |
| coturn.replicaCount | int | `1` |  |
| coturn.resources | object | `{}` |  |
| coturn.service.type | string | `"ClusterIP"` |  |
| coturn.sharedSecret | string | `""` |  |
| coturn.uris | list | `[]` |  |
| element.branding.authFooterLinks | list | `[]` |  |
| element.branding.authHeaderLogoUrl | string | `""` |  |
| element.branding.brand | string | `"Element"` |  |
| element.branding.welcomeBackgroundUrl | string | `""` |  |
| element.enabled | bool | `true` |  |
| element.image.pullPolicy | string | `"IfNotPresent"` |  |
| element.image.repository | string | `"vectorim/element-web"` |  |
| element.image.tag | string | `"v1.7.12"` |  |
| element.integrations.api | string | `"https://scalar.vector.im/api"` |  |
| element.integrations.enabled | bool | `true` |  |
| element.integrations.ui | string | `"https://scalar.vector.im/"` |  |
| element.integrations.widgets[0] | string | `"https://scalar.vector.im/_matrix/integrations/v1"` |  |
| element.integrations.widgets[1] | string | `"https://scalar.vector.im/api"` |  |
| element.integrations.widgets[2] | string | `"https://scalar-staging.vector.im/_matrix/integrations/v1"` |  |
| element.integrations.widgets[3] | string | `"https://scalar-staging.vector.im/api"` |  |
| element.integrations.widgets[4] | string | `"https://scalar-staging.element.im/scalar/api"` |  |
| element.labels.component | string | `"element"` |  |
| element.labs[0] | string | `"feature_new_spinner"` |  |
| element.labs[10] | string | `"feature_custom_themes"` |  |
| element.labs[1] | string | `"feature_pinning"` |  |
| element.labs[2] | string | `"feature_custom_status"` |  |
| element.labs[3] | string | `"feature_custom_tags"` |  |
| element.labs[4] | string | `"feature_state_counters"` |  |
| element.labs[5] | string | `"feature_many_integration_managers"` |  |
| element.labs[6] | string | `"feature_mjolnir"` |  |
| element.labs[7] | string | `"feature_dm_verification"` |  |
| element.labs[8] | string | `"feature_bridge_state"` |  |
| element.labs[9] | string | `"feature_presence_in_room_list"` |  |
| element.permalinkPrefix | string | `"https://matrix.to"` |  |
| element.probes.liveness | object | `{}` |  |
| element.probes.readiness | object | `{}` |  |
| element.probes.startup | object | `{}` |  |
| element.replicaCount | int | `1` |  |
| element.resources | object | `{}` |  |
| element.roomDirectoryServers[0] | string | `"matrix.org"` |  |
| element.service.port | int | `80` |  |
| element.service.type | string | `"ClusterIP"` |  |
| element.welcomeUserId | string | `""` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` |  |
| ingress.enabled | bool | `true` |  |
| ingress.federation | bool | `true` |  |
| ingress.hosts.element | string | `"element.chart-example.local"` |  |
| ingress.hosts.federation | string | `"matrix-fed.chart-example.local"` |  |
| ingress.hosts.synapse | string | `"matrix.chart-example.local"` |  |
| ingress.tls | list | `[]` |  |
| mail | object | `{"elementUrl":"","enabled":false,"external":{"host":"","password":"","port":25,"requireTransportSecurity":true,"username":""},"from":"Matrix <matrix@example.com>","relay":{"enabled":true,"image":{"pullPolicy":"IfNotPresent","repository":"devture/exim-relay","tag":"4.93.1-r0"},"labels":{"component":"mail"},"probes":{"liveness":{},"readiness":{},"startup":{}},"replicaCount":1,"resources":{},"service":{"port":25,"type":"ClusterIP"}}}` | Settings for email notifications |
| mail.enabled | bool | `false` | disabled all email notifications by default. NOTE: If enabled, either enable the Exim relay or configure an external mail server below |
| mail.from | string | `"Matrix <matrix@example.com>"` | Name and email address for outgoing mail |
| matrix.adminEmail | string | `"admin@example.com"` | Email address of the administrator |
| matrix.blockNonAdminInvites | bool | `false` | Set to true to block non-admins from inviting users to any rooms |
| matrix.disabled | bool | `false` |  |
| matrix.disabledMessage | string | `""` |  |
| matrix.encryptByDefault | string | `"invite"` |  |
| matrix.federation | object | `{"allowPublicRooms":true,"blacklist":["127.0.0.0/8","10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","100.64.0.0/10","169.254.0.0/16","::1/128","fe80::/64","fc00::/7"],"enabled":true,"whitelist":[]}` | Settings related to federation |
| matrix.federation.allowPublicRooms | bool | `true` | Set to false to disallow members of other homeservers from fetching *public* rooms |
| matrix.federation.blacklist | list | `["127.0.0.0/8","10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","100.64.0.0/10","169.254.0.0/16","::1/128","fe80::/64","fc00::/7"]` | IP addresses to blacklist federation requests to |
| matrix.federation.enabled | bool | `true` | Set to false to disable federation and run an isolated homeserver |
| matrix.federation.whitelist | list | `[]` | Whitelist of domains to federate with (comment for all domains except blacklisted) |
| matrix.homeserverExtra | object | `{}` | If homeserverExtra is set, the contents will be appended to the end of the default configuration. |
| matrix.homeserverOverride | object | `{}` | If homeserverOverride is set, the entirety of homeserver.yaml will be replaced with the contents. |
| matrix.logging.rootLogLevel | string | `"WARNING"` |  |
| matrix.logging.sqlLogLevel | string | `"WARNING"` |  |
| matrix.logging.synapseLogLevel | string | `"WARNING"` |  |
| matrix.presence | bool | `true` | Set to false to disable presence (online/offline indicators) |
| matrix.registration | object | `{"allowGuests":false,"autoJoinRooms":[],"enabled":false,"requiresToken":false}` | User registration settings |
| matrix.registration.allowGuests | bool | `false` | Allow users to join rooms as a guest |
| matrix.registration.enabled | bool | `false` | Allow new users to register an account |
| matrix.retentionPeriod | string | `"7d"` |  |
| matrix.search | bool | `true` | Set to false to disable message searching |
| matrix.security.surpressKeyServerWarning | bool | `true` |  |
| matrix.serverName | string | `"example.com"` | Domain name of the server: This is not necessarily the host name where the service is reachable. In fact, you may want to omit any subdomains from this value as the server name set here will be the name of your homeserver in the fediverse, and will be the domain name at the end of every user's username |
| matrix.telemetry | bool | `false` | Enable anonymous telemetry to matrix.org |
| matrix.uploads | object | `{"maxPixels":"32M","maxSize":"10M"}` | Settings related to image and multimedia uploads |
| matrix.uploads.maxPixels | string | `"32M"` | Max image size in pixels |
| matrix.uploads.maxSize | string | `"10M"` | Max upload size in bytes |
| matrix.urlPreviews.enabled | bool | `false` |  |
| matrix.urlPreviews.rules.ip.blacklist[0] | string | `"127.0.0.0/8"` |  |
| matrix.urlPreviews.rules.ip.blacklist[1] | string | `"10.0.0.0/8"` |  |
| matrix.urlPreviews.rules.ip.blacklist[2] | string | `"172.16.0.0/12"` |  |
| matrix.urlPreviews.rules.ip.blacklist[3] | string | `"192.168.0.0/16"` |  |
| matrix.urlPreviews.rules.ip.blacklist[4] | string | `"100.64.0.0/10"` |  |
| matrix.urlPreviews.rules.ip.blacklist[5] | string | `"169.254.0.0/16"` |  |
| matrix.urlPreviews.rules.ip.blacklist[6] | string | `"::1/128"` |  |
| matrix.urlPreviews.rules.ip.blacklist[7] | string | `"fe80::/64"` |  |
| matrix.urlPreviews.rules.ip.blacklist[8] | string | `"fc00::/7"` |  |
| matrix.urlPreviews.rules.maxSize | string | `"10M"` |  |
| matrix.urlPreviews.rules.url | object | `{}` |  |
| nameOverride | string | `""` |  |
| networkPolicies.enabled | bool | `true` |  |
| postgresql | object | `{"database":"matrix","enabled":true,"existingSecret":"","hostname":"","initdbScriptsConfigMap":"{{ .Release.Name }}-postgresql-initdb","password":"matrix","persistence":{"size":"8Gi"},"port":5432,"secretKeys":{"database":"database","databaseHostname":"databaseHostname","databasePassword":"databasePassword","databasePort":"databasePort","databaseUsername":"databaseUsername"},"securityContext":{"enabled":true,"fsGroup":1000,"runAsUser":1000},"ssl":false,"sslMode":"prefer","username":"matrix"}` | PostgreSQL Database Configuration |
| postgresql.database | string | `"matrix"` | name of database to use for matrix |
| postgresql.enabled | bool | `true` | Whether to deploy the stable/postgresql chart with this chart. If disabled, make sure PostgreSQL is available at the hostname below and credentials are configured below |
| postgresql.existingSecret | string | `""` | Name of existing secret to use for PostgreSQL credentials |
| postgresql.hostname | string | `""` | hostname of postgres server to use. Can be left blank if using bundled bitnami postgresql sub-chart |
| postgresql.initdbScriptsConfigMap | string | `"{{ .Release.Name }}-postgresql-initdb"` | If postgresql.enabled, stable/postgresql will run the scripts in templates/postgresql/initdb-configmap.yaml If using an external Postgres server, make sure to configure the database as specified at https://github.com/matrix-org/synapse/blob/master/docs/postgres.md |
| postgresql.password | string | `"matrix"` | password of matrix postgres user |
| postgresql.persistence | object | `{"size":"8Gi"}` | persistent volume claim configuration for postgresql to persist data |
| postgresql.persistence.size | string | `"8Gi"` | size of postgresql volume claim |
| postgresql.port | int | `5432` | which port to use to connect to your database server |
| postgresql.secretKeys | object | `{"database":"database","databaseHostname":"databaseHostname","databasePassword":"databasePassword","databasePort":"databasePort","databaseUsername":"databaseUsername"}` | secretKeys to grab from existingSecret if postgresql.existingSecret is provided, the following are ignored postgresql.password/username/hostname/database/port |
| postgresql.ssl | bool | `false` | Whether to connect to the database over SSL |
| postgresql.sslMode | string | `"prefer"` | which ssl mode to use. See [documentation](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS) for more info |
| postgresql.username | string | `"matrix"` | username of matrix postgres user |
| synapse.extraVolumeMounts | list | `[]` |  |
| synapse.extraVolumes | list | `[]` |  |
| synapse.image.pullPolicy | string | `"IfNotPresent"` |  |
| synapse.image.repository | string | `"matrixdotorg/synapse"` |  |
| synapse.labels.component | string | `"synapse"` |  |
| synapse.metrics.annotations | bool | `true` |  |
| synapse.metrics.enabled | bool | `true` |  |
| synapse.metrics.port | int | `9092` |  |
| synapse.probes.liveness.periodSeconds | int | `10` |  |
| synapse.probes.liveness.timeoutSeconds | int | `5` |  |
| synapse.probes.readiness.periodSeconds | int | `10` |  |
| synapse.probes.readiness.timeoutSeconds | int | `5` |  |
| synapse.probes.startup.failureThreshold | int | `6` |  |
| synapse.probes.startup.periodSeconds | int | `5` |  |
| synapse.probes.startup.timeoutSeconds | int | `5` |  |
| synapse.replicaCount | int | `1` |  |
| synapse.resources | object | `{}` |  |
| synapse.securityContext.env | bool | `false` |  |
| synapse.securityContext.fsGroup | int | `1000` |  |
| synapse.securityContext.runAsGroup | int | `1000` |  |
| synapse.securityContext.runAsNonRoot | bool | `true` |  |
| synapse.securityContext.runAsUser | int | `1000` |  |
| synapse.service.federation.port | int | `80` |  |
| synapse.service.federation.type | string | `"ClusterIP"` |  |
| synapse.service.port | int | `80` |  |
| synapse.service.type | string | `"ClusterIP"` |  |
| volumes.media.capacity | string | `"10Gi"` |  |
| volumes.media.storageClass | string | `""` |  |
| volumes.signingKey.capacity | string | `"1Mi"` |  |
| volumes.signingKey.storageClass | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
