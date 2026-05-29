# GLOBAL PORTFOLIO DEPLOYMENT USING S3 AND CLOUDFRONT

## Project Overview

This project demonstrates the deployment of a static portfolio website globally using Amazon S3 and Amazon CloudFront. The website files are stored in an S3 bucket configured for static website hosting, while CloudFront acts as a Content Delivery Network (CDN) to provide fast, secure, and low-latency access to users worldwide.

The project helps in understanding cloud storage, CDN integration, website hosting, and global content delivery using AWS services.

---

# Architecture

User → CloudFront Distribution → S3 Static Website Bucket

---

# AWS Services Used

* Amazon S3
* Amazon CloudFront
* AWS IAM
* ACM SSL Certificate (Optional)

---

# Features
* Static website hosting using S3
* Global content delivery using CloudFront
* Faster website loading with CDN caching
* Secure and scalable architecture
* HTTPS support using SSL certificates
* Easy deployment and maintenance

---

# Prerequisites

Before starting, ensure you have:

* AWS Account
* AWS CLI configured
* Static website files (HTML, CSS, JS)
* Basic understanding of AWS services

---

# Step 1: Create S3 Bucket

1. Open AWS Management Console
2. Navigate to Amazon S3
3. Create a new bucket
4. Provide a unique bucket name
5. Disable “Block Public Access”
6. Enable Static Website Hosting
7. Upload website files

Example:

* index.html
* style.css
* script.js

---

# Step 2: Configure Bucket Policy

Add public read permissions to the bucket.

Example Bucket Policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME/*"
    }
  ]
}
```

---

# Step 3: Enable Static Website Hosting

1. Open S3 Bucket
2. Go to Properties
3. Enable Static Website Hosting
4. Set:

   * Index document: index.html
   * Error document: index.html

Copy the generated S3 Website Endpoint URL.

---

# Step 4: Create CloudFront Distribution

1. Open CloudFront Console
2. Create Distribution
3. Select S3 website endpoint as Origin
4. Configure:

   * Viewer Protocol Policy → Redirect HTTP to HTTPS
   * Default Root Object → index.html
5. Create Distribution

CloudFront will generate a domain like:

```bash
https://dxxxxxxxxxxxxx.cloudfront.net
```

---

# Step 5: Access Website Globally

Open the CloudFront domain in the browser to access the portfolio website globally with low latency.

---

# Cache Invalidation

Whenever website files are updated in S3, create CloudFront invalidation to clear cached content.

Example:

```bash
aws cloudfront create-invalidation \
--distribution-id YOUR_DISTRIBUTION_ID \
--paths "/*"
```

---

# Project Structure

```bash
portfolio-project/
│
├── index.html
├── style.css
├── script.js
└── assets/
```

---

# Advantages of CloudFront

* Global edge locations
* Reduced latency
* Faster content delivery
* Improved website performance
* Enhanced security
* DDoS protection

---

# Security Best Practices

* Enable HTTPS
* Use Origin Access Control (OAC)
* Restrict direct S3 access
* Enable CloudFront logging
* Use IAM least privilege access

---

# Future Enhancements

* Custom domain integration
* SSL certificate using ACM
* CI/CD deployment using GitHub Actions
* Infrastructure as Code using Terraform
* Monitoring using CloudWatch

---

# Outcome

Successfully deployed a static portfolio website globally using Amazon S3 and CloudFront with scalable, secure, and high-performance architecture.

---

# Author

Saibaba Kola

---
