locals {
  name = upper(replace(var.name, "a", "b"))
}
