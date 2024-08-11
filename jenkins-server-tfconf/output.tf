output "jenkins_public_ip" {
  description = "Public IP of jenkins server"
  value = module.jenkins_instance.public_ip  
}