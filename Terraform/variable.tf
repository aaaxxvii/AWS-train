variable "project_name" {
  description = "リソース名のプレフィックス"
  default     = "gemini-tf"
}

variable "google_api_key" {
  description = "Gemini API Key"
  type        = string
  sensitive   = true # ログに表示されないようにする
}

variable "ecr_image_uri" {
  description = "ECR Image URI (手動で作ったリポジトリのURI)"
  type        = string
}