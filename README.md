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

# install the chart
helm install my-release-name matrix/matrix --values values.yaml
```

## Current Features ✨

- Latest version of [Synapse](https://github.com/element-hq/synapse) (the official matrix homeserver)
- Ingress definitions for federated Synapse (Matrix homeserver) and Element (client for matrix)

### Optional Features

- Use (existing) Kubernetes Secrets for confidential data, such as passwords
- Use OIDC configs for SSO either directly via synapse (see [docs](https://github.com/element-hq/synapse/blob/develop/docs/openid.md) for more info) or via MAS
  - Use MAS ([matrix-org/matrix-authentication-service](https://github.com/matrix-org/matrix-authentication-service)) via [matrix-authentication-service-chart](https://github.com/small-hack/matrix-authentication-service-chart) as a sub chart for using [element-x] which recommends  for OIDC auth
- Latest version of the [Element web app](https://element.io/) to provide a web interface for chat (you can disable this and still use element apps)
- [Coturn TURN server subchart](https://github.com/small-hack/coturn-chart) for VoIP calls
- Use s3 to store media using [element-hq/synapse-s3-storage-provider](https://github.com/matrix-org/synapse-s3-storage-provider/tree/main)
- Use [matrix-sliding-sync-chart](https://github.com/small-hack/matrix-sliding-sync-chart) as a sub chart for using [element-x] which requires [matrix-org/sliding-sync](https://github.com/matrix-org/sliding-sync)
- Use existing Kubernetes secrets and existing Persistent Volume Claims

### ⚠️ Optional Features (Untested Since Fork)

These features still need to be tested, but are technically baked into the chart from the fork:

- Use of lightweight Exim relay
- [Half-Shot/matrix-appservice-discord](https://github.com/Half-Shot/matrix-appservice-discord) Discord bridge
- [matrix-org/matrix-appservice-irc](https://github.com/matrix-org/matrix-appservice-irc) IRC bridge
- [tulir/mautrix-whatsapp](https://github.com/tulir/mautrix-whatsapp) WhatsApp bridge


# Notes

## Databases

You must select one of the following options:

- Use the [Bitnami PostgreSQL subchart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) (set `postgresql.enabled` to `true`)
- Use your own external database, which can also be PostgreSQL. (set `externalDatabase.enabled` to `true`)

Note: you cannot enable both `externalDatabase` and `postgresql`. You must select _one_.


## Notes on using Matrix Sliding Sync

To use [sliding sync](https://github.com/matrix-org/sliding-sync), which is required for [element-x], you'll need to ensure that requests to `.well-known/matrix/client` return the [correct json](https://github.com/matrix-org/sliding-sync/blob/main/README.md). To do that, you'll want update your `matrix.extra_well_known_client_content` values and set `syncv3.enabled` to `true`. Example below:

```yaml
matrix:
  extra_well_known_client_content:
     "org.matrix.msc3575.proxy":
       "url": "https://your-sliding-sync-hostname.com"


syncv3:
  # this enables this subchart: https://github.com/small-hack/matrix-sliding-sync-chart
  # which deploys this: https://github.com/matrix-org/sliding-sync
  enabled: true
  server: "https://my-synapse-hostname.com"
  secret: "this.is.a.test.secret"
  bindaddr: "127.0.0.1:8008"
  # note: you'll still have to actually fill out parameters
  # under slidingSync.postgresql, but it is truncated here for brevity
  # check out values.yaml for all possible slidingSync.postgresql values
  postgresql:
    enabled: true
```

## Notes on using MAS (Matrix Authentication Service)

MAS is currently the only way to use OIDC with [element-x]. If you're using MAS (Matrix Authentication Service), you'll need to set `mas.enabled` to `true`. You'll also need to setup proper routes for synapse to redirect to MAS. See example below:

```yaml
matrix:
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

After synapse is up, you should be able to verify it's returning correctly by doing:

```console
$ curl https://matrix.example.com/.well-known/matrix/client | jq
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   136  100   136    0     0   1818      0 --:--:-- --:--:-- --:--:--  1837
{
  "m.homeserver": {
    "base_url": "https://matrix.example.com"
  },
  "org.matrix.msc3575.proxy": {
    "url": "https://matrix.example.com"
  }
}

```

## About and Status

This is a fork of [Arkaniad/matrix-chart](https://github.com/Arkaniad/matrix-chart), which is a fork of [typokign/matrix-chart](https://github.com/typokign/matrix-chart). We recently transferred this chart from [@jessebot](https://github.com/jessebot) to the small-hack org to help with maintanence longterm :) Working on full stability, but always happy to receive GitHub Issues or PRs 💙 Please star the repo if you like our work <3

Our goal is to provide regular updates using renovatebot and provide some level of basic security from a k8s perspective. We're also trying to standardize the chart more by following predictable values.yaml patterns.

<!-- links -->
[element-x]: https://element.io/labs/element-x "element x link"
[sliding sync]: https://github.com/matrix-org/sliding-sync "matrix sliding sync"
