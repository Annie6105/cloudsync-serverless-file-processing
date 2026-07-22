<div align="center">

# ☁️ CloudSync – Serverless File Processing System

### End-to-End AWS Serverless File Processing Pipeline using Terraform, AWS Lambda, Amazon S3 & GitHub Actions

![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazonaws)
![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-2088FF?style=for-the-badge&logo=githubactions)
![Lambda](https://img.shields.io/badge/AWS-Lambda-FF9900?style=for-the-badge&logo=awslambda)
![Amazon S3](https://img.shields.io/badge/Amazon-S3-569A31?style=for-the-badge&logo=amazons3)
![Node.js](https://img.shields.io/badge/Node.js-18.x-339933?style=for-the-badge&logo=node.js)

</div>

---

# 📖 Project Overview

CloudSync is an **AWS serverless file processing system** that automatically processes uploaded files using **Amazon S3**, **AWS Lambda**, and **Terraform**.

Whenever a supported file is uploaded to the S3 Upload Bucket, an S3 event automatically triggers an AWS Lambda function. The Lambda validates the file type, retrieves metadata, copies the file to a processed bucket with a timestamped filename, and removes the original upload.

The complete infrastructure is provisioned using **Terraform** and deployed automatically using **GitHub Actions CI/CD**.

---

# 🚀 Features

- ✅ Infrastructure as Code using Terraform
- ✅ Automatic file processing using AWS Lambda
- ✅ Event-driven architecture with Amazon S3
- ✅ Supports multiple file types
- ✅ Timestamp-based file renaming
- ✅ Automatic deletion of original uploaded files
- ✅ CloudWatch logging
- ✅ IAM least-privilege permissions
- ✅ GitHub Actions CI/CD pipeline
- ✅ Modular Terraform project structure

---

# 🏗️ Architecture

> **Architecture Diagram**

Replace this section with the architecture diagram image (we'll create it next).

```text
GitHub
    │
GitHub Actions
    │
Terraform Apply
    │
──────────────────────────────────────────────

Amazon S3 (Upload Bucket)
          │
          │ S3 Event Notification
          ▼
AWS Lambda Processor
          │
          ├────────► CloudWatch Logs
          │
          ▼
Amazon S3 (Processed Bucket)
```

---

# ⚙️ Technology Stack

| Category | Technologies |
|----------|--------------|
| Cloud | AWS |
| Infrastructure | Terraform |
| Compute | AWS Lambda |
| Storage | Amazon S3 |
| Monitoring | CloudWatch |
| CI/CD | GitHub Actions |
| Language | Node.js |
| Version Control | Git & GitHub |

---

# 📂 Project Structure

```text
cloudsync-serverless-file-processing
│
├── .github/
│   └── workflows/
│       ├── terraform-plan.yml
│       └── terraform-apply.yml
│
├── bootstrap/
│
├── environments/
│   └── dev/
│
├── lambda/
│   └── processor/
│       ├── index.js
│       ├── package.json
│       └── package-lock.json
│
├── modules/
│   ├── compute/
│   └── storage/
│
└── README.md
```

---

# 🔄 Workflow

1. User uploads a supported file to the Upload Bucket.
2. Amazon S3 generates an event notification.
3. AWS Lambda is automatically invoked.
4. Lambda validates the uploaded file.
5. File metadata is retrieved.
6. File is renamed using a timestamp.
7. File is copied to the Processed Bucket.
8. Original uploaded file is deleted.
9. Execution logs are stored in CloudWatch.

---

# 🚀 CI/CD Pipeline

The project includes an automated GitHub Actions pipeline.

### Terraform Plan

Runs automatically whenever a Pull Request is created.

- Terraform Format Check
- Terraform Init
- Terraform Validate
- Terraform Plan

---

### Terraform Apply

Runs automatically after merging into the `main` branch.

- Checkout Repository
- Configure AWS Credentials
- Terraform Init
- Terraform Apply

---

# 📦 Infrastructure Components

This project provisions:

- Amazon S3 Upload Bucket
- Amazon S3 Processed Bucket
- AWS Lambda Function
- IAM Roles & Policies
- CloudWatch Logs
- S3 Event Notification
- Terraform Backend
- GitHub Actions CI/CD

---

# 🔐 Security

- IAM Least Privilege
- AWS Credentials stored as GitHub Secrets
- Terraform State stored remotely
- Sensitive values managed through Terraform Variables

---

# 📸 Screenshots

Add screenshots here:

- GitHub Actions Success
- Terraform Apply
- AWS Lambda Console
- Amazon S3 Buckets
- CloudWatch Logs

---

# 📈 Future Improvements

- Email notifications using Amazon SNS
- Amazon SQS integration
- Virus scanning
- File encryption
- Metadata database using DynamoDB
- Multi-environment deployment
- Kubernetes (Amazon EKS) version

---

# 🎯 Learning Outcomes

Through this project I gained practical experience with:

- AWS Lambda
- Amazon S3
- Terraform
- GitHub Actions
- Infrastructure as Code
- Event-driven Architecture
- IAM
- CloudWatch
- CI/CD Automation

---

# 👨‍💻 Author

**Annie Rubha V**

Electronics and Communication Engineering Undergraduate | Cloud & DevOps Enthusiast

GitHub: https://github.com/Annie6105

---

# ⭐ If you found this project useful, consider giving it a star!
