
# tflint-ignore: terraform_required_providers
data "archive_file" "this" {
  type        = "zip"
  source_file = var.file_source_path
  output_path = var.file_output_path
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "this" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "this" {
  function_name    = var.lambda_function_name
  role             = aws_iam_role.this.arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  filename         = var.file_output_path
  source_code_hash = data.archive_file.this.output_base64sha256
  logging_config {
    log_format = "JSON"
  }

  tracing_config {
    mode = "Active"
  }
  environment {
    variables = merge(
      var.additional_variables,
      {},
    )
  }
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    #aws_cloudwatch_log_group.example,
  ]
}

# There is an issue with cloudatch logging group
# https://github.com/localstack/localstack/issues/11613
# resource "aws_cloudwatch_log_group" "example" {
#   name              = "/aws/lambda/${var.lambda_function_name}"
#   retention_in_days = 14
# }

# For now ignore tfsec rule
# tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "lambda_logging" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_role_policy_attachment" "aws_xray_write_only_access" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}