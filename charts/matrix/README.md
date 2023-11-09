# matrix

![Version: 6.2.2](https://img.shields.io/badge/Version-6.2.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.95.1](https://img.shields.io/badge/AppVersion-v1.95.1-informational?style=flat-square)

A Helm chart to deploy a Matrix homeserver stack on Kubernetes

**Homepage:** <https://github.com/small-hack/matrix-chart>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| jessebot | <jessebot@linux.com> | <https://github.com/jessebot/> |

## Source Code

* <https://github.com/small-hack/matrix-chart>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://jessebot.github.io/coturn-chart | coturn | 4.3.0 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 13.2.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bridges.affinity | bool | `false` | Recommended to leave this disabled to allow bridges to be scheduled on separate nodes. Set this to true to reduce latency between the homeserver and bridges, or if your cloud provider does not allow the ReadWriteMany access mode (see below) |
| bridges.discord.auth.botToken | string | `""` | Discord bot token for authentication |
| bridges.discord.auth.clientId | string | `""` | Discord bot clientID for authentication |
| bridges.discord.channelName | string | `"[Discord] :guild :name"` |  |
| bridges.discord.data.capacity | string | `"512Mi"` | Size of the PVC to allocate for the SQLite database |
| bridges.discord.data.storageClass | string | `""` | Storage class (optional) |
| bridges.discord.defaultVisibility | string | `"public"` | Default visibility of bridged rooms (public/private) |
| bridges.discord.enabled | bool | `false` | Set to true to enable the Discord bridge |
| bridges.discord.image.pullPolicy | string | `"Always"` |  |
| bridges.discord.image.repository | string | `"halfshot/matrix-appservice-discord"` |  |
| bridges.discord.image.tag | string | `"latest"` |  |
| bridges.discord.joinLeaveEvents | bool | `true` | Discord notifications when a user joins/leaves the Matrix channel |
| bridges.discord.presence | bool | `true` | Set to false to disable online/offline presence for Discord users |
| bridges.discord.readReceipt | bool | `true` | Discord bot read receipt, which advances whenever the bot bridges a msg |
| bridges.discord.replicaCount | int | `1` |  |
| bridges.discord.resources | object | `{}` |  |
| bridges.discord.selfService | bool | `false` | Set to true to allow users to bridge rooms themselves using !discord cmds More info: https://t2bot.io/discord |
| bridges.discord.service.port | int | `9005` |  |
| bridges.discord.service.type | string | `"ClusterIP"` |  |
| bridges.discord.typingNotifications | bool | `true` | Set to false to disable typing notifications (only for Discord to Matrix) |
| bridges.discord.users.nickname | string | `":nick"` | Nickname of bridged Discord users Available vars:   :nick     - user's Discord nickname   :username - user's Discord username   :tag      - user's 4 digit Discord tag   :id       - user's Discord developer ID (long) |
| bridges.discord.users.username | string | `":username#:tag"` | Username of bridged Discord users Available vars:   :username - user's Discord username   :tag      - user's 4 digit Discord tag   :id       - user's Discord developer ID (long) |
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
| bridges.whatsapp.bot.avatar | string | `"mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr"` | avatar of the WhatsApp bridge bot |
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
| element.image.tag | string | `"v1.11.48"` | tag to use for element docker image |
| element.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt-staging"` | required for TLS certs issued by cert-manager |
| element.ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` |  |
| element.ingress.className | string | `"nginx"` | ingressClassName for the k8s ingress |
| element.ingress.enabled | bool | `true` | enable ingress for element |
| element.ingress.host | string | `"element.chart-example.local"` | the hostname to use for element |
| element.ingress.tls.enabled | bool | `true` | enable a fairly stock ingress, open a github issue if you need more features |
| element.ingress.tls.secretName | string | `"element-tls"` | name for the element tls secret for ingress |
| element.integrations.api | string | `"https://scalar.vector.im/api"` | API for the integration server |
| element.integrations.enabled | bool | `true` | enables the Integrations menu, including:    widgets, bots, and other plugins to Element |
| element.integrations.ui | string | `"https://scalar.vector.im/"` | UI to load when a user selects the Integrations button at the top-right    of a room |
| element.integrations.widgets | list | `["https://scalar.vector.im/_matrix/integrations/v1","https://scalar.vector.im/api","https://scalar-staging.vector.im/_matrix/integrations/v1","https://scalar-staging.vector.im/api","https://scalar-staging.element.im/scalar/api"]` | Array of API paths providing widgets |
| element.labels | object | `{"component":"element"}` | Element specific labels |
| element.labs | list | `["feature_new_spinner","feature_pinning","feature_custom_status","feature_custom_tags","feature_state_counters","feature_many_integration_managers","feature_mjolnir","feature_dm_verification","feature_bridge_state","feature_presence_in_room_list","feature_custom_themes"]` | Experimental features in Element, see: https://github.com/vector-im/element-web/blob/develop/docs/labs.md |
| element.permalinkPrefix | string | `"https://matrix.to"` | Prefix before permalinks generated when users share links to rooms, users, or messages. If running an unfederated Synapse, set the below to the URL of your Element instance. |
| element.probes.liveness | object | `{}` |  |
| element.probes.readiness | object | `{}` |  |
| element.probes.startup | object | `{}` |  |
| element.replicaCount | int | `1` |  |
| element.resources | object | `{}` |  |
| element.roomDirectoryServers | list | `["matrix.org"]` | Servers to show in the Explore menu (the current server is always shown) |
| element.service.port | int | `80` |  |
| element.service.type | string | `"ClusterIP"` |  |
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
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
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
| matrix.adminEmail | string | `"admin@example.com"` | Email address of the administrator |
| matrix.blockNonAdminInvites | bool | `false` | Set to true to block non-admins from inviting users to any rooms |
| matrix.disabled | bool | `false` | Set to true to globally block access to the homeserver |
| matrix.disabledMessage | string | `""` | Human readable reason for why the homeserver is blocked |
| matrix.encryptByDefault | string | `"invite"` |  |
| matrix.federation.allowPublicRooms | bool | `true` | Allow members of other homeservers to fetch *public* rooms |
| matrix.federation.blacklist | list | `["127.0.0.0/8","10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","100.64.0.0/10","169.254.0.0/16","::1/128","fe80::/64","fc00::/7"]` | IP addresses to blacklist federation requests to |
| matrix.federation.enabled | bool | `true` | Set to false to disable federation and run an isolated homeserver |
| matrix.federation.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt-staging"` | required for TLS certs issued by cert-manager |
| matrix.federation.ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` | required for the Nginx ingress provider. You can remove it if you use a different ingress provider |
| matrix.federation.ingress.className | string | `"nginx"` | ingressClassName for the k8s ingress |
| matrix.federation.ingress.enabled | bool | `true` |  |
| matrix.federation.ingress.host | string | `"matrix-fed.chart-example.local"` |  |
| matrix.federation.ingress.tls.enabled | bool | `true` |  |
| matrix.federation.whitelist | list | `[]` | Allow list of domains to federate with (comment for all domains    except blacklisted) |
| matrix.homeserverExtra | object | `{}` | Contents will be appended to the end of the default configuration |
| matrix.homeserverOverride | object | `{}` | Replace homeserver.yaml will be replaced with these contents |
| matrix.logging.rootLogLevel | string | `"WARNING"` | Root log level is the default log level for log outputs that don't have more specific settings. |
| matrix.logging.sqlLogLevel | string | `"WARNING"` | beware: increasing this to DEBUG will make synapse log sensitive information such as access tokens. |
| matrix.logging.synapseLogLevel | string | `"WARNING"` | The log level for the synapse server |
| matrix.oidc.enabled | bool | `false` | set to true to enable authorization against an OpenID Connect server |
| matrix.oidc.existingSecret | string | `""` | existing secret to use for the OIDC config |
| matrix.oidc.providers | list | `[{"authorization_endpoint":"https://accounts.example.com/oauth2/auth","backchannel_logout_enabled":true,"client_auth_method":"client_secret_post","client_id":"provided-by-your-issuer","client_secret":"provided-by-your-issuer","discover":true,"idp_brand":"","idp_id":"","idp_name":"","issuer":"https://accounts.example.com/","scopes":["openid","profile"],"skip_verification":false,"token_endpoint":"https://accounts.example.com/oauth2/token","user_mapping_provider":{"config":{"display_name_template":"","localpart_template":"","picture_template":"{{ user.data.profile_image_url }}","subject_claim":""}},"userinfo_endpoint":"https://accounts.example.com/userinfo"}]` | each of these will be templated under oidc_providers in homeserver.yaml ref: https://matrix-org.github.io/synapse/latest/openid.html?search= |
| matrix.oidc.providers[0] | object | `{"authorization_endpoint":"https://accounts.example.com/oauth2/auth","backchannel_logout_enabled":true,"client_auth_method":"client_secret_post","client_id":"provided-by-your-issuer","client_secret":"provided-by-your-issuer","discover":true,"idp_brand":"","idp_id":"","idp_name":"","issuer":"https://accounts.example.com/","scopes":["openid","profile"],"skip_verification":false,"token_endpoint":"https://accounts.example.com/oauth2/token","user_mapping_provider":{"config":{"display_name_template":"","localpart_template":"","picture_template":"{{ user.data.profile_image_url }}","subject_claim":""}},"userinfo_endpoint":"https://accounts.example.com/userinfo"}` | id of your identity provider, e.g. dex |
| matrix.oidc.providers[0].authorization_endpoint | string | `"https://accounts.example.com/oauth2/auth"` | oauth2 authorization endpoint. Required if provider discovery disabled. |
| matrix.oidc.providers[0].client_auth_method | string | `"client_secret_post"` | auth method to use when exchanging the token. Valid values are: 'client_secret_basic' (default), 'client_secret_post' and 'none'. |
| matrix.oidc.providers[0].client_id | string | `"provided-by-your-issuer"` | oauth2 client id to use. Required if 'enabled' is true. |
| matrix.oidc.providers[0].client_secret | string | `"provided-by-your-issuer"` | oauth2 client secret to use. Required if 'enabled' is true. |
| matrix.oidc.providers[0].discover | bool | `true` | turn off discovery by setting this to false |
| matrix.oidc.providers[0].idp_brand | string | `""` | optional styling hint for clients |
| matrix.oidc.providers[0].idp_name | string | `""` | human readable comment of your identity provider, e.g. "My Dex Server" |
| matrix.oidc.providers[0].issuer | string | `"https://accounts.example.com/"` | OIDC issuer. Used to validate tokens and (if discovery is enabled) to discover the provider's endpoints. Required if 'enabled' is true. |
| matrix.oidc.providers[0].scopes | list | `["openid","profile"]` | list of scopes to request. should normally include the "openid" scope. Defaults to ["openid"]. |
| matrix.oidc.providers[0].token_endpoint | string | `"https://accounts.example.com/oauth2/token"` | the oauth2 token endpoint. Required if provider discovery is disabled. |
| matrix.oidc.providers[0].user_mapping_provider.config.subject_claim | string | `""` | name of the claim containing a unique identifier for user. Defaults to `sub`, which OpenID Connect compliant providers should provide. |
| matrix.oidc.providers[0].userinfo_endpoint | string | `"https://accounts.example.com/userinfo"` | the OIDC userinfo endpoint. Required if discovery is disabled and the "openid" scope is not requested. |
| matrix.oidc.secretKeys.authorization_endpoint | string | `""` | key in secret with the authorization_endpoint if discovery is disabled |
| matrix.oidc.secretKeys.client_id | string | `"client_id"` | key in secret with the client_id |
| matrix.oidc.secretKeys.client_secret | string | `"client_secret"` | key in secret with the client_secret |
| matrix.oidc.secretKeys.issuer | string | `"issuer"` | key in secret with the issuer |
| matrix.oidc.secretKeys.token_endpoint | string | `""` | key in secret with the token_endpoint if discovery is disabled |
| matrix.oidc.secretKeys.userinfo_endpoint | string | `""` | key in secret with the userinfo_endpoint if discovery is disabled |
| matrix.presence | bool | `true` | Set to false to disable presence (online/offline indicators) |
| matrix.registration.allowGuests | bool | `false` | Allow users to join rooms as a guest |
| matrix.registration.autoJoinRooms | list | `[]` | Rooms to automatically join all new users to |
| matrix.registration.enabled | bool | `false` | Allow new users to register an account |
| matrix.registration.existingSecret | string | `""` | if set, pull sharedSecret from an existing k8s secret |
| matrix.registration.generateSharedSecret | bool | `false` | if set, allows user to generate a random shared secret in a k8s secret ignored if existingSecret is passed in |
| matrix.registration.requiresToken | bool | `false` | Whether to allow token based registration |
| matrix.registration.secretKey | string | `"registrationSharedSecret"` | key in existing k8s secret for registration shared secret |
| matrix.registration.sharedSecret | string | `""` | If set, allows registration of standard or admin accounts by anyone who has the shared secret, even if registration is otherwise disabled. ignored if existingSecret is passed in |
| matrix.retentionPeriod | string | `"7d"` | How long to keep redacted events in unredacted form in the database |
| matrix.search | bool | `true` | Set to false to disable message searching |
| matrix.security.surpressKeyServerWarning | bool | `true` |  |
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
| nameOverride | string | `""` |  |
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
| postgresql.primary.initdb | object | `{"scriptsConfigMap":"{{ .Release.Name }}-postgresql-initdb"}` | run the scripts in templates/postgresql/initdb-configmap.yaml If using an external Postgres server, make sure to configure the database ref: https://github.com/matrix-org/synapse/blob/master/docs/postgres.md |
| postgresql.primary.persistence | object | `{"enabled":false,"size":"8Gi"}` | persistent volume claim configuration for postgresql to persist data |
| postgresql.primary.persistence.enabled | bool | `false` | Enable PostgreSQL Primary data persistence using PVC |
| postgresql.primary.persistence.size | string | `"8Gi"` | size of postgresql volume claim |
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
| s3.store_local | bool | `true` | whether to write storage locally to a volume (this is in addition to the s3 storage) |
| synapse.extraEnv | list | `[]` | optiona: extra env variables to pass to the matrix synapse deployment |
| synapse.extraVolumeMounts | list | `[]` | optional: extra volume mounts for the matrix synapse deployment |
| synapse.extraVolumes | list | `[]` | optional: extra volumes for the matrix synapse deployment |
| synapse.image.pullPolicy | string | `"IfNotPresent"` | pullPolicy for synapse image, Use Always if using image.tag: latest |
| synapse.image.repository | string | `"matrixdotorg/synapse"` | image registry and repository to use for synapse |
| synapse.image.tag | string | `""` | tag of synapse docker image to use. change this to latest to grab the    cutting-edge release of synapse |
| synapse.ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt-staging"` | required for TLS certs issued by cert-manager |
| synapse.ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` | This annotation is required for the Nginx ingress provider. You can remove it if you use a different ingress provider |
| synapse.ingress.className | string | `"nginx"` | ingressClassName for the k8s ingress |
| synapse.ingress.enabled | bool | `true` |  |
| synapse.ingress.host | string | `"matrix.chart-example.local"` |  |
| synapse.ingress.tls.enabled | bool | `true` |  |
| synapse.ingress.tls.secretName | string | `"matrix-tls"` |  |
| synapse.labels | object | `{"component":"synapse"}` | Labels to be appended to all Synapse resources |
| synapse.metrics.annotations | bool | `true` |  |
| synapse.metrics.enabled | bool | `true` | Whether Synapse should capture metrics on an additional endpoint |
| synapse.metrics.port | int | `9092` | Port to listen on for metrics scraping |
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
| synapse.replicaCount | int | `1` |  |
| synapse.resources | object | `{}` |  |
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
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
