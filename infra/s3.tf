resource "aws_s3_bucket" "s3-grumpy-chimp-bucket" {
  bucket = "cda-2021-1-groupe-a-s3-grumpy-chimp-tf"
}

resource "aws_s3_bucket_acl" "s3-grumpy-chimp-acl" {
  bucket = aws_s3_bucket.s3-grumpy-chimp-bucket.bucket
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "s3-grumpy-chimp-policy" {
  bucket = aws_s3_bucket.s3-grumpy-chimp-bucket.id
  policy = file("bucket_policy.json")
}

resource "aws_s3_bucket_website_configuration" "s3-grumpy-chimp-policy" {
  bucket = aws_s3_bucket.s3-grumpy-chimp-bucket.bucket
  index_document {
    suffix = "index.html"
  }
}
