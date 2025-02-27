# Terraform Backend Configuration

This repository contains the Terraform configuration for setting up an **S3 backend with DynamoDB state locking**.

## 📌 Backend Configuration Details

Terraform is configured to store its state file remotely in an **AWS S3 bucket** with state locking enabled using **DynamoDB**.

```hcl
terraform {
  backend "s3" {
    bucket         = "akshaybucketfordemo"
    region         = "us-east-1"
    key            = "akshay/terraform.tfstate"
    dynamodb_table = "akshaydb"
  }
}
```

### 🎯 **Components**
- **S3 Bucket:** `akshaybucketfordemo` → Stores the Terraform state file securely.
- **DynamoDB Table:** `akshaydb` → Enables state locking to prevent concurrent modifications.
- **Region:** `us-east-1` → AWS region where the resources are deployed.
- **State File Path:** `akshay/terraform.tfstate` → Path within the S3 bucket where the state file is stored.

---
## 🚀 Setup Instructions

### **1️⃣ Prerequisites**
Ensure you have the following installed and configured:
- [Terraform](https://developer.hashicorp.com/terraform/downloads) (>= v1.0.0)
- [AWS CLI](https://aws.amazon.com/cli/) (authenticated with valid credentials)

### **2️⃣ Create Required AWS Resources**
Before initializing Terraform, you need to create the **S3 bucket** and **DynamoDB table**.

1️⃣ Create S3 Bucket for Terraform State
Log in to AWS Console: Go to AWS Management Console.
Search for "S3" in the AWS search bar and select "S3".
Click "Create Bucket" (top-right corner).
Configure Bucket Details:
```
Bucket Name: akshaybucketfordemo
AWS Region: Select us-east-1.
Block Public Access: Keep all options checked (Recommended for security).
Versioning: Enable (Recommended for state tracking & recovery).
```
Click "Create Bucket".
✅ S3 bucket is now created and ready for Terraform state storage!

2️⃣ Create DynamoDB Table for State Locking
Search for "DynamoDB" in AWS Console and open DynamoDB.
Click "Create Table" (top-right corner).
Configure Table Settings:
```
Table Name: akshaydb
Partition Key:
Name: LockID
Type: String
Sort Key: Leave unchecked.
Set Capacity Mode:
Select "On-demand (Recommended)".
```
Click "Create Table".
✅ DynamoDB table is now created and will be used for state locking!

---
## 🛠 Initialize Terraform
Once the backend resources are ready, run the following:
```sh
terraform init
```
This will initialize the Terraform project and configure the backend.

If you see an error about backend configuration changes, run:
```sh
terraform init -reconfigure
```

---
## 🔍 Verify State Locking
To test state locking, run:
```sh
terraform plan
```
If Terraform acquires a lock successfully, the DynamoDB table should have an entry with the **LockID** value.

To manually check the lock:
```sh
aws dynamodb scan --table-name akshaydb
```

---
## ✅ Best Practices
- **Never share the `terraform.tfstate` file** as it may contain sensitive data.
- Use IAM policies to restrict access to the S3 bucket and DynamoDB table.
- Enable versioning on the S3 bucket for state recovery.

---
## 📜 References
- [Terraform Remote Backend (S3)](https://developer.hashicorp.com/terraform/language/settings/backends/s3)
- [State Locking with DynamoDB](https://developer.hashicorp.com/terraform/language/settings/backends/s3#dynamodb-table-used-for-state-locking)

---
### 🎯 Author
[Akshay](https://github.com/akshay) 🚀

