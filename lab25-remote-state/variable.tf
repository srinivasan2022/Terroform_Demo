variable "vnets" {
  type = map(object({
    address_space = string
    subnets = map(object({
      name           = string
      address_prefix = string
    }))
  }))
}

# tfvars file

# vnets = {
#     "vnet1" = {
#         address_space = "10.1.0.0/16"
#         subnets = {
#             "subnet1" = {
#                 name = "subnet1"
#                 address_prefix = "10.1.1.0/24"
#             },
#             "subnet2" = {
#                 name = "subnet2"
#                 address_prefix = "10.1.2.0/24"
#             }
#         }
#     },
#     "vnet2" = {
#         address_space = "10.2.0.0/16"
#         subnets = {
#             "subnet1" = {
#                 name = "subnet1"
#                 address_prefix = "10.2.1.0/24"
#             },
#             "subnet2" = {
#                 name = "subnet2"
#                 address_prefix = "10.2.2.0/24"
#             }
#         }
#     },
#     "vnet3" = {
#         address_space = "10.3.0.0/16"
#         subnets = {
#              "subnet1" = {
#                 name = "subnet1"
#                 address_prefix = "10.3.1.0/24"
#             },
#             "subnet2" = {
#                 name = "subnet2"
#                 address_prefix = "10.3.2.0/24"
#             }
#         }
#     }

#   }