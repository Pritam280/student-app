resource "aws_instance" "jenkins" {
    ami = data.aws_ssm_parameter.amazon_linux_2.value
    instance_type = "t2.medium"
    key_name = var.my_key
    vpc_security_group_ids = [aws_security_group.result_sg.id]
    subnet_id = "subnet-01e3185a5d834e17c"
    user_data_base64 = base64encode(file("script.sh"))

    tags = {
        name = "jenkins-server"
    }
  
}

resource "aws_instance" "app" {
    ami = data.aws_ssm_parameter.amazon_linux_2.value
    instance_type = "t2.micro"
    key_name = var.my_key
    vpc_security_group_ids = [aws_security_group.result_sg.id]
    subnet_id = "subnet-01e3185a5d834e17c"
    user_data_base64 = base64encode(file("app-server.sh"))

    tags = {
        name = "app_server"
    }
  
}