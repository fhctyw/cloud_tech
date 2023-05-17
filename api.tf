module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage
}

# /authors
resource "aws_api_gateway_resource" "api_gateway_authors" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "authors"

}

# GET /authors
resource "aws_api_gateway_method" "api_gateway_authors_get" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_authors.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_gateway_authors_get" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_authors.id
  http_method = aws_api_gateway_method.api_gateway_authors_get.http_method

  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = module.lambda_function_get_all_authors.lambda_function_invoke_arn
}

resource "aws_api_gateway_method_response" "api_gateway_authors_get" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_authors.id
  http_method = aws_api_gateway_method.api_gateway_authors_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "api_gateway_authors_get" {
  depends_on = [aws_api_gateway_integration.api_gateway_authors_get]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_authors.id
  http_method = aws_api_gateway_method.api_gateway_authors_get.http_method
  status_code = aws_api_gateway_method_response.api_gateway_authors_get.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# OPTIONS /authors
resource "aws_api_gateway_method" "api_gateway_authors_options" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_authors.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_gateway_authors_options" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_authors.id
  http_method = aws_api_gateway_method.api_gateway_authors_options.http_method

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  type = "MOCK"
}

resource "aws_api_gateway_method_response" "api_gateway_authors_options" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_authors.id
  http_method = aws_api_gateway_method.api_gateway_authors_options.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Headers" = true,
  }
}

resource "aws_api_gateway_integration_response" "api_gateway_authors_options" {
  depends_on = [aws_api_gateway_integration.api_gateway_authors_options]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_authors.id
  http_method = aws_api_gateway_method.api_gateway_authors_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'",
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }
}

######################################

# /courses
resource "aws_api_gateway_resource" "api_gateway_courses" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "courses"

}

# GET /courses
resource "aws_api_gateway_method" "api_gateway_courses_get" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_courses.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_gateway_courses_get" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses.id
  http_method = aws_api_gateway_method.api_gateway_courses_get.http_method

  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = module.lambda_function_get_all_courses.lambda_function_invoke_arn
}

resource "aws_api_gateway_method_response" "api_gateway_courses_get" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses.id
  http_method = aws_api_gateway_method.api_gateway_courses_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "api_gateway_courses_get" {
  depends_on = [aws_api_gateway_integration.api_gateway_courses_get]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses.id
  http_method = aws_api_gateway_method.api_gateway_courses_get.http_method
  status_code = aws_api_gateway_method_response.api_gateway_courses_get.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# # POST /courses
resource "aws_api_gateway_method" "api_gateway_courses_post" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_courses.id
  http_method   = "POST"
  authorization = "NONE"

  request_models = {
    "application/json" = aws_api_gateway_model.api_gateway_model_course.name
  }
  request_validator_id = aws_api_gateway_request_validator.api_gateway_courses_post_request_validator.id
}

resource "aws_api_gateway_model" "api_gateway_model_course" {
  rest_api_id  = aws_api_gateway_rest_api.api_gateway.id
  name         = "CourseInputModel"
  content_type = "application/json"

  schema = <<EOF
{
  "$schema": "http://json-schema.org/schema#",
  "title": "CourseInputModel",
  "type": "object",
  "properties": {
    "title": {"type": "string"},
    "authorId": {"type": "string"},
    "length": {"type": "string"},
    "category": {"type": "string"}
  },
  "required": ["title", "authorId", "length", "category"]
}
EOF
}

resource "aws_api_gateway_request_validator" "api_gateway_courses_post_request_validator" {
  name                  = "request_validator"
  rest_api_id           = aws_api_gateway_rest_api.api_gateway.id
  validate_request_body = true
}

resource "aws_api_gateway_integration" "api_gateway_courses_post" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_gateway_courses.id
  http_method             = aws_api_gateway_method.api_gateway_courses_post.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = module.lambda_function_save_course.lambda_function_invoke_arn
}

resource "aws_api_gateway_method_response" "api_gateway_courses_post" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses.id
  http_method = aws_api_gateway_method.api_gateway_courses_post.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "api_gateway_courses_post" {
  depends_on = [aws_api_gateway_integration.api_gateway_courses_post]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses.id
  http_method = aws_api_gateway_method.api_gateway_courses_post.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# OPTIONS /courses
resource "aws_api_gateway_method" "api_gateway_courses_options" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_courses.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_gateway_courses_options" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses.id
  http_method = aws_api_gateway_method.api_gateway_courses_options.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "api_gateway_courses_options" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses.id
  http_method = aws_api_gateway_method.api_gateway_courses_options.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Headers" = true,
  }
}

resource "aws_api_gateway_integration_response" "api_gateway_courses_options" {
  depends_on = [aws_api_gateway_integration.api_gateway_courses_options]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses.id
  http_method = aws_api_gateway_method.api_gateway_courses_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST'",
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }
}

######################################################

# /courses/{id}
resource "aws_api_gateway_resource" "api_gateway_courses_id" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_resource.api_gateway_courses.id
  path_part   = "{id}"
}

# GET /courses/{id}
resource "aws_api_gateway_method" "api_gateway_courses_id_get" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_gateway_courses_id_get" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_get.http_method

  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = module.lambda_function_get_course.lambda_function_invoke_arn

  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = <<EOF
{
  "id": "$input.params('id')"
}
EOF
  }
}

