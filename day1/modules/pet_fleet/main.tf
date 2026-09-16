variable "fleet_size" {
type = number
}

resource "random_pet" "pet" {
  count = "${var.fleet_size}"
  keepers = { count = "${var.fleet_size}" }
  prefix = "dev"
  separator = "-"
}

resource "local_file" "foo" {
count = "${var.fleet_size}"
 lifecycle {
  precondition {
      condition     = random_pet.pet[count.index].prefix == "dev"
      error_message = "pet prefix should be dev"
    }
  precondition {
      condition     = random_pet.pet[count.index].separator == "-"
      error_message = "pet separator should be '-'"
    }
    postcondition {
      condition     = self.content == "${random_pet.pet[count.index].id}\n"
      error_message = "wrong file content"
    }
 }
  content  = "${random_pet.pet[count.index].id}\n"
  file_permission = "0640"
  filename = "./dist/${random_pet.pet[count.index].id}.txt"
}

output "pet_name" {
 value = {
    for k, bd in local_file.foo : k => bd.filename
  }
}

