# Cloud Resume Challenge: Second Take (You're looking at it)

My second go at the Cloud Resume Challenge.

**Live Site:** [jlcrc.cloud](https://jlcrc.cloud)  

## Tech Stack

- **Cloud Provider**: AWS (S3, CloudFront, Lambda, DynamoDB, Route 53, ACM, IAM)
- **Infrastructure as Code**: Terraform (modular configuration)
- **CI/CD**: GitHub Actions with OIDC role authentication
- **Backend**: Python (AWS Lambda function)
- **Frontend**: HTML, CSS, JavaScript (static site)
- **Security**: DNSSEC, HTTPS, IAM Roles, KMS, OAC

## Frontend & Hosting

- Built & deployed a multi-page static website (HTML, CSS, JS) hosted on **Amazon S3**
- Served content via a **CloudFront** distribution using **Origin Access Control (OAC)** with public access blocks
- Implemented a session-based **visitor counter** on the index page (via `sessionStorage` to limit one increment per session)

## Infrastructure as Code (Terraform)

- Designed **modular Terraform configurations** with separate modules for ACM, API Gateway, CloudFront, DynamoDB, IAM, Lambda, Route53, and S3
- Managed variables using `variables.tf`, `terraform.tfvars`, and `locals.tf` for clarity and reusability
- Created a secure **Terraform backend** (S3) with **state locking** via DynamoDB
- Manually bootstrapped core resources (S3, DynamoDB, OIDC roles), then imported and fully managed them via Terraform
- Followed best practices: least-privilege IAM roles, tagging, modular and DRY architecture

## Serverless Backend

- Used a **Python-based Lambda function** to increment visit count stored in **DynamoDB**
- Integrated Lambda with **API Gateway (HTTP API)** triggered via frontend JavaScript fetch calls
- Used **DynamoDB** (NoSQL) for persistent visitor tracking

## CI/CD with GitHub Actions & OIDC

- Built CI/CD pipelines using **GitHub Actions** with **OIDC** to securely assume IAM roles for deployments
- Created separate workflows for:
  - Frontend deployment (S3 + CloudFront invalidation)
  - Backend deployment (Terraform automation)
  - Lambda ZIP packaging and upload (S3)
- Practiced **least-privilege access** in CI/CD role policies

## Security & DNS

- Issued **SSL/TLS certificates** with **AWS Certificate Manager (ACM)** for secure HTTPS traffic
- Managed DNS via **Route 53 hosted zone** using custom domain `jlcrc.cloud` (via NameCheap)
- Enabled **DNSSEC** with Route 53:
  - Created a **KMS key** for DNS signing
  - Attached a **Key-Signing Key (KSK)** to the hosted zone
  - Published **DS record** to parent domain via NameCheap

## Access Management & AWS Account Structure

- Used **IAM Identity Center (SSO)** for secure CLI access
- Organized project within **AWS Organizations**, creating a dedicated **Organizational Unit (OU)** and account
- Scoped IAM roles and policies for project-specific operations

## Planned Enhancements

### Monitoring & Alerting
- Integrate **Amazon CloudWatch** with alarms and SNS topics for Lambda/API Gateway metrics and anomaly detection

### Incident Response Automation
- Connect CloudWatch alarms to **Slack** and **PagerDuty** for real-time alerting and issue response

### Security & Policy Validation
- Use **IAM Access Analyzer** and **IAM Policy Validator** to detect and reduce overly permissive IAM roles  
- (Current OIDC role policies still need further scoping)

### CI/CD Security Gates
- Integrate IAM policy validation into **GitHub Actions workflows** to block insecure policies at deployment time

## References & Credits
- **Cloud Resume Challenge** originally created by [Forrest Brazeal](https://forrestbrazeal.com/).
- This project follows the guidelines and structure outlined in Forrest's [Cloud Resume Challenge Guidebook](https://cloudresumechallenge.dev/docs/the-challenge/aws/), which is an excellent resource for anyone looking to get a hands-on start in cloud engineering.
- Big thanks to Forrest and the broader cloud community for making this path accessible, practical, and rewarding.