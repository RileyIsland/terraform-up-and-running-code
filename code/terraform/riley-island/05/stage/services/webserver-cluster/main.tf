module "webserver_cluster" {
  cluster_name           = "webserver-cluster-05-stage"
  db_remote_state_bucket = local.db_remote_state_bucket
  db_remote_state_key    = local.db_remote_state_key
  source                 = "../../../modules/services/webserver-cluster"

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "terraform"
  }
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 12345
  protocol          = "tcp"
  security_group_id = module.webserver_cluster.alb_security_group_id
  to_port           = 12345
  type              = "ingress"
}
