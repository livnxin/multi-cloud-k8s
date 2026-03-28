module "network" {
    source = "./network"
}

module "node" {
    source = "./node"

    control_interface_id = module.network.control_interface_id
}