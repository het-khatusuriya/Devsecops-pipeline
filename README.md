# 🚀 DevSecOps CI/CD Pipeline

## 📚 Table of Contents
1. [Overview](#overview)
2. [Project Goals](#project-goals)
3. [Tools and Technologies](#tools-and-technologies)
4. [CI/CD Pipeline Workflow](#cicd-pipeline-workflow)
5. [Why This Pipeline?](#why-this-pipeline)
6. [Setup Guide](#setup-guide)
7. [Future Enhancements](#future-enhancements)
8. [Conclusion](#conclusion)

---

## 🌟 Overview

Why did the DevOps pipeline break up with traditional security? — It felt too "insecure" in the fast-paced relationship! 😅

This project showcases an end-to-end CI/CD pipeline infused with DevSecOps best practices, ensuring that security isn't just an afterthought — it's baked right into the pipeline. It integrates a powerful stack: Git, Jenkins, Maven, JUnit, SonarQube, Docker, Trivy, AWS S3, Docker Hub, Kubernetes, Slack, and HashiCorp Vault.

---
# 🔒 DevSecOps CI/CD Pipeline — Secure, Scalable, and Automated 🚀

### **Description**

This project showcases a fully automated CI/CD pipeline with integrated security checks, quality analysis, and Kubernetes deployment.  
Built with Jenkins, Docker, SonarQube, Trivy, and Slack — this pipeline ensures secure, high-performance, and reliable application delivery.

From code commit to production deployment, security is baked into every stage — ensuring early failure detection, vulnerability scans, and cloud storage of reports (AWS S3).  

✅ **Goal:** Shift security left, ensure high-quality code, and automate deployment with real-time feedback.  

### 🔥 Overall Project Workflow
![Project Workflow](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/updatedprojectworkflow.drawio.png)

---

## 🎯 Project Goals

- **Automate the CI/CD Pipeline** — From code commit to deployment.
- **Embed Security** — Ensure code quality and vulnerability scanning at every stage.
- **Fast Feedback Loop** — Real-time failure notifications.
- **Cloud Storage Integration** — Store scan reports securely in AWS S3.
- **Kubernetes Deployment** — Ensure scalable, reliable application deployment.

---

## 🔧 Tools and Technologies

| Tool              | Purpose                                                        |
|-------------------|----------------------------------------------------------------|
| **Git/GitHub**    | Version control & code repository management.                  |
| **Jenkins**       | CI/CD automation server to orchestrate the pipeline.           |
| **Maven**         | Build automation tool to compile and package the code.         |
| **JUnit**         | Unit testing to ensure the code behaves as expected.           |
| **SonarQube**     | Static code analysis to detect bugs, code smells, vulnerabilities.|
| **Docker**        | Containerize the application to ensure consistency across environments. |
| **Trivy**         | Vulnerability scanner for Docker images.                       |
| **AWS S3**        | Cloud storage to store vulnerability scan reports.             |
| **Docker Hub**    | Docker image registry for hosting built images.                |
| **Kubernetes**    | Container orchestration for deploying, scaling, managing the app.|
| **Slack**         | Real-time notifications for build status (success/failure).    |
| **HashiCorp Vault**| Secure management of secrets and sensitive data.               |

---

## 📌 CI/CD Pipeline Workflow

1. **Fetch Source Code 📥**
   - Jenkins pulls the latest code from GitHub.

2. **Build 🔨**
   - Maven compiles the source code.
   - If it fails, Jenkins stops the pipeline and sends a Slack notification.

3. **Unit Testing 🧪**
   - JUnit runs unit tests.
   - If tests fail, the pipeline stops and notifies the user.

4. **Code Analysis 🔍**
   - SonarQube scans for code smells, bugs, and security vulnerabilities.
   - If the quality gate fails, Jenkins stops the pipeline and sends a notification.

5. **Build Docker Image 🐳**
   - Docker builds the image from the source code.
   - If the image build fails, Jenkins halts the pipeline.

6. **Image Scanning 🔥**
   - Trivy scans the Docker image for vulnerabilities.
   - If any high/critical vulnerabilities are found, the pipeline stops, and Jenkins stores the scan report in AWS S3.

7. **Push to Docker Hub 📤**
   - The clean, scanned Docker image is pushed to Docker Hub.
   - Failure stops the pipeline with a notification.

8. **Deploy to Kubernetes 📌**
   - Jenkins deploys the image to a Minikube Kubernetes cluster.
   - If deployment fails, Jenkins notifies the user.

9. **Slack Notifications 🔔**
   - Real-time Slack notifications are sent for success/failure at each critical stage.

10. **Secrets Management 🔒**
   - HashiCorp Vault manages sensitive data like Docker Hub credentials or API keys securely.

---

## 🚀 Why This Pipeline?

This pipeline isn’t just about CI/CD — it’s built to ensure security, scalability, and reliability from the start. Here’s why it stands out:

- **Security-first approach:** Embeds security checks early in the development lifecycle (shift-left security).
- **Early failure detection:** Stops on the first error, reducing wasted resources and debugging headaches.
- **Real-time notifications:** Slack alerts keep you updated instantly at every critical pipeline stage.
- **Automated image scanning:** Prevents deploying vulnerable Docker images with Trivy scans.
- **Kubernetes deployment:** Ensures the app scales reliably with Minikube.

This setup combines performance with security, ensuring your app goes live faster without compromising quality. 🔥
---

## 🔧 Setup Guide

1. **Clone the repo**
   ```bash
   git clone https://github.com/yourusername/DevSecOps-Project.git
   ```

2. **Configure Jenkins**
   - Install plugins: Maven, Docker, SonarQube, Trivy, Kubernetes CLI, Slack.
   - Set up Jenkins jobs for build, test, scan, and deploy.

3. **Set up SonarQube**
   - Define a quality gate with rules for bugs, vulnerabilities, and code smells.

4. **Docker & Trivy**
   - Install Docker and configure Trivy.
   - Build and scan images.

5. **Minikube Setup**
   ```bash
   minikube start
   kubectl apply -f deployment.yaml
   ```

6. **Slack Webhook**
   - Create an incoming webhook for Slack notifications.

---

## 🌟 Future Enhancements

- **Implement Terraform** for infrastructure as code.
- **Add Prometheus & Grafana** for monitoring.
- **Automate rollback** on failure.
- **Use Istio** for service mesh and better traffic management.

---

## 📸 Pipeline Output Showcase

Below are the key outputs and visual evidence of the pipeline's success:

### 🔥 AWS S3 Bucket Report Storage  
![AWS S3 Bucket Storage](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/aws%20s3%20bucket.png))

---

### 🛠️ Kubernetes Deployment - Command Line Output  
![Kubernetes CMD Output](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/cmd%20output%20for%20kubernetes.png))

---

### 🚀 Kubernetes Deployment with CMD  
![Kubernetes output with CMD](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/Kubernetes%20output%20with%20cmd.png)

---

### 🐳 Docker Image Pushed to Docker Hub  
![Docker Hub Push](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/image%20on%20docker.png)

---

### 🔧 Jenkins Pipeline Integration  
![Jenkins Pipeline Setup](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/Integration%20with%20jenkins.png)

---

### 📋 Jenkins Dashboard View  
![Jenkins Dashboard](https://your-image-url.com/jenkins-dashboard.png "Jenkins Dashboard View")

---

### 🛠️ Kubernetes Output with CMD  
![Kubernetes CMD Output](https://your-image-url.com/kubernetes-output-with-cmd.png "Kubernetes CMD Output Confirmation")

---

### 🔄 Pipeline Changes  
![Pipeline File Changes](https://your-image-url.com/pipeline-changes.png "Pipeline File Updates")

---

### ✅ Jenkins Pipeline Status  
![Pipeline Status](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/pipeline%20status.png)

---

### 🔔 Slack Notifications  
![Slack Notification](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/slack%20output.png)

---

### 🕵️ SonarQube Report - Code Quality Status  
![SonarQube Report](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/sonarqube%20report%20status.png)

---

### 🔍 Trivy Vulnerability Scan - Report Uploaded to S3  
![Trivy Scan Report](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/Trivy%20scan%20report%20uploaded%20on%20s3.png)

---

### 🎉 Final Success: CI/CD Pipeline Completed  
![Final Pipeline Success](https://github.com/het-khatusuriya/Devsecops-pipeline/blob/main/outputs/pipeline%20sucess.png)


---

## 💬 Conclusion

"Why did the pipeline cross the road?"

To deploy the code to the other cluster... securely! 😄

Happy DevSecOps-ing! 🔥☁️
