# Infrastructure as Code setup

Deploy the date API to Google Cloud Platform (GCP) using Kubernetes (GKE) with Infrastructure as Code (IaC) exclusively through Terraform.

## Objectives
2. Infrastructure Setup and Deployment (Terraform): 
   - [x] Use Terraform to create the entire infrastructure on Google Cloud Platform (GCP).
   
   The infrastructure should include: 
      - [x] A Google Kubernetes Engine (GKE) cluster where the API will be deployed. 
      - [x] A NAT gateway to manage egress traffic from the cluster. 
      - [x] Appropriate IAM roles and policies. 
      - [x] VPC networking, subnets, and firewall rules for secure communication. 
      - [x] Kubernetes resources such as Namespaces, Deployments, Services, ConfigMaps, and Ingress. 
      - [x] Deploy the API to the GKE cluster exclusively using Terraform. This means you should define the Kubernetes resources (Deployments, Services, Ingress, etc.) within your Terraform code. 
      - [ ] Implement Terraform Policy as Code (PaC) to enforce at least one security policy (e.g., ensuring that certain ports are closed or specific IAM roles are not granted). 
4. Network Security: 
   - [x] Set up a NAT gateway in GCP to manage the outbound traffic for your GKE cluster. 
   - [x] Implement any additional firewall rules to secure your infrastructure.   
   - [x] Ensure that your Terraform configuration includes security best practices, such as restricting access to sensitive resources. 
5. Extras:
   - [x] Implement monitoring and alerting for the deployed API using Google Cloud's monitoring tools. 
   - [x] Use advanced Terraform features to organize your code.

## How to run

Requirements
- Terraform
- Gcloud
- Make use of the [service_account script](../scripts/setup-gcp-sa.sh) to setup a service account for running your terraform workload (recommended) or run the command below to setup a auth credentials for gcp
  ```bash
  gcloud auth application-default login
  ```

1. Initialize terraform to download all the dependencies required
    ```
    cd <terrafom-directory>
    terraform init
    ```
2. Format and validate the configuration
    ```
    cd <terrafom-directory>
    terraform fmt && terraform validate
    ```
3. Run a plan to view the proposed changes to infrastructure
    ```
    cd <terrafom-directory>
    terraform plan
    ```
4. Apply the changes
   - setup your terraform.tfvars file
    ```
    project_id       = "xxxxx"
    cluster_name     = "xxxxxx"
    slack_auth_token = "xxxxxx"
    domain           = "xxxx.xxx"
    email            = "xxxxxx"
    dns_zone_name    = "xxxxxx"
    ```

    apply configurations
    ```
    cd <terrafom-directory>
    terraform apply -auto-approve
    ```
4. Visit the domain name provided