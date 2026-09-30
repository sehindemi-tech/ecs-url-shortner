resource "aws_ecr_repository" "ecs_shortener_repos" {
  for_each = var.ecr_repositories

  name                 = each.key
  image_tag_mutability = each.value.image_tag_mutability
  force_delete         = each.value.force_delete

  image_scanning_configuration {
    scan_on_push = each.value.scan_on_push
  }

  encryption_configuration {
    encryption_type = each.value.encryption_type
    kms_key         = each.value.encryption_type == "KMS" ? each.value.kms_key : null
  }
}

resource "aws_ecr_lifecycle_policy" "ecr_shortner_repos_lifecycle" {
  for_each   = aws_ecr_repository.ecs_shortener_repos
  repository = aws_ecr_repository.ecs_shortener_repos[each.key].name
  policy     = data.aws_ecr_lifecycle_policy_document.ecr_shortener_repos_lifecycle_policy.json
}
