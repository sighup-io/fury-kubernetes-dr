/**
 * Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

resource "aws_iam_user" "velero_backup_user" {
  name = "${var.backup_bucket_name}-velero-backup"
  path = "/"
  tags = var.tags
}

resource "aws_iam_policy_attachment" "velero_backup" {
  name       = "${var.backup_bucket_name}-velero-backup"
  users      = [aws_iam_user.velero_backup_user.name]
  policy_arn = aws_iam_policy.velero_backup.arn
}

resource "aws_iam_access_key" "velero_backup" {
  user = aws_iam_user.velero_backup_user.name
}

resource "aws_iam_policy" "velero_backup" {
  name = "${var.backup_bucket_name}-velero-backup"

  policy = <<EOF
{
     "Version": "2012-10-17",
     "Statement": [
         {
             "Effect": "Allow",
             "Action": [
                 "ec2:DescribeVolumes",
                 "ec2:DescribeSnapshots",
                 "ec2:CreateTags",
                 "ec2:CreateVolume",
                 "ec2:CreateSnapshot",
                 "ec2:DeleteSnapshot"
             ],
             "Resource": "*"
         },
         {
             "Effect": "Allow",
             "Action": [
                 "s3:GetObject",
                 "s3:DeleteObject",
                 "s3:PutObject",
                 "s3:AbortMultipartUpload",
                 "s3:ListMultipartUploadParts"
             ],
            "Resource": "${aws_s3_bucket.backup_bucket.arn}/*"
         },
         {
             "Effect": "Allow",
             "Action": [
                 "s3:ListBucket"
             ],
            "Resource": "${aws_s3_bucket.backup_bucket.arn}"
         }
     ]
}
EOF
}
