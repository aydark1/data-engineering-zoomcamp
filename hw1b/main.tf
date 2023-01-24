terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "ajev7ghrasffi3vb00vn"
  description        = "static access key for object storage"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "de-zoomcamp-bucket"
}

resource "yandex_mdb_clickhouse_cluster" "de-zoomcamp-clickhouse" {
  name        = "test"
  environment = "PRESTABLE"
  network_id  = "enpokofhif1v02364s6u"

  clickhouse {
    resources {
      resource_preset_id = "b1.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }

   }

  database {
    name = "de_zoomcamp_db"
  }

  user {
    name     = "user1"
    password = "user1user2"
    permission {
      database_name = "de_zoomcamp_db"
    }
 
  }

  host {
    type      = "CLICKHOUSE"
    zone      = "ru-central1-a"
    subnet_id = "e9bd6cl78rcrudv5lt2u"
    assign_public_ip = false
  }



  service_account_id = "ajev7ghrasffi3vb00vn"

}


