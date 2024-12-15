# Matrix Chart
<a href="https://github.com/small-hack/matrix-chart/releases"><img src="https://img.shields.io/github/v/release/small-hack/matrix-chart?style=plastic&labelColor=blue&color=green&logo=GitHub&logoColor=white"></a>

A Helm chart for deploying a Matrix homeserver stack on Kubernetes.

## TLDR

See the [`README.md`](https://github.com/small-hack/matrix-chart/blob/main/charts/matrix/README.md) for docs auto-generated from the [`values.yaml`](https://github.com/small-hack/matrix-chart/blob/main/charts/matrix/values.yaml).

Read through the parameters and modify them locally before installing the chart:

```bash
# add the helm repo locally
helm repo add matrix https://small-hack.github.io/matrix-chart

# downloads the values.yaml locally
helm show values matrix/matrix > values.yaml

# You should then edit the values.yaml to your liking.

## NOTE: The most important helm parameter is matrix.hostname
## without it, this chart may not work!

# install the chart
helm install my-release-name matrix/matrix --values values.yaml
```

> [!IMPORTANT]
> The most important helm parameter is `matrix.hostname`. Without it, this chart may not work!**

> [!WARNING]
> This chart used to support the Sliding Sync Proxy, but as it is deprecated, we no longer support it. See this [matrix blog post](https://matrix.org/blog/2024/11/14/moving-to-native-sliding-sync/) for more info.


## Current Features ✨

- Latest version of [Synapse](https://github.com/element-hq/synapse) (the official matrix homeserver)
- Ingress definitions for federated Synapse (aka Matrix homeserver) and Element (default client for matrix)

### Optional Features

- Use existing Persistent Volume Claims
- Use existing Kubernetes Secrets for confidential data, such as passwords
- Use OIDC configs for SSO either directly via Synapse (see [docs](https://github.com/element-hq/synapse/blob/develop/docs/openid.md) for more info) or via MAS
  - Use MAS ([matrix-org/matrix-authentication-service](https://github.com/matrix-org/matrix-authentication-service)) via [matrix-authentication-service-chart](https://github.com/small-hack/matrix-authentication-service-chart) as a sub chart for using [element-x] which recommends  for OIDC auth
- Latest version of the [Element web app](https://element.io/) to provide a web interface for chat (you can disable this and still use element apps)
- Use s3 to store media using [element-hq/synapse-s3-storage-provider](https://github.com/matrix-org/synapse-s3-storage-provider/tree/main)
- [small-hack/matrix-alertmanager](https://github.com/small-hack/matrix-alertmanager) - Prometheus Alertmanager bridge for syncing between matrix and Alertmanager

#### ⚠️ Untested Features

These features still need to be tested, but are technically baked into the chart from the fork or from previous versions of this chart:

- [mautrix/discord](https://github.com/mautrix/discord) - Discord bridge for syncing between matrix and Discord (we no longer test this directly but we're open to PRs to improve support!)
- [Coturn TURN server subchart](https://github.com/small-hack/coturn-chart) for VoIP calls (may not be needed in Matrix 2.0 API)
- Use of lightweight Exim relay
- [matrix-org/matrix-appservice-irc](https://github.com/matrix-org/matrix-appservice-irc) IRC bridge
- [tulir/mautrix-whatsapp](https://github.com/tulir/mautrix-whatsapp) WhatsApp bridge

# Notes

* [Databases](#databases)
* [Ingress](#ingress)
* [Federation](#federation)
    * [Federation not Working](#federation-not-working)
    * [Addiing Trusted Key Servers from an existing Secret](#addiing-trusted-key-servers-from-an-existing-secret)
* [Notes on using MAS (Matrix Authentication Service)](#notes-on-using-mas-matrix-authentication-service)
* [Bridges](#bridges)
    * [Alertmanager](#alertmanager)
    * [Discord](#discord)
* [About and Status](#about-and-status)


## Databases

You must select one of the following options:

- Use the [Bitnami PostgreSQL subchart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) (set `postgresql.enabled` to `true`)
- Use your own external database, which can also be PostgreSQL. (set `externalDatabase.enabled` to `true`)

> [!NOTE]
>
> You cannot enable both `externalDatabase` and `postgresql`. You must select _one_.

## Ingress

A previous version of this chart supported using the `synapse.ingress.host` parameter. This option has been removed. You must now set a `synapse.ingress.hosts`. Because of this, you must now also set `matrix.hostname` or certain functionality will not work. Example of how to setup ingress and hostname:

```yaml
matrix:
  # used for setting up config files that require your homeserver hostname
  # such as bridging between your matrix homeserver (synapse) and other services
  # such as discord or WhatsApp
  hostname: my-synapse-hostname.com

synapse:
  ingress:
    className: "nginx"
    annotations:
      # required for TLS certs issued by cert-manager
      cert-manager.io/cluster-issuer: letsencrypt-staging

      # -- This annotation is required for the Nginx ingress provider. You can
      # remove it if you use a different ingress provider
      nginx.ingress.kubernetes.io/configuration-snippet: |
        proxy_intercept_errors off;

    hosts:
      - host: "my-synapse-hostname.com"
        paths:
          - path: /
            pathType: ImplementationSpecific
            # if mas.enabled is set to true, you want pathType for / to be Prefix
            # pathType: Prefix

          # if mas.enabled is set to true, you want to uncomment the following:
          # - path: "/_matrix/client/(r0|v3)/(refresh|login|logout).*"
          #   pathType: ImplementationSpecific
          #   backend:
          #     service:
          #       value: release-name-mas
          #       port:
          #         name: http
    # -- enable tls for synapse ingress
    tls:
      - secretName: "matrix-tls"
        hosts:
          - my-synapse-hostname
```

## Federation

### Federation not Working

This can be broken for a number of reasons, and some of them are listed in the official [synapse docs](https://element-hq.github.io/synapse/latest/federate.html#setting-up-federation), but one that was persistent for the devs here was constantly getting a 401 when testing.

I managed to finally get past that by adding the following to my values.yaml:

```yaml
matrix:
  hostname: my-synapse-hostname.com
  federation:
    enabled: true

synapse:
  ingress:
    # replace matrix.mydomain.com with your actual matrix domain
    nginx.ingress.kubernetes.io/configuration-snippet: |
      location /.well-known/matrix/server {
        return 200 '{"m.server": "matrix.mydomain.com:443"}';
        add_header Content-Type application/json;
      }
```

> [!NOTE]
>
> By the way, you can test by going to `https://federationtester.matrix.org/api/report?server_name=matrix.mydomain.com` where `matrix.mydomain.com` is replaced by your synapse server.

Later on, I realized I could also use [`serve_server_wellknown`](https://element-hq.github.io/synapse/latest/usage/configuration/config_documentation.html#serve_server_wellknown) in the synapse config, so I've added it to the Chart's parameters and you can use it like this in your values.yaml:

```yaml
matrix:
  hostname: my-synapse-hostname.com
  federation:
    enabled: true
  serve_server_wellknown: true
```

### Addiing Trusted Key Servers from an existing Secret

If you'd like to get your [`trusted_key_servers`](https://element-hq.github.io/synapse/latest/usage/configuration/config_documentation.html#trusted_key_servers) from an existing Kubernetes Secret, you can do so with an in-line yaml block. Here's an example values.yaml:

```yaml
matrix:
  hostname: my-synapse-hostname.com
  federation:
    enabled: true
  security:
    trustedKeyServersExistingSecret: "trusted-key-servers"
    trustedKeyServersSecretKey: "trustedKeyServers"
```

Here's an example Kubernetes Secret using in-line YAML (NOTE the `trusted_key_servers`):

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: trusted-key-servers
  namespace: matrix
type: Opaque
stringData:
  # friend.com is the matrix server you'd like to federate with :)
  trustedKeyServers: |-
    trusted_key_servers:
      - server_name: friend.com
        verify_keys:
          ed25519:auto: abcdefghijklmnopqrstuvwxyz1234567890
```

## Notes on using MAS (Matrix Authentication Service)

MAS is currently the only way to use OIDC with [element-x]. If you're using MAS (Matrix Authentication Service), you'll need to set `mas.enabled` to `true`. You'll also need to setup proper routes for synapse to redirect to MAS. See example below:

```yaml
matrix:
  hostname: my-synapse-hostname.com
  experimental_features:
    msc3861:
      # Likely needed if using OIDC on synapse and you want to allow usage of Element-X (the beta of element)
      enabled: false
      # -- Synapse will call `{issuer}/.well-known/openid-configuration` to get the OIDC configuration
      issuer: http://my-mas-domain.com/
      # -- Matches the `mas.mas.client_id` in the auth service config
      client_id: 0000000000000000000SYNAPSE
      # -- Matches the `mas.mas.client_auth_method` in the auth service config
      client_auth_method: client_secret_basic
      # -- Matches the `mas.mas.clients.client_secret` in the auth service config
      client_secret: "SomeRandomSecret"
      # -- Matches the `mas.mas.matrix.secret` in the auth service config
      admin_token: "special-secret-for-msc3861"
      # -- URL to advertise to clients where users can self-manage their account
      account_management_url: "https://my-mas-domain.com/account"

synapse:
  enabled: true
  ingress:
    enabled: true
    className: "nginx"
    annotations:
      # you need for the routing to work properly
      nginx.ingress.kubernetes.io/use-regex: "true"
      # -- This annotation is required for the Nginx ingress provider. You can
      # remove it if you use a different ingress provider
      nginx.ingress.kubernetes.io/configuration-snippet: |
        proxy_intercept_errors off;
      # -- required for TLS certs issued by cert-manager
      cert-manager.io/cluster-issuer: letsencrypt-staging
    hosts:
      - host: 'my-synapse-hostname.com'
        paths:
          - path: "/_matrix/client/(r0|v3)/(refresh|login|logout).*"
            pathType: ImplementationSpecific
            backend:
              service:
                # this assumes you passed in mas.fullnameOverride="mas"
                name: mas
                port:
                  name: http

          - path: /
            pathType: Prefix
    tls:
      - secretName: matrix-tls
        hosts:
          - 'my-synapse-hostname.com'

mas:
  enabled: true
  # sets all MAS resources to be called mas
  fullnameOverride: "mas"
  postgresql:
    enabled: true

  ingress:
    enabled: true
    className: "nginx"
    annotations:
      cert-manager.io/cluster-issuer: 'letsencrypt-prod'
    hosts:
      - host: 'my-mas-domain.com'
        paths:
          - path: /
            pathType: Prefix
    tls:
      - secretName: matrix-authentication-service-tls
        hosts:
          - 'my-mas-domain.com'

  # templates out the Matrix Authentication Service config file
  mas:
    database:
      # if blank, this can be autogenerated from mas.postgres or mas.externalDatabase
      # settings, or you set this to a valid postgres URI
      # https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNSTRING-URIS
      uri: ""

    http:
      # -- Public URL base used when building absolute public URLs
      public_base: "https://my-mas-domain.com/"
      # List of HTTP listeners, see below
      listeners:
        # The name of the listener, used in logs and metrics
        - name: web
          # List of resources to serve
          resources:
            - name: discovery
            - name: human
            - name: oauth
            - name: compat
            - name: graphql
            - name: assets
          binds:
            - host: 0.0.0.0
              port: 8080

    policy:
      client_registration:
        # don't require URIs to be on the same host. default: false
        allow_host_mismatch: true
        # allow non-SSL and localhost URIs. default: false
        allow_insecure_uris: true

    # this is mostly ignored in favor of the above masClientSecret variable
    clients:
      - client_id: "0000000000000000000SYNAPSE"
        client_auth_method: client_secret_basic
        client_secret: "SomeRandomSecret"

    matrix:
      homeserver: "my-synapse-hostname.com"
      endpoint: "https://my-synapse-hostname.com"
      secret: "special-secret-for-msc3861"

    upstream_oauth2:
      existingSecret: "synapse-oidc"
      secretKeys:
        # -- key in secret with the issuer
        issuer: "issuer"
        # -- key in secret with the client_id
        client_id: "client_id"
        # -- key in secret with the client_secret
        client_secret: "client_secret"

      # this below example is compatible with zitadel
      providers:
        # -- A unique identifier (ULID) for the provider: https://www.ulidtools.com
        # in the valid redirect uris, you want to use this id
        - id: "01HYZ2G7QS9P2BHSDS94F3GR80"
          issuer: https://example-zitadel-domain.com/
          client_id: "idgenreatedbyyourupstreamoidcprovider"
          client_secret: "secretgenreatedbyyourupstreamoidcprovider"

          token_endpoint_auth_method: client_secret_basic
          claims_imports:
            subject:
              template: "{{ user.sub }}"

            localpart:
              action: require
              template: "{{ user.preferred_username }}"

            displayname:
              action: suggest
              template: "{{ user.name }}"

            email:
              action: suggest
              template: "{{ user.email }}"
              set_email_verification: always
```

## Bridges

We've only recently started adding/testing [bridges](https://matrix.org/ecosystem/bridges/) to this stack, so there may be some bugs, but so far, we've got the discord bridge upgraded. The rest of the bridges are in a beta/alpha state and although we want to support them, we haven't had the time to test them out since the major fork. If you find something wrong with them, please feel free to submit an Issue or Pull Request.

So far we've tested and gotten working two bots/bridges: Alertmanager and Discord. We wanted to get hookshot working, but try as we might, we could never get the bot to respond to queries in a matrix chat.

### Alertmanager

Check out the [upstream repo](https://github.com/small-hack/matrix-alertmanager) for more info (especially [`.env.default`](https://github.com/small-hack/matrix-alertmanager/blob/main/.env.default)), but here's the gist for configuring it via this chart.

```yaml
bridges:
  alertmanager:
    enabled: false

    existingSecret:
      # -- optional secret to replace the entire registration.yaml
      registration: ""

    # this section is for registering the application service with matrix
    # read more about application services here:
    # https://spec.matrix.org/v1.11/application-service-api/
    registration:
      # -- url of the alertmanager service. if not provided, we will template it
      # for you like http://matrix-alertmanager-service:3000
      url: ""
      # A secret token that the application service will use to authenticate
      # requests to the homeserver.
      as_token: ""
      # -- Use an existing Kubernetes Secret to store your own generated appservice
      # and homeserver tokens. If this is not set, we'll generate them for you.
      # Setting this won't override the ENTIRE registration.yaml we generate for
      # the synapse pod to authenticate mautrix/discord. It will only replaces the tokens.
      # To replaces the ENTIRE registration.yaml, use
      # bridges.alertmanager.existingSecret.registration
      existingSecret: ""
      existingSecretKeys:
        # -- key in existingSecret for as_token (application service token). If
        # provided and existingSecret is set, ignores bridges.alertmanager.registration.as_token
        as_token: "as_token"
        # -- key in existingSecret for hs_token (home server token)
        hs_token: "hs_token"

    encryption: false

    config:
      # -- secret key for the alertmanager webhook config URL
      app_alertmanager_secret: ""
      # -- your homeserver url, e.g. https://homeserver.tld
      homeserver_url: ""

      bot:
        # -- optional: display name to set for the bot user
        display_name: ""
        # -- optional: mxc:// avatar to set for the bot user
        avatar_url: ""
        # -- rooms to send alerts to, separated by a |
        # Each entry contains the receiver name (from alertmanager) and the
        # internal id (not the public alias) of the Matrix channel to forward to.
        # example: reciever1/!789fhdsauoh48:mymatrix.hostname.com
        rooms: ""
        # -- Set this to true to make firing alerts do a `@room` mention.
        # NOTE! Bot should also have enough power in the room for this to be useful.
        mention_room: false

      # -- set to enable Grafana links, e.g. https://grafana.example.com
      grafana_url: ""
      # -- grafana data source, e.g. default
      grafana_datasource: ""
      # -- set to enable silence link, e.g. https://alertmanager.example.com
      alertmanager_url: ""
```

### Discord

We previously had the halfshot/discord bridge as a part of this stack, but as of July 2024 the image was no longer being updated and hadn't been updated in 3 years, see: [#589](https://github.com/small-hack/matrix-chart/issues/589) for more info. Instead we now offer the [mautrix/discord](https://github.com/mautrix/discord) bridge. You can read their docs [here](https://docs.mau.fi/bridges/go/discord/index.html).

Here's how we got it mostly working on our end via the values.yaml:

```yaml
matrix:
  hostname: my-synapse-hostname.com

bridges:
  discord_mautrix:
    enabled: true
    # this just keeps the replicasets from getting
    # out of control, feel free to set to 10 to
    # keep more history for rollbacks
    revisionHistoryLimit: 1

    # -- extra volumes for the mautrix/discord deployment
    # we created this separately from the chart
    extraVolumes:
      - name: sqllite
        persistentVolumeClaim:
          claimName: mautrix-discord-bridge-sqlite

    extraVolumeMounts:
      - name: sqllite
        mountPath: /sql

    admin_users:
      - friend
      - admin

    config:
      # Homeserver details
      homeserver:
        address: "https://my-synapse-hostname.com"
        domain: "my-synapse-hostname.com"

      appservice:
        # Database config - we used sqllite because it's easy
        database:
          type: sqlite3-fk-wal
          uri: file:/sql/mautrixdiscord.db?_txlock=immediate

      bridge:
        encryption:
          # -- Allow encryption, work in group chat rooms with e2ee enabled
          allow: true
          # -- Default to encryption, force-enable encryption in all portals the bridge creates
          # This will cause the bridge bot to be in private chats for the encryption to work properly.
          default: true
```

Example PVC for the sqllite file to persist:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mautrix-discord-bridge-sqlite
  namespace: matrix
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  storageClassName: local-path
```

After you set this up, you'll still need to authenticate the matrix bot (mautrix/discord) with your Discord bot. For that, you'll need to follow the instructions in the [mautrix discord docs](https://docs.mau.fi/bridges/go/discord/authentication.html).


## About and Status

This is a fork of [Arkaniad/matrix-chart](https://github.com/Arkaniad/matrix-chart), which is a fork of [typokign/matrix-chart](https://github.com/typokign/matrix-chart). We recently transferred this chart from [@jessebot](https://github.com/jessebot) to the [small-hack](https://github.com/small-hack) org to help with maintanence longterm :) Working on full stability, but always happy to receive GitHub Issues or PRs! Please star the repo if you like our work 💙

Our goal is to provide regular updates using renovatebot and provide some level of basic security from a k8s perspective. We're also trying to standardize the chart more by following predictable values.yaml patterns.

<!-- links -->
[element-x]: https://element.io/labs/element-x "element x link"
