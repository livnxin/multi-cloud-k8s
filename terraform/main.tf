module "network" {
    source = "./network"
}

module "node" {
    source = "./node"

    control_interface_id = module.network.control_interface_id
    worker_interface_id = module.network.worker_interface_id
}