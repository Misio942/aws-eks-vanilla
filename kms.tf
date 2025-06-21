resource "aws_kms_key" "main" {
  description = var.project_name
}

resource "aws_kms_alias" "main" {
  name          = format("alias/%s-v3", var.project_name)
  target_key_id = aws_kms_key.main.id
}