# Matrix Chart

A Helm chart for deploying a Matrix homeserver stack in Kubernetes. This is a fork of [Arkaniad/matrix-chart](https://github.com/Arkaniad/matrix-chart), which is a fork of [typokign/matrix-chart](https://github.com/typokign/matrix-chart).

## Features

- Latest version of [Synapse](https://github.com/matrix-org/synapse)
- (Optional) Latest version of [Element](https://element.io/)
- (Optional) Choice of lightweight Exim relay or external mail server for email notifications
- (Optional) [Coturn TURN server](https://hub.docker.com/r/coturn/coturn) for VoIP calls
- (Optional) PostgreSQL cluster via [Bitnami](https://github.com/bitnami/charts/tree/main/bitnami/postgresql)
- (Optional) [matrix-org/matrix-appservice-irc](https://github.com/matrix-org/matrix-appservice-irc) IRC bridge
- (Optional) [tulir/mautrix-whatsapp](https://github.com/tulir/mautrix-whatsapp) WhatsApp bridge
- (Optional) [Half-Shot/matrix-appservice-discord](https://github.com/Half-Shot/matrix-appservice-discord) Discord bridge
- Ingress definition for federated Synapse and Element

## Installation

Some documentation is available in [values.yaml](./charts/matrix/values.yaml) (see [README](./charts/matrix/README.md) for more docs.

Choose one of the two options below to install the chart.

### Standard helm

This is released normally, so you should be able to do:

```bash
helm repo add matrix https://jessebot.github.io/matrix-chart
helm repo update
helm install my-release-name matrix
```

### Git

You can also clone this repo directly and override the values.yaml provided. To do so, run the following commands:

```bash
git clone https://github.com/dacruz21/matrix-chart.git
cd matrix-chart/charts/matrix
helm dependency update
helm install matrix .
```

## Security
Helm currently [does not officially support chart signatures created by GPG keys stored on smartcards](https://github.com/helm/helm/issues/2843#issuecomment-379532906). This may change in the future, in which case I will start packaging this chart with the standard `.prov` signatures, but until then signatures must be verified manually.

GPG signatures are available within the chart repo and can be found by appending `.gpg` to the end of the package URL. For example, the signature for v2.8.0 is available at https://dacruz21.github.io/helm-charts/matrix-2.8.0.tgz.gpg.

These GPG signatures are signed with the same PGP key that is used to sign commits in this Git repository. The key is available by searching for david@typokign.com on a public keyserver, or by downloading it from my website at https://typokign.com/key.gpg.

If you find any security vulnerabilities in this Helm chart, please contact me by sending a PGP-encrypted email (encrypted to `F13C346C0DE56944`) to david@typokign.com. Vulnerabilities in upstream services should be reported to that service's developers.
