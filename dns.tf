provider "dnsimple" {
  token = "iyomama"
  account = "hahafuckyou"
}

resource "dnsimple_record" "foobar" {
  domain = "dnsimple_domain"
  name   = "terraform"
  value  = "${aws_instance.web.0.public_ip}"
  type   = "A"
}
