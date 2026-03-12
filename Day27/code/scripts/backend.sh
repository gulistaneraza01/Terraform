#!/bin/bash

set -e

BUCKET_NAME="$1"
REGION="${2:-us-east-1}"

if [[ -z "$BUCKET_NAME" ]]; then
  echo "Usage: $0 <bucket-name> [region]"
  exit 1
fi

# Create the bucket
aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" \
  $( [[ "$REGION" != "us-east-1" ]] && echo --create-bucket-configuration LocationConstraint=$REGION )

echo "Bucket '$BUCKET_NAME' created."

# Enable versioning
aws s3api put-bucket-versioning --bucket "$BUCKET_NAME" --versioning-configuration Status=Enabled
echo "Versioning enabled on '$BUCKET_NAME'."

# Set bucket ACL to private
aws s3api put-bucket-acl --bucket "$BUCKET_NAME" --acl private
echo "ACL set to private on '$BUCKET_NAME'."

# Enable default AES256 encryption
aws s3api put-bucket-encryption --bucket "$BUCKET_NAME" --server-side-encryption-configuration '{
  "Rules": [
    {
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }
  ]
}'
echo "Default encryption (AES256) enabled on '$BUCKET_NAME'."