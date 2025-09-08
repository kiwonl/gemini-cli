variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
  default     = "qwiklabs-gcp-03-a14053491bef"
}

variable "network_id" {
  type        = string
  description = "The ID of the VPC network."
  default     = "gemini-vpc-net"
}

variable "service_account_email" {
  type        = string
  description = "The email address of the service account."
  default     = "qwiklabs-gcp-03-a14053491bef@qwiklabs-gcp-03-a14053491bef.iam.gserviceaccount.com"
}

variable "vm_name" {
  description = "The name of the VM instance."
  type        = string
  default     = "cli-vm"
}

variable "zone" {
  description = "The zone for the VM instance."
  type        = string
  default     = "us-east1-b"
}

variable "machine_type" {
  description = "The machine type for the VM instance."
  type        = string
  default     = "n2-standard-2"
}