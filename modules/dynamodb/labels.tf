module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace   = var.namespace
  stage       = var.stage
  name        = var.name
  label_order = ["stage", "namespace", "name"]
  delimiter   = "-"
}