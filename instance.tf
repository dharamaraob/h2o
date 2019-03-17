resource "aws_key_pair" "mykey" {
  key_name = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_instance" "jump" {
  ami = "${lookup(var.AMIS, var.vpc-region)}"
  instance_type = "${var.ins_type}"
  subnet_id = "${aws_subnet.Admin-Public.id}"
  key_name = "${aws_key_pair.mykey.key_name}"
  security_groups = ["${aws_security_group.Admin-Public-sg.id}"]

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  connection {
    type = "ssh"
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}

output "private_dns.jump " {
    value = "${aws_instance.jump.private_dns}"
}

//resource "aws_eip" "jump" {
//    instance = "${aws_instance.jump.id}"
//    vpc = true
//}

output "public_ip.jump" {
    value = "${aws_instance.jump.public_ip}"
}