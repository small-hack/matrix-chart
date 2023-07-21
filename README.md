# Matrix Chart

A Helm chart for deploying a Matrix homeserver stack in Kubernetes. This is a fork of [Arkaniad/matrix-chart](https://github.com/Arkaniad/matrix-chart), which is a fork of [typokign/matrix-chart](https://github.com/typokign/matrix-chart).

## Features

- Latest version of [Synapse](https://github.com/matrix-org/synapse)
- Ingress definition for federated Synapse and Element

### Opptional Features
- Latest version of [Element](https://element.io/)
- Choice of lightweight Exim relay or external mail server for email notifications
- [Coturn TURN server](https://hub.docker.com/r/coturn/coturn) for VoIP calls
- [Bitnami PostgreSQL sub-chart](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) to deploy a cluster - needs some work to standardize though, so we also support external postgresql servers
- [matrix-org/matrix-appservice-irc](https://github.com/matrix-org/matrix-appservice-irc) IRC bridge
- [tulir/mautrix-whatsapp](https://github.com/tulir/mautrix-whatsapp) WhatsApp bridge
- [Half-Shot/matrix-appservice-discord](https://github.com/Half-Shot/matrix-appservice-discord) Discord bridge

## Installation

Some documentation is available in [`values.yaml`](./charts/matrix/values.yaml). See [charts/matrix/README.md](./charts/matrix/README.md) for docs auto-generated from the `values.yaml`.

### 

This is released normally, so you should be able to do:

```bash
helm repo add matrix https://jessebot.github.io/matrix-chart
helm repo update
helm install my-release-name matrix
```
