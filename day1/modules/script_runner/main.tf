variable "files_names" {
  type = map
}
resource "random_pet" "ls" {

  for_each = tomap(var.files_names)
  provisioner "local-exec" {
    command = "touch  ${each.value}.touch"
  }
}
