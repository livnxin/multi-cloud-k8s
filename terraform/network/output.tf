output "aws_control_interface_id" {
  value       = aws_network_interface.control_interface.id
  description = "The id of the network interface for control node of AWS"
}

output "aws_worker_interface_id" {
  value       = aws_network_interface.worker_interface.id
  description = "The id of the network interface for worker node(s) of AWS"
}