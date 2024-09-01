# Infrastructure as Code setup

Deploy the date API to Google Cloud Platform (GCP) using Kubernetes (GKE) with Infrastructure as Code (IaC) exclusively through Terraform.

## Objectives
2. Infrastructure Setup and Deployment (Terraform): 
   - [ ] Use Terraform to create the entire infrastructure on Google Cloud Platform (GCP).
   
   The infrastructure should include: 
      - [ ] A Google Kubernetes Engine (GKE) cluster where the API will be deployed. 
      - [ ] A NAT gateway to manage egress traffic from the cluster. 
      - [ ] Appropriate IAM roles and policies. 
      - [ ] VPC networking, subnets, and firewall rules for secure communication. 
      - [ ] Kubernetes resources such as Namespaces, Deployments, Services, ConfigMaps, and Ingress. 
      - [ ] Deploy the API to the GKE cluster exclusively using Terraform. This means you should define the Kubernetes resources (Deployments, Services, Ingress, etc.) within your Terraform code. 
      - [ ] Implement Terraform Policy as Code (PaC) to enforce at least one security policy (e.g., ensuring that certain ports are closed or specific IAM roles are not granted). 
4. Network Security: 
   - [ ] Set up a NAT gateway in GCP to manage the outbound traffic for your GKE cluster. 
   - [ ] Implement any additional firewall rules to secure your infrastructure.   
   - [ ] Ensure that your Terraform configuration includes security best practices, such as restricting access to sensitive resources. 
5. Extras:
   - [ ] Implement monitoring and alerting for the deployed API using Google Cloud's monitoring tools. 
   - [ ] Use advanced Terraform features to organize your code.

## How to run
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
    ```
    cd <terrafom-directory>
    terraform apply -auto-approve
    ```