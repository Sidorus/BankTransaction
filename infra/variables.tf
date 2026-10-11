# Input values. Secrets and machine-specific values are set in terraform.tfvars (git-ignored).

variable "location" {
  type        = string
  description = "Azure region for all resources"
  default     = "westus2"
}

variable "sql_admin_password" {
  type        = string
  description = "Password of the SQL server admin login (adminuser)"
  sensitive   = true
}

variable "my_public_ip" {
  type        = string
  description = "Public IP of the local PC allowed to connect to SQL"
}