resource "aws_api_gateway_method_response" "api_gateway_courses_id_get" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "api_gateway_courses_id_get" {
  depends_on = [aws_api_gateway_integration.api_gateway_courses_id_get]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_get.http_method
  status_code = aws_api_gateway_method_response.api_gateway_courses_id_get.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# PUT /courses/{id}
resource "aws_api_gateway_method" "api_gateway_courses_id_put" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_gateway_courses_id_put" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_put.http_method

  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = module.lambda_function_update_course.lambda_function_invoke_arn

  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = <<EOF
{
  "id": "$input.params('id')",
  "title" : $input.json('$.title'),
  "authorId" : $input.json('$.authorId'),
  "length" : $input.json('$.length'),
  "category" : $input.json('$.category'),
  "watchHref" : $input.json('$.watchHref')
}
EOF
  }
}

resource "aws_api_gateway_method_response" "api_gateway_courses_id_put" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_put.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "api_gateway_courses_id_put" {
  depends_on = [aws_api_gateway_integration.api_gateway_courses_id_put]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_put.http_method
  status_code = aws_api_gateway_method_response.api_gateway_courses_id_put.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# DELETE /courses/{id}
resource "aws_api_gateway_method" "api_gateway_courses_id_delete" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method   = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_gateway_courses_id_delete" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_delete.http_method

  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = module.lambda_function_delete_course.lambda_function_invoke_arn

  passthrough_behavior = "WHEN_NO_TEMPLATES"

  request_templates = {
    "application/json" = <<EOF
{
  "id": "$input.params('id')"
}
EOF
  }
}

resource "aws_api_gateway_method_response" "api_gateway_courses_id_delete" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_delete.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "api_gateway_courses_id_delete" {
  depends_on = [aws_api_gateway_integration.api_gateway_courses_id_delete]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_delete.http_method
  status_code = aws_api_gateway_method_response.api_gateway_courses_id_delete.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

# OPTIONS /courses/{id}
resource "aws_api_gateway_method" "api_gateway_courses_id_options" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_gateway_courses_id_options" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_options.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "api_gateway_courses_id_options" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_options.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Headers" = true,
  }
}

resource "aws_api_gateway_integration_response" "api_gateway_courses_id_options" {
  depends_on = [aws_api_gateway_integration.api_gateway_courses_id_options]

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.api_gateway_courses_id.id
  http_method = aws_api_gateway_method.api_gateway_courses_id_options.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = "'*'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,PUT,DELETE,OPTIONS'",
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }
}

######################################################

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id

  depends_on = [
    aws_api_gateway_method.api_gateway_authors_get,
    aws_api_gateway_integration.api_gateway_authors_get,
    aws_api_gateway_method_response.api_gateway_authors_get,
    aws_api_gateway_integration_response.api_gateway_authors_get,

    aws_api_gateway_method.api_gateway_authors_options,
    aws_api_gateway_integration.api_gateway_authors_options,
    aws_api_gateway_method_response.api_gateway_authors_options,
    aws_api_gateway_integration_response.api_gateway_authors_options,

    aws_api_gateway_method.api_gateway_courses_get,
    aws_api_gateway_integration.api_gateway_courses_get,
    aws_api_gateway_method_response.api_gateway_courses_get,
    aws_api_gateway_integration_response.api_gateway_courses_get,

    aws_api_gateway_method.api_gateway_courses_post,
    aws_api_gateway_integration.api_gateway_courses_post,
    aws_api_gateway_method_response.api_gateway_courses_post,
    aws_api_gateway_integration_response.api_gateway_courses_post,

    aws_api_gateway_method.api_gateway_courses_options,
    aws_api_gateway_integration.api_gateway_courses_options,
    aws_api_gateway_method_response.api_gateway_courses_options,
    aws_api_gateway_integration_response.api_gateway_courses_options,

    aws_api_gateway_method.api_gateway_courses_id_get,
    aws_api_gateway_integration.api_gateway_courses_id_get,
    aws_api_gateway_method_response.api_gateway_courses_id_get,
    aws_api_gateway_integration_response.api_gateway_courses_id_get,

    aws_api_gateway_method.api_gateway_courses_id_put,
    aws_api_gateway_integration.api_gateway_courses_id_put,
    aws_api_gateway_method_response.api_gateway_courses_id_put,
    aws_api_gateway_integration_response.api_gateway_courses_id_put,

    aws_api_gateway_method.api_gateway_courses_id_delete,
    aws_api_gateway_integration.api_gateway_courses_id_delete,
    aws_api_gateway_method_response.api_gateway_courses_id_delete,
    aws_api_gateway_integration_response.api_gateway_courses_id_delete,

    aws_api_gateway_method.api_gateway_courses_id_options,
    aws_api_gateway_integration.api_gateway_courses_id_options,
    aws_api_gateway_method_response.api_gateway_courses_id_options,
    aws_api_gateway_integration_response.api_gateway_courses_id_options,
  ]
}

# dev stage 
resource "aws_api_gateway_stage" "api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  stage_name    = "dev"
}