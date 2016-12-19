resource "aws_key_pair" "key" {
  key_name = "test"
  public_key = "${var.instance_key}"
}
