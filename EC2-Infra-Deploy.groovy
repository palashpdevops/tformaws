#!groovy

def Deploy() {
  sh '''"#!/bin/bash -ex"
  pip install --user quiet argparse boto3 botocore
  python -m script.stack_deployer \\
  --action "deploy" \\
  --template_path $ARCH_PATH \\
  --var_path $VAR_PATH \\
  --s3_bucket $S3_BUCKET \\
  --s3_path $S3_PATH \\
  --region $REGION
  '''.stripIndent()

}

return this;
