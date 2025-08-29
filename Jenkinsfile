pipeline {
  agent any

  environment {
    IMAGE_NAME = "calculator"
    FILE_NAME= "Jenkinsfile"
    DRIVER_NAME = "ours"
    PUSH_IMAGE = "false"   // set to "true" to push to local registry
    COMMIT_MASSAGE = "#1"
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
      steps { sh 'tag = VersionNumber (versionNumberString: "pr-1.${BUILDS_ALL_TIME}")'
              sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 992382545251.dkr.ecr.us-east-1.amazonaws.com'
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


 }

}
