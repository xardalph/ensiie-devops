
resource "random_pet" "pet" {
  prefix = "dev"
  separator = "-"
}

resource "local_file" "foo" {
 lifecycle {
  precondition {
      condition     = random_pet.pet.prefix == "dev"
      error_message = "pet prefix should be dev"
    }
  precondition {
      condition     = random_pet.pet.separator == "-"
      error_message = "pet separator should be '-'"
    }
    postcondition {
      condition     = self.content == "${random_pet.pet.id}\n"
      error_message = "wrong file content"
    }
 }
  content  = "${random_pet.pet.id}\n"
  file_permission = "0640"
  filename = "./dist/pet.txt"
}

output "pet_name" {
  value = random_pet.pet.id
}


