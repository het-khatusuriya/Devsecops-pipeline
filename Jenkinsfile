pipeline {
    agent any
    tools { 
        maven 'Maven' 
    }
    stages {
        stage('Checkout git') {
            steps {
               git branch: 'main', url: 'https://github.com/het-khatusuriya/Devsecops-pipeline'
            }
        }
        
        stage ('Build & JUnit Test') {
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
        stage("Quality Gate") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
        }
        
        stage('Docker  Build') {
            steps {
      	        sh 'docker build -t hk2010/sprint-boot-app:v1.$BUILD_ID .'
                sh 'docker image tag hk2010/sprint-boot-app:v1.$BUILD_ID hk2010/sprint-boot-app:latest'
            }
        }
        stage('Image Scan') {
            steps {
      	        sh ' trivy image --format template --template "@/usr/local/share/trivy/templates/html.tpl" -o report.html praveensirvi/sprint-boot-app:latest '
            }
        }
        stage('Upload Scan report to AWS S3') {
              steps {
                  sh 'aws s3 cp report.html s3://devsecops-project/'
              }
         }
        stage('Docker  Push') {
            steps {
                withVault(configuration: [skipSslVerification: true, timeout: 60, vaultCredentialId: 'vault-jenkins', vaultUrl: 'http://127.0.0.1:8200/'], vaultSecrets: [[path: 'secrets/creds/docker', secretValues: [[vaultKey: 'hk2010'], [vaultKey: 'hk2010']]]]) {
                    sh "docker login -u hk2010 -p HK@0210@@ "
                    sh 'docker push hk2010/sprint-boot-app:v1.$BUILD_ID'
                    sh 'docker push hk2010/sprint-boot-app:latest'
                    sh 'docker rmi hk2010/sprint-boot-app:v1.$BUILD_ID hk2010/sprint-boot-app:latest'
                }
            }
        }
        stage('Deploy to k8s') {
            steps {
                script{
                    kubernetesDeploy configs: 'spring-boot-deployment.yaml', kubeconfigId: 'Kubernetes_jenkins'
                }
            }
        }   
    }
    post{
        always{
            sendSlackNotifcation()
            }
        }
}

    def sendSlackNotifcation()
    {
        if ( currentBuild.currentResult == "SUCCESS" ) {
            buildSummary = "Job_name: ${env.JOB_NAME}\n Build_id: ${env.BUILD_ID} \n Status: *SUCCESS*\n Build_url: ${BUILD_URL}\n Job_url: ${JOB_URL} \n"
            slackSend( channel: "#devsecops", token: 'eexFLADIyfWYYnHHtU9IJySP', color: 'good', message: "${buildSummary}")
        }
        else {
            buildSummary = "Job_name: ${env.JOB_NAME}\n Build_id: ${env.BUILD_ID} \n Status: *FAILURE*\n Build_url: ${BUILD_URL}\n Job_url: ${JOB_URL}\n  \n "
            slackSend( channel: "#devsecops", token: 'eexFLADIyfWYYnHHtU9IJySP', color : "danger", message: "${buildSummary}")
        }
    }

