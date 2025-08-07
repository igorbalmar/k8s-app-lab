variable "clusterName" {
  type    = string
}

variable "clusterLocation" {
  type    = string
}

variable "vmSize" {
  type    = string
}

variable "subscriptionId" {
  type    = string
}

variable "kubernetesVersion" {
    type = string
}

variable "albVersion" {
  type = string
}

variable "argoVersion" {
  type = string
}

variable "autoscaling" {
  type = string
}

variable "maxNodes" {
  type = number
}