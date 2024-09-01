# Google Kubernetes Engine (GKE) setup using Terraform

This project demonstrates how to configure GKE with Terraform using best practices. It's contains CICD procedures for executing the terraform infrastructures using github actions.

# TODO:
1. API Development: 
   - [ ] Develop a simple API (in the programming language of your choice) that returns the current time in a JSON format when accessed via a GET request.   
   - [ ] Containerize the API using Docker. 
2. Infrastructure Setup and Deployment (Terraform): 
   - [ ] Use Terraform to create the entire infrastructure on Google Cloud Platform (GCP). 
   - [ ] The infrastructure should include: 
   - [ ] A Google Kubernetes Engine (GKE) cluster where the API will be deployed. 
   - [ ] A NAT gateway to manage egress traffic from the cluster. 
   - [ ] Appropriate IAM roles and policies. 
   - [ ] VPC networking, subnets, and firewall rules for secure communication. 
   - [ ] Kubernetes resources such as Namespaces, Deployments, Services, ConfigMaps, and Ingress. 
   - [ ] Deploy the API to the GKE cluster exclusively using Terraform. This means you should define the Kubernetes resources (Deployments, Services, Ingress, etc.) within your Terraform code. 
   - [ ] Implement Terraform Policy as Code (PaC) to enforce at least one security policy (e.g., ensuring that certain ports are closed or specific IAM roles are not granted). 
3. CI/CD Pipeline: 
   - [ ] Implement a GitHub Actions pipeline that: 
   - [ ] Runs Terraform to provision all required infrastructure, including Kubernetes resources. 
   - [ ] Builds the Docker image for the API. 
   - [ ] Deploys the API to the GKE cluster as part of the Terraform deployment.
   - [ ] Verifies that the API is accessible by running a test that hits the API endpoint and checks the response. 
4. Network Security: 
   - [ ] Set up a NAT gateway in GCP to manage the outbound traffic for your GKE cluster. 
   - [ ] Implement any additional firewall rules to secure your infrastructure.   
   - [ ] Ensure that your Terraform configuration includes security best practices, such as restricting access to sensitive resources. 
5. Extras:
   - [ ] Implement monitoring and alerting for the deployed API using Google Cloud's monitoring tools. 
   - [ ] Use advanced Terraform features to organize your code. 
