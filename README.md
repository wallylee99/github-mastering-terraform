# Mastering Terraform as a Site Reliability Engineer

This repository serves as the code companion for my blog (https://www.wallacel.com/vj02)

📖 [Mastering Terraform as a Site Reliability Engineer: A Complete Guide for Multi-Cloud and Multi-Environment Automation](https://www.wallacel.com/index.php/2025/08/15/mastering-terraform-as-a-site-reliability-engineer-a-complete-guide-for-multi-cloud-and-multi-environment-automation/)

It contains practical, hands-on examples demonstrating advanced Terraform usage patterns for SREs working in complex cloud environments.

---

## 📁 Repository Structure

```bash
.
├── 1. multi-regions example           # Deploy to multiple AWS regions
├── 2. modules example                 # Reusable modules for EC2 provisioning
├── 3. remote backend example          # Configure AWS S3 + DynamoDB for remote backend state management
├── 4. provisioner example             # Use provisioners and integrate with GitHub Actions
├── 5. workspace example               # Manage dev/stage/prod environments using workspaces
└── 6. vault example                   # Integrate Terraform with HashiCorp Vault to store and retrieve secrets
```

---

## 🔍 Highlights

- 🌍 **Multi-region deployment** using dynamic provider aliases  
- 📦 **Module-based design** to promote reusability and scalability  
- 🔐 **Remote state backend** with locking using S3 and DynamoDB  
- 🚀 **Provisioners and GitHub Actions** to automate testing and app deployment  
- 🏗️ **Workspaces and environment segregation** with `.tfvars`  
- 🔑 **Secrets management** using Vault

---

## 🛠️ Getting Started

To try out an example:

```bash
cd "1. multi-regions example"  # or any other example
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

> Note: Adjust provider credentials and region values in `terraform.tfvars` or via environment variables as needed.

---

## ✅ Requirements

- Terraform v1.4+
- AWS CLI configured (or credentials via environment variables)
- Optional: GitHub CLI and Vault for some examples

---

## 🤝 Contributions

Feel free to fork and extend the examples to suit your infrastructure needs. Suggestions and pull requests are welcome!

---

## 👨‍💻 Author

Created by [Wallace Lee](https://www.wallacel.com), Site Reliability Engineer passionate about automation, observability, and cloud-native DevOps.


