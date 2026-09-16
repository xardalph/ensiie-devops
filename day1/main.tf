
resource "random_pet" "pet" {
  prefix = "dev"
  separator = "-"
}

resource "local_file" "foo" {
 lifecycle {
  precondition {
      condition     = random_pet.pet.prefix == "dev"
      error_message = "file prefix should be dev"
    }
 }
  content  = "${random_pet.pet.id}\n"
  file_permission = "0640"
  filename = "./dist/pet.txt"
}

output "pet_name" {
  value = random_pet.pet.id
}


