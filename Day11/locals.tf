locals {
  bucket_name = substr(
    replace(
      replace(
        trimspace(lower(var.bucket_name)),
        "$",
        ""
      ),
      " ",
      "-"
    ),
    0,
    63
  )


  port_sg = [
    for port in split(",", var.ports) : {
      name : "port: ${port}"
      port : tonumber(port)
      describtion : "Allow traffic for this port: ${port}"
    }
  ]

  cureent_vm = lookup(var.vm, var.env, "t1-mini")
}
