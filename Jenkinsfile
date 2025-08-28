pipeline {
  agent any

  environment {
    IMAGE_NAME = "calculator:latest"
    FILE_NAME= "Jenkinsfile"
    DRIVER_NAME = "ours"
    PUSH_IMAGE = "false"   // set to "true" to push to local registry
    COMMIT_MASSAGE = "#1"
  }

  stages {
    stage('Build Image') {
      steps { sh 'docker build -t $IMAGE_NAME .' }
    }
    stage('Unit Tests') {
      steps { sh 'docker run --rm $IMAGE_NAME sh -c "python -m unittest discover -s tests -v"' }
    }
    stage('HealthChecheck Test') {
      steps { sh 'docker run --rm -p 5000:5000 $IMAGE_NAME sh -c "curl -fsS http://localhost:5000/health"' }
    }
   
      }
 }

