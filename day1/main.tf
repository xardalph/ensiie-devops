resource "random_pet" "pet" {
  prefix = "dev"
  separator = "-"
}

resource "local_file" "foo" {
  content  = "dev-${random_pet.pet.id}\n"
  file_permission = "0640"
  filename = "./dist/pet.txt"
}

output "pet_name" {
  value = random_pet.pet.id
}


