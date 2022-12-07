output "myoutput"{

    value=[for y in var.aws_s3_tag:y["name"]]
    description="Bucket created successfully"
}