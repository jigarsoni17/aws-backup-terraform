key               = "Backup"
value             = "True"
rules = [{
  name                     = "daily_snapshot"
#   schedule                 = "cron(40 6 ? * MON-SUN *)"
  start_window             = 480
  completion_window        = 10080
  delete_after             = 35
  },

  {
    name                     = "monthly_snapshot"
    schedule                 = "cron(0 0 1 * ? *)"
    start_window             = 480
    completion_window        = 10080
    delete_after             = 365
    cold_storage_after       = 30
  }
]



   