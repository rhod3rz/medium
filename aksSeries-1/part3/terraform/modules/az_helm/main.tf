# Install akv2k8s.
resource "helm_release" "akv2k8s" {
  name             = "akv2k8s"
  chart            = "akv2k8s"
  version          = "2.5.0"
  repository       = "https://charts.spvapi.no"
  namespace        = "akv2k8s"
  atomic           = true
  create_namespace = true
}
