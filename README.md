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

- Latest version of [Synapse](https://github.com/matrix-org/synapse) (the official matrix homeserver)
- Ingress definitions for federated Synapse (Matrix homeserver) and Element (client for matrix)
- Use existing Kubernetes secrets and existing Persistent Volume Claims

### Optional Features

- Use (existing) Kubernetes Secrets for confidential data, such as passwords
- Use OIDC configs for SSO (see synapse [docs](https://github.com/matrix-org/synapse/blob/747416e94cd8f137b9173c132f7c44ea1c59534d/docs/openid.md) for more info)
- Latest version of [Element](https://element.io/)
- [Coturn TURN server subchart](https://github.com/small-hack/coturn-chart) for VoIP calls
- Use [s3 to store stuff](https://github.com/matrix-org/synapse-s3-storage-provider/tree/main)
- Use an existing Kubernetes Secret for an external mail server for email notifications
- Use [matrix-sliding-sync-chart](https://github.com/small-hack/matrix-sliding-sync-chart) as a sub chart for using [element-x] (new element beta) which requires [matrix-org/sliding-sync](https://github.com/matrix-org/sliding-sync)
- Use [matrix-authentication-service-chart](https://github.com/small-hack/matrix-authentication-service-chart) as a sub chart for using [element-x] (new element beta) which recommends [matrix-org/matrix-authentication-service](https://github.com/matrix-org/matrix-authentication-service) for OIDC auth

#### Databases

You must select one of the following options:

- Use the [Bitnami PostgreSQL subchart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) (set `postgresql.enabled` to `true`)
- Use your own external database, which can also be PostgreSQL. (set `externalDatabase.enabled` to `true`)

Note: you cannot enable both `externalDatabase` and `postgresql`. You must select _one_.

### ⚠️ Optional Features (Untested Since Fork)

These features still need to be tested, but are technically baked into the chart from the fork:

- Use of lightweight Exim relay
- [Half-Shot/matrix-appservice-discord](https://github.com/Half-Shot/matrix-appservice-discord) Discord bridge
- [matrix-org/matrix-appservice-irc](https://github.com/matrix-org/matrix-appservice-irc) IRC bridge
- [tulir/mautrix-whatsapp](https://github.com/tulir/mautrix-whatsapp) WhatsApp bridge

## Notes on using Matrix Sliding Sync

To use [matrix sliding sync](https://github.com/matrix-org/sliding-sync), which is required for [element-x](https://element.io/labs/element-x), you'll need to ensure that requests to `.well-known/matrix/client` return the [correct json](https://github.com/matrix-org/sliding-sync/blob/main/README.md?plain=1#L51-L61). To do that, you'll want to pass in the following ingress annnotation show below:

```yaml
synapse:
  enabled: true
  ingress:
    enabled: true
    # -- hostname for your synapse server
    host: matrix.example.com
    # -- ingressClassName for the k8s ingress
    className: "nginx"
    tls:
      enabled: true
      secretName: "matrix-tls"
    annotations:
      # -- This annotation is required for the Nginx ingress provider. You can
      # remove it if you use a different ingress provider
      nginx.ingress.kubernetes.io/configuration-snippet: |
        proxy_intercept_errors off;
      # -- required for TLS certs issued by cert-manager
      cert-manager.io/cluster-issuer: letsencrypt-staging
      # an example for returning the correct json required for syncv3
      # see more info here: https://github.com/matrix-org/sliding-sync/blob/693587ef7e1c47cd04a667332ef133146132a713/README.md?plain=1#L51-L61
      nginx.ingress.kubernetes.io/server-snippet: |-
        location = /.well-known/matrix/client {
            return 200 '{"m.homeserver": {"base_url": "https://matrix.example.com"},"org.matrix.msc3575.proxy": {"url": "https://matrix.example.com"}}';
        }

# this enables https://github.com/matrix-org/sliding-sync
slidingSync:
  enabled: false
  syncv3:
    server: https://example.com

  # note: you'll still have to actually fill out parameters
  # under slidingSync.postgresql, but it is truncated here for brevity
  # check out values.yaml for all possible slidingSync.postgresql values
  postgresql:
    enabled: true
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

Note: We may stop supporting this if a larger entity maintains a better quality matrix chart (e.g. Bitnami releases a matrix helm chart), as then we'll just write PRs directly to them. At that time we'll put in a note in this README before publicly archiving the repo. As of right now though, in October 2023, there are no other actively maintained matrix helm charts for matrix that meet all our needs or are regularly updated to justify creating PRs.


/* links */
[element-x]: https://element.io/labs/element-x "element x link"
