terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terraform-object-storage-netology"
    region     = "ru-central1"
    key        = "terraform_state/terraform_state>.tfstate"
    access_key = "YCAJEWFfMDelBBfhinRaN7p3R"
    secret_key = "YCO-Cetbc1zdcf8XUbyeQVXZ7OWLwG0qjVj-X2sn"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}