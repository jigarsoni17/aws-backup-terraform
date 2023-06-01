resource "aws_backup_plan" "example" {
  name = "tf_example_backup_plan"
  dynamic "rule" {
    for_each = var.rules
    content {
          rule_name         = lookup(rule.value, "name", null)
          target_vault_name = "DB"
          schedule          =  lookup(rule.value, "schedule", null)
          start_window      = lookup(rule.value, "start_window", null)
          completion_window = lookup(rule.value, "completion_window", null)

          lifecycle {
            delete_after = lookup(rule.value, "delete_after", null)
            cold_storage_after = lookup(rule.value, "cold_storage_after", null)
          }
        }
  }
}