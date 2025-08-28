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
    stage('Build Image') {
      when { branch 'dev' }
      steps { sh 'docker build -t dw-cicd-exam/$IMAGE_NAME .' }
    }
    stage('Unit Tests') {
      when { branch 'dev' }
      steps { sh 'docker run --rm $IMAGE_NAME sh -c "python -m unittest discover -s tests -v"' }
    }
    stage('Deploy to production'){
      when { branch 'dev' }
      steps { sh 'docker tag dw-cicd-exam/calculator:latest 992382545251.dkr.ecr.us-east-1.amazonaws.com/dw-cicd-exam/calculator:latest'
              sh 'docker push 992382545251.dkr.ecr.us-east-1.amazonaws.com/dw-cicd-exam/calculator:latest' }
   
    }
 }

}
