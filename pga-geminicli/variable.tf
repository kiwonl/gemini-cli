variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
  default     = "qwiklabs-gcp-03-a14053491bef"
}

variable "region" {
  description = "The region for the resources."
  type        = string
  default     = "us-central1"
}

variable "network_id" {
  type        = string
  description = "The ID of the VPC network."
  default     = "gemini-vpc-net"
}

variable "vm_name" {
  description = "The name of the VM instance."
  type        = string
  default     = "cli-vm"
}

variable "machine_type" {
  description = "The machine type for the VM instance."
  type        = string
  default     = "n2-standard-2"
}