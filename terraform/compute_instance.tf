locals {
  core_count = {
    stage = 2
    prod = 4
  }
  instance_count = {
    stage = 1
    prod = 2
  }
  names = {
    name1 = "vm_1"
    name2 = "vm_2"
  }
}

resource "yandex_compute_instance" "vm-netology" {
  name = "netology"
  count = local.instance_count[terraform.workspace]

  resources {
    cores  = local.core_count[terraform.workspace]
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ch5n0oe99ktf1tu8r"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "yandex_compute_instance" "vm-foreach" {
  for_each = local.names

  name = each.key

  resources {
    cores  = local.core_count[terraform.workspace]
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ch5n0oe99ktf1tu8r"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}