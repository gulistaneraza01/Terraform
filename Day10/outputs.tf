output "instances_id" {
  value = aws_instance.node_server[*].id

}
