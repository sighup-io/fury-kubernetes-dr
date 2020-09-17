/**
 * Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

variable "project" {
  description = "GCP Project where colocate the bucket"
  type        = string
}

variable "name" {
  type        = string
  description = "Cluster Name"
}
variable "env" {
  type        = string
  description = "Environment Name"
}
variable "backup_bucket_name" {
  type        = string
  description = "Backup Bucket Name"
}
