variable "subscription_id" {
  type        = string
  description = "The Azure Subscription ID in which the Resource Group should exist."
}

variable "tags" {
  description = "A map of tags to assign to the resource group"
  type        = map(string)
}