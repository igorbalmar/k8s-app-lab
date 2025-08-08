# AKS infra + observability stack + GitOps

## Setup:

Terraform:
- AKS 
- Application Gateway for Containers (alb-controller)
- Autoscaler
- Cilium overlay


Instalado Manual (due to mutating and validating webhook problems):
- otel operator

ArgoCD applications:
- cert-manager
- prometheus server
- prometheus node exporter
- grafana server
- grafana loki
- grafana tempo
- auto instrumentation
- otel collector


To do:
- external-dns
- cilium monitoring
- canary deploy (argo rollouts)
- kube-cost
- cluster mesh (cilium)
- ajustar saneamento das imagens
- profiling (pyroscope)
- autenticação da stack de monitoramento
- scan de segurança das imagens geradas
- mutating validando recursos alterados
- admission webhook com políticas de repositório, namespace, etc
- definir cotas para controle de custos
- arrumar prometheus

Débito técnico:
- ajustar o chart do otel operator




![Diagrama da solução:](https://raw.githubusercontent.com/igorbalmar/k8s-app-lab/refs/heads/main/lab-kubernetes.drawio.png)