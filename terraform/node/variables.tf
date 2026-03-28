variable "control_interface_id" {
  description = "The id of the network interface for control node of AWS"
}

variable "worker_interface_id" {
  description = "The id of the network interface for worker node(s) of AWS"
}

variable "worker_count" {
  default     = 1
  type        = number
  description = "The number of worker node(s)"
}