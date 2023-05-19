output "function_invoke_arns" {
  value = {
    "get-all-authors" = module.lambda_function_get_all_authors.lambda_function_invoke_arn
    "get-all-courses" = module.lambda_function_get_all_courses.lambda_function_invoke_arn
    "get-course"      = module.lambda_function_get_course.lambda_function_invoke_arn
    "save-course"     = module.lambda_function_save_course.lambda_function_invoke_arn
    "update-course"   = module.lambda_function_update_course.lambda_function_invoke_arn
    "delete-course"   = module.lambda_function_delete_course.lambda_function_invoke_arn
  }
}