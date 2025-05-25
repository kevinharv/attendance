/*
    Attendance app Lambda function module.
*/

resource "aws_lambda_function" "function" {
  function_name = "${var.environment}--LAMBDA--Attend--${var.name}"
  description = var.description
  filename = "${path.module}/../../../services/${var.name}/function.zip"
  source_code_hash = filebase64sha256("${path.module}/../../../services/${var.name}/function.zip")

  architectures = [ "arm64" ]
  memory_size = 128
  handler = "app.handler"
  runtime = "python3.12"

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "lambda_basic_logging" {
  name = "lambda_basic_logging_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logging_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_basic_logging.arn
}
