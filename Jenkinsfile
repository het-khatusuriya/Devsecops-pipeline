

pipeline {
    agent any
     environment {
        KUBECONFIG = credentials('Kubernetesjenkins')
        }
    tools {
        maven 'Maven'
    }
    stages {
        stage('Checkout Git') {
            steps {
                git branch: 'main', url: 'https://github.com/het-khatusuriya/Devsecops-pipeline'
            }
        }
        stage('Build & JUnit Test') {
            steps {
                sh 'mvn install'
            }
            post {
               success {
                    junit 'target/surefire-reports/**/*.xml'
                }  
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube-server') {
                    withCredentials([string(credentialsId: 'devsecops', variable: 'SONAR_LOGIN')]) {
                        sh '''
                            mvn clean verify sonar:sonar \
                            -Dsonar.projectKey=Devsecops-project \
                            -Dsonar.host.url=http://localhost:9000/ \
                            -Dsonar.login=$SONAR_LOGIN
                        '''
                    }
                }
            }
        }
        stage('Docker Build') {
            steps {
                sh "docker build -t hk2010/sprint-boot-app:v1.${BUILD_ID} ."
                sh "docker image tag hk2010/sprint-boot-app:v1.${BUILD_ID} hk2010/sprint-boot-app:latest"
            }
        }
        stage('Image Scan') {
            steps {
                bat '"C:\\Program Files\\trivy_0.58.0_windows-64bit\\trivy.exe" image --format template --template "@C:\\Program Files\\trivy_0.58.0_windows-64bit\\contrib\\html.tpl" -o "E:\\SPM\\github-pipeline\\Devsecops-pipeline\\Trivy reports\\report.html" hk2010/sprint-boot-app:latest'
            }
        }
        stage('Upload Scan report to AWS S3') {
            steps {
                withCredentials([aws(credentialsId: 'AmazonWebServicesCredentials', accessKeyVariable: 'AWS_ACCESS_KEY', secretKeyVariable: 'AWS_SECRET_KEY')]) {
                    bat '''
                        aws configure set aws_access_key_id %AWS_ACCESS_KEY%
                        aws configure set aws_secret_access_key %AWS_SECRET_KEY%
                        aws s3 cp "E:\\SPM\\github-pipeline\\Devsecops-pipeline\\Trivy reports\\report.html" s3://devsecopsreport/
                    '''
                }
            }
        }         
        stage('Docker Push') {
                steps {
                    withCredentials([usernamePassword(credentialsId: 'dockercreds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                        sh "docker push hk2010/sprint-boot-app:v1.${BUILD_ID}"
                        sh "docker push hk2010/sprint-boot-app:latest"
                        sh "docker rmi hk2010/sprint-boot-app:v1.${BUILD_ID} hk2010/sprint-boot-app:latest"
                    }
                } 
            }
            
        stage('Deploy to k8s') {
            steps {
                script{
                    sh 'kubectl apply -f E:/SPM/github-pipeline/Devsecops-pipeline/spring-boot-deployment.yaml'
                }
            }
        }  
           
    }

    post {
        always {
            script {
                def buildSummary = """Job_name: ${env.JOB_NAME}
                Build_id: ${env.BUILD_ID}
                Status: *${currentBuild.currentResult}*
                Build_url: ${env.BUILD_URL}
                Job_url: ${env.JOB_URL}"""

                def color = (currentBuild.currentResult == "SUCCESS") ? "good" : "danger"

                try {
                    slackSend(
                        channel: "#devsecops-jenkins",
                        tokenCredentialId: 'Slack_jenkins',
                        color: color,
                        message: buildSummary
                    )
                } catch (Exception e) {
                    echo "Slack notification failed: ${e.message}"
                }
            }
        }
    }
}