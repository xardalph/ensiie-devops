
module "pet_fleet" {
  source = "./modules/pet_fleet"
  fleet_size = 10
}

module "script_runner" {
  source = "./modules/script_runner"
  files_names = module.pet_fleet.pet_name
}

output "p" {
  value =  { v = module.pet_fleet.pet_name }
}
