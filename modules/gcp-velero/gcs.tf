/**
 * Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

# Create a unique GCS bucket per cluster
resource "google_storage_bucket" "main" {
  name               = var.backup_bucket_name
  bucket_policy_only = true
  project            = var.project
  location           = "EU"
  force_destroy      = true
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_storage_bucket_iam_binding" "velero_bucket_iam" {
  bucket = google_storage_bucket.main.name
  role   = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${google_service_account.velero.email}"
  ]

  lifecycle {
    prevent_destroy = false
  }
}
