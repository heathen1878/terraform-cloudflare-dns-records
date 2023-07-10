resource "cloudflare_record" "dns_record" {
  for_each = var.dns_record

  zone_id = each.value.zone_id
  name    = each.value.name
  proxied = each.value.proxied
  value   = each.value.value
  type    = each.value.type
  ttl     = each.value.ttl

  provisioner "local-exec" {
    command = "sleep 180"
  }

  lifecycle {
    ignore_changes = [
      proxied # this is in place as this value needs changing
    ]
  }
}

locals {

  dns_record_output = {
    for key, value in cloudflare_record.dns_record : key => {
      id = value.id
    }
  }

}