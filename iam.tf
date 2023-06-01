data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "example" {
  name               = "example"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "example" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.example.name
}


resource "aws_backup_selection" "example" {
  iam_role_arn = aws_iam_role.example.arn
  name         = "tf_example_backup_selection"
  plan_id      = aws_backup_plan.example.id
  resources    = ["*"]

  condition {
    string_equals {
      key   = "aws:ResourceTag/backup_plan"
      value = "test"
    }
  }
}


// if you want to add another resourse on same aws backup plan than use this block

# resource "aws_backup_selection" "example1" {
#   iam_role_arn = aws_iam_role.example.arn
#   name         = "tf_example_second"
#   plan_id      = aws_backup_plan.example.id
#   resources    = ["*"]

#   condition {
#     string_equals {
#       key   = "aws:ResourceTag/backup"
#       value = "plan"
#     }
#   }
# }