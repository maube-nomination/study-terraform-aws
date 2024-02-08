resource "aws_lambda_function" "lambda_grumpy_chimp_tf" {
  filename         = "../exchange-rate/dist.zip"
  function_name    = "cda-2021-1-groupe-a-lambda-grumpy-chimp-tf"
  role             = aws_iam_role.iam_for_lambda_grumpy_chimp_tf.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256("../exchange-rate/dist.zip")
  runtime          = "nodejs16.x"
}

resource "aws_iam_role" "iam_for_lambda_grumpy_chimp_tf" {
  name = "cda-2021-1-groupe-a-iam-grumpy-chimp-tf"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })

  tags = {
    tag-key = "cda-2021-1"
  }
}

resource "aws_lambda_permission" "permission_for_lambda_grumpy_chimp_tf" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_grumpy_chimp_tf.function_name
  source_arn    = aws_cloudwatch_event_rule.schedule_for_lambda_grumpy_chimp_tf.arn
  principal     = "lambda.amazonaws.com"
}

resource "aws_cloudwatch_event_target" "event_target_for_lambda_grumpy_chimp_tf" {
  rule      = aws_cloudwatch_event_rule.schedule_for_lambda_grumpy_chimp_tf.name
  target_id = "lambda_grumpy_chimp_tf"
  arn       = aws_lambda_function.lambda_grumpy_chimp_tf.arn
}

resource "aws_cloudwatch_event_rule" "schedule_for_lambda_grumpy_chimp_tf" {
  name                = "cda-2021-1-groupe-a-schedule-grumpy-chimp-tf"
  description         = "Schedule for my grumpy chimp Lambda Function (terraform)"
  schedule_expression = "cron(0 6 * * ? *)"
}
