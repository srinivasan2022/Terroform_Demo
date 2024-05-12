locals {
  fruits = ["apple", "banana", "orange"]
}

resource "null_resource" "example" {

  count = length(local.fruits)
}

output "example" {
  value = null_resource.example[*].triggers
}

# local.fruits[0] --> "apple"
# local.fruits[1] -->  "banana"    Accessed by index value
# local.fruits[2] -->  "orange"
