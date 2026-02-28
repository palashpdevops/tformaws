# Fetch S3 Bucket and then create subfolder and resource policy

resource "aws_s3_bucket" "apidata_bucket" {
  bucket = "apidatabucketdev"
}

resource "aws_s3_object" "apidata_folder" {
  for_each = toset([
    "PayBillData/In",
    "PayBillData/In"
  ])

  bucket  = aws_s3_bucket.apidata_bucket.id
  key     = each.value
  content = ""
# Tag is required if Sentinel is enabled and existing AWS resource is Tagged, If tag data is mismatched policy check will fail"
    tags = {
      "Unitcode"  = "90"
      "STACK"     = "BILLData"
      "ManagedBy" = "Terraform"
      "WORKSPACE" = "Terraform_Payu"
    }
}

resource "aws_s3_bucket_policy" "apidata_policy" {
  bucket = aws_s3_bucket.apidata_bucket.id

  policy = jsonencode({
    Statement = [
      {
        sid    = "S3policy"
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn::aws:iam::$AWS_ACCT::role/DEVOPS_PLAYDATA",
            "arn::aws:iam::$AWS_ACCT::user/PAYU"
          ]
        }
        Action = "s3:*"
        Resource = [
          "arn:aws:s3::apidatabucketdev",
          "arn:aws:s3::apidatabucketdev/*",
          "arn:aws:s3::apidatabucketdev/BillData*",
          "arn:aws:s3::apidatabucketdev/BillData/*"
        ]
      }
    ]
  })
}

# S3 Bucket lifecycle configuration
resource "aws_s3_bucket_lifecycle_configuration" "objects_retention" {
  bucket = aws_s3_bucket.apidatabucketdev.id

  rule {
    id     = "ExpireObjectsAfter14Days"
    status = "Enabled"

    expiration {
      days = 14
    }

    filter {
      prefix = "" # applies to all objects
    }
# Expire noncurrent versions after 14 days    
    noncurrent_version_expiration {
      noncurrent_days = 14
    }
# Cleanup uncomplete uploads
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
