# resource "aws_route53_zone" "main" {
#   name = "timeliest.xyz"
# }

resource "aws_route53_record" "www" {
  zone_id = "Z09701852R6BMHK2XHRQ"
  name    = "terrafun.timeliest.xyz"
  type    = "A"
  alias {
    name                   = aws_lb.ecs_lb.dns_name
    zone_id                = aws_lb.ecs_lb.zone_id
    evaluate_target_health = true
  }
}