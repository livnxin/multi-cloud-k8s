module "network" {
  source = "./network"
}

module "node" {
  source = "./node"

  aws_control_interface_id = module.network.aws_control_interface_id
  aws_worker_interface_id  = module.network.aws_worker_interface_id
}