pipeline {
  agent any

  environment {
    tag = VersionNumber (versionNumberString: "pr-1.${BUILDS_ALL_TIME}")
    IMAGE_NAME = "calculator"
    FILE_NAME= "Jenkinsfile"
    PRODUCTION_SERVER = "10.0.1.110"
    PRODUCTION_USER = "ec2-user"
    SSH_CREDENTIALS_ID = 'ssh-to-prod-server'
  }

  stages {
    stage('Build Image - CI') {
      when { changeRequest() }
      steps { sh 'docker build -t dw-cicd-exam/$IMAGE_NAME .' }
    }
    stage('Unit Tests - CI') {
      when { changeRequest() }
      steps { sh 'docker run --rm $IMAGE_NAME sh -c "python -m unittest discover -s tests -v"' }
    }
    stage('Deploy to ECR with the correct tagging'){
      when { changeRequest() }
      steps { sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 992382545251.dkr.ecr.us-east-1.amazonaws.com'
              sh 'docker tag dw-cicd-exam/$IMAGE_NAME 992382545251.dkr.ecr.us-east-1.amazonaws.com/dw-cicd-exam/calculator:$tag'
              sh 'docker push 992382545251.dkr.ecr.us-east-1.amazonaws.com/dw-cicd-exam/calculator:$tag' }
    }
     stage('Build Image - CD') {
      when { branch 'main' }
      steps { sh 'docker build -t dw-cicd-exam/$IMAGE_NAME .' }
    }
    stage('Unit Tests - CD') {
      when { branch 'main' }
      steps { sh 'docker run --rm $IMAGE_NAME sh -c "python -m unittest discover -s tests -v"' }
      }
    stage('Deploy to ecr - CD - tagging latest'){
      when { branch 'main' }
      steps { sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 992382545251.dkr.ecr.us-east-1.amazonaws.com'
              sh 'docker tag dw-cicd-exam/$IMAGE_NAME 992382545251.dkr.ecr.us-east-1.amazonaws.com/dw-cicd-exam/calculator:latest'
              sh 'docker push 992382545251.dkr.ecr.us-east-1.amazonaws.com/dw-cicd-exam/calculator:latest' }
    }
    stage('Deploy to production server'){
      when { branch 'main' }
      steps {
        sshagent(credentials: ["$SSH_CREDENTIALS_ID"]) {
          script { 
            sh '''
             [ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
             ssh-keyscan -t rsa,dsa $PRODUCTION_SERVER >> ~/.ssh/known_hosts
             echo "${ssh ec2-user@10.0.1.110 -o RemoteCommand='docker stop calc || true && docker rm calc || true && docker run --name calc -d -p 5000:5000 992382545251.dkr.ecr.us-east-1.amazonaws.com/dw-cicd-exam/calculator:latest'}"
               '''
          }
   }

 }

}
}
}
