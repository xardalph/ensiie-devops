run "create_file" {
  command = apply


  # Check that the bucket name is correct
  assert {
    condition     = substr(output.pet_name, 0, 4) == "dev-"
    error_message = "Invalid pet_name"
  }

  # Check index.html hash matches
}
