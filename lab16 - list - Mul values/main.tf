variable "team_members" {
  type = list(object({
    name = string
    age  = number
    location = object({
      city = string
    })
  }))
  default = [
    {
      name = "Alice"
      age  = 30
      location = {
        city = "New York"
      }
    },
    {
      name = "Bob"
      age  = 25
      location = {
        city = "San Francisco"
      }
    }
  ]
}

resource "null_resource" "example" {
  count = length(var.team_members)

  # Just a dummy resource to use count
  triggers = {
    name = var.team_members[count.index]["name"]
    age  = var.team_members[count.index]["age"]
    city = var.team_members[count.index]["location"]["city"]
  }
}

#  var.team_members[0].name --> "Alice" , var.team_members[0].age --> 30 , var.team_members[0].location.city --> "New York"

#  var.team_members[1]["name"] --> "Bob" , var.team_members[1]["age"] --> 25 , var.team_members[1]["location"]["city"] --> "San Francisco"

# Multiple List Value Accessed by dot (.) operator or notation [] operator