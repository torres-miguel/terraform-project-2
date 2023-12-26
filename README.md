# TERRAFORM - AWS NGINX/UBUNTU INSTANCES WITH ALB 

## Content
This simple project illustrates the creation in AWS of two Ubuntu instances, each of them running nginx with a test message. These are accessed via an ALB (Application Load Balancer), which works in a round robin fashion.

Therefore, it defines:
* Provider: AWS and its region (eu-central-1)
* Networking: Default VPC with default subnet
* Security groups: One from the Internet to the ALB and another from the ALB to the Instances
* ALB: Its configuration
* Instances: Two Ubuntu instances, each with commands to install nginx and set a test message# terraform-project-2
