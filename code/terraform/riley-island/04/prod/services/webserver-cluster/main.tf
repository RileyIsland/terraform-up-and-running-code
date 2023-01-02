module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "webserver-cluster-04-prod"
  db_remote_state_bucket = local.db_remote_state_bucket
  db_remote_state_key    = local.db_remote_state_key
}
