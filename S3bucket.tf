resource "aws_s3_bucket" "moveit_bucket" {
  bucket = "moveitbucketdev"
}

resource "aws_s3_object" "moveit_folder" {
  for_each = toset([
    "CCDirectBillData/In",
    "CCDirectBillData/In"
  ])

  bucket  = aws_s3_bucket.moveit_bucket.id
  key     = each.value
  content = ""
}

resource "aws_s3_bucket_policy" "moveit_policy" {
  bucket = aws_s3_bucket.moveit_bucket.id

  policy = jsonencode({
    Statement = [
      {
        sid    = "S3policy"
        Effect = "Allow"
        Principal = {
          AWS = [
            "*"
          ]
        }
        Action = "s3:*"
        Resource = [
          "arn:aws:s3::moveitbucketdev*"
        ]
      }
    ]
  })
}
