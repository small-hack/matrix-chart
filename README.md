# Matrix Chart

A Helm chart for deploying a Matrix homeserver stack in Kubernetes. This is a fork of [Arkaniad/matrix-chart](https://github.com/Arkaniad/matrix-chart), which is a fork of [typokign/matrix-chart](https://github.com/typokign/matrix-chart). 

## TLDR

See [charts/matrix/README.md](./charts/matrix/README.md) for docs auto-generated from the [`values.yaml`](./charts/matrix/values.yaml).
Read through the parameters and modify them locally before installing the chart:

```bash
helm repo add matrix https://jessebot.github.io/matrix-chart
helm install my-release-name matrix --values values.yaml
```


## Current Features

- Latest version of [Synapse](https://github.com/matrix-org/synapse) (the official homeserver edition of matrix)
- Ingress definitions for federated Synapse (Matrix homeserver) and Element (frontend and CMS for matrix)
- Use (existing) Kubernetes Secrets for confidential data, such as passwords

### Optional Features

- Latest version of [Element](https://element.io/)
- [Bitnami PostgreSQL subchart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) to deploy a cluster - needs some work to standardize though, so we also support external postgresql servers

#### ⚠️ Optional Features (Untested Since Fork)

These features still need to be tested, but are technically baked into the chart:
- Choice of lightweight Exim relay or external mail server for email notifications
- [Coturn TURN server subchart](https://github.com/jessebot/coturn-chart) for VoIP calls
- [Half-Shot/matrix-appservice-discord](https://github.com/Half-Shot/matrix-appservice-discord) Discord bridge
- [matrix-org/matrix-appservice-irc](https://github.com/matrix-org/matrix-appservice-irc) IRC bridge
- [tulir/mautrix-whatsapp](https://github.com/tulir/mautrix-whatsapp) WhatsApp bridge


## Status
This chart is now maintained mostly by me, @jessebot, but I'd love contributors as well! My goal is to provide regular updates using dependabot (maybe renovatebot soon) and provide some level of basic security from a k8s perspective. The aim as of right now has been removing any plaintext secrets and allowing for existing PVCs. I'm also trying to standardize the chart more by following predictable values.yaml patterns.

Note: I may stop supporting this if a larger entity maintains a better matrix chart (e.g. Bitnami releases a matrix helm chart), as then I'll just write PRs directly to them. At that time I'll put in a note in this README before publically archiving the repo.
